
class SearchAlgorithm
  def search(pat, text, all_occurrences=false)
    "implement in subclass"
  end
end

class Naive < SearchAlgorithm
  def search(pat, text, all_occurrences=false)
    step_count = 0
    result_count = 0
    i = 0
    m = pat.length
    n = text.length
    while i <= n-m do
      j = 0
      while j < m && pat[j] == text[i+j] do
        j += 1
      end
      step_count += j == 0 ? 1 : j
      if j == m
        result_count += 1
        unless all_occurrences
          return {step_count: step_count, result_count: result_count }
        end
      end
      i += 1
    end
    return {step_count: step_count, result_count: result_count }
  end
end

class BoyerMoore < SearchAlgorithm
  # http://www.iti.fh-flensburg.de/lang/algorithmen/pattern/bm.htm
  def occ(pat)
    occs = {}
    0.upto(pat.length-1) do |i| 
      occs[pat[i]] = i
    end
    occs
  end

  def good_end(pat)
    i = pat.length
    j = pat.length+1
    fstart_of_broadest_border = Array.new(pat.length+1)
    fstart_of_broadest_border[i] = j
    smove_dist = Array.new(pat.length+1, 0)
    while i > 0
      while j <= pat.length && pat[i-1] != pat[j-1]
        if smove_dist[j] == 0
          smove_dist[j] = j-i
        end
        j = fstart_of_broadest_border[j]
      end
      i -= 1
      j -= 1
      fstart_of_broadest_border[i] = j
    end
    j1 = fstart_of_broadest_border[0]
    0.upto(pat.length) do |i1|
      if smove_dist[i1] == 0 
        smove_dist[i1] = j1
      end
      if i1 == j1
        j1 = fstart_of_broadest_border[j1]
      end
    end
    smove_dist
  end

  def search(pat, text, all_occurrences=false)
    i = 0    
    step_count = 0
    result_count = 0
    shift = good_end(pat)
    occs = occ(pat)
    while i <= text.length - pat.length
      j = pat.length - 1
      while j >= 0 && pat[j] == text[i + j]
        j -= 1
      end
      step_count += j == pat.length-1 ? 1 : pat.length-1-j
      if j < 0
        result_count += 1
        unless all_occurrences
          return {step_count: step_count, result_count: result_count }
        end
        i += shift[0]
      else
        bad_char_shift = occs[text[j+i]] ? occs[text[j+i]] : -1
        i += [shift[j+1], j-bad_char_shift].max
      end
    end
    return {step_count: step_count, result_count: result_count }
  end
end

class InformedHeuristic < SearchAlgorithm
  
  def initialize(heuristics)
    @char_heuristics = heuristics
  end

  def build_pat_heuristics(pat, heuristics)
    # sort the chars by their probabilities and return the indices 
    pat.chars.map.with_index{ |char, i| [heuristics[char],i] }.sort_by{ |entry| entry[0] }.map{ |entry| entry[1] }
  end

  def search(pat, text, all_occurrences=false)
    pat_heuristics = build_pat_heuristics(pat, @char_heuristics)
    step_count = 0
    result_count = 0
    m = pat.length
    n = text.length
    i = 0
    while i <= n-(m-pat_heuristics[0]) do
      j = 0
      while j < m do
        char_index = pat_heuristics[j]
        step_count += 1
        if pat[char_index] != text[i+char_index]
          break
        end
        j += 1
        if j == m
          result_count += 1
          unless all_occurrences
            return {step_count: step_count, result_count: result_count }
          end
        end
      end
      i += 1
    end
    {step_count: step_count, result_count: result_count }
  end
end


naive = Naive.new
boyerm = BoyerMoore.new 
heur = InformedHeuristic.new({"a" => 0.3, "b" => 0.6, "c"=>0.1 })
pat = "abc"
text = "abababbbaabababbbbababbacbbbabcbaabababbbbababbacbbbabcbaabababbbbababbacbbbabcbaabababbbbababbacbbbabcbaabababbbbababbacbbbabcbaabababbbbababbacbbbabcbaabababbbbababbacbbbabcba"
#text = "ababab"
#p Other.prepare_goodsuffix_heuristic(pat)
#p "pat: #{pat}"
#p "occ: #{boyerm.occ('abcd', pat)}"
#p "suf: #{boyerm.suffixes(pat)}"
#p "weak_shift: #{boyerm.weak_shift(pat)}"
#p boyerm.bm_shift(pat)
p boyerm.search(pat, text, all_occurrences=true)
p naive.search(pat, text, all_occurrences=true)
p heur.search(pat, text, all_occurrences=true)
#p naive.search(pat, text, all_occurrences=false)

#pat = "abbabab"
#p "pat: #{pat}"
#p "occ: #{boyerm.occ(pat)}"
#p "good_end: #{boyerm.good_end(pat)}"

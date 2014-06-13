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
    j = fstart_of_broadest_border[0]
    0.upto(pat.length) do |i|
      if smove_dist[i] == 0 
        smove_dist[i] = j
      end
      if i == j
        j = fstart_of_broadest_border[j]
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
  def search(pat, text, all_occurrences=false)
    step_count = 0
    result_count = 0

    return {step_count: step_count, result_count: result_count }
  end
end


naive = Naive.new
boyerm = BoyerMoore.new #doesnt work maybe http://www-igm.univ-mlv.fr/~lecroq/string/node14.html can help
pat = "ab"
text = "ababab"
#text = "ababab"
#p Other.prepare_goodsuffix_heuristic(pat)
#p "pat: #{pat}"
#p "occ: #{boyerm.occ('abcd', pat)}"
#p "suf: #{boyerm.suffixes(pat)}"
#p "weak_shift: #{boyerm.weak_shift(pat)}"
#p boyerm.bm_shift(pat)
p boyerm.search(pat, text, all_occurrences=true)
p naive.search(pat, text, all_occurrences=true)
#p naive.search(pat, text, all_occurrences=false)

#pat = "abbabab"
#p "pat: #{pat}"
p "occ: #{boyerm.occ(pat)}"
p "good_end: #{boyerm.good_end(pat)}"

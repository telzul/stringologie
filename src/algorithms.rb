class SearchAlgorithm
  def search(pat, text, all_occurrences=false)
    "implement in subclass"
  end
end

class BoyerMoore < SearchAlgorithm
  def bm_shift(pat)
    def bed_1(j, s, pat)#match
      for k in (j..pat.length)
        unless s < k || pat[k-s-1] != pat[k-1]
          return false
        end
      end
      true
    end
    def bed_2(j, s, pat) #mismatch
      if s < j
        return pat[j-s] != pat[j]
      else
        return true
      end
    end
    shift = []
    for j in (0..pat.length-1)
      for s in (1..pat.length-1)
        if bed_1(j,s, pat) && bed_2(j,s, pat)
          shift << s
          break
        end
      end
      if j == shift.length
        shift << 1
      end
    end
    shift
  end

  def search(pat, text, all_occurrences=false)
    shift = bm_shift(pat)
    step_count = 0
    result_count = 0
    i = 0
    m = pat.length
    n = text.length
    while i <= n-m do
      j = m
      while j > 0 and pat[j-1] == text[i+j-1] do
        j -= 1
      end
      step_count += j == m ? 1 : m-j
      if j == 0
        result_count += 1
        unless all_occurrences
          return {step_count: step_count, result_count: result_count }
        end
      end
      i += shift[j-1]
    end

    return {step_count: step_count, result_count: result_count }
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

class InformedHeuristic < SearchAlgorithm
  def search(pat, text, all_occurrences=false)
    step_count = 0
    result_count = 0

    return {step_count: step_count, result_count: result_count }
  end
end


naive = Naive.new
boyerm = BoyerMoore.new #doesnt work maybe http://www-igm.univ-mlv.fr/~lecroq/string/node14.html can help
pat = "gcagagag"
text = "abcabacbacbcaabccba"
p boyerm.bm_shift(pat)
p boyerm.search(pat, text, all_occurrences=false)

p naive.search(pat, text, all_occurrences=false)
#p naive.search(pat, text, all_occurrences=false)

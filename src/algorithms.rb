class SearchAlgorithm
    def search(pat, text, all_occurrences=false)
        "implement in subclass"
    end
end

class Other

end

class BoyerMoore < SearchAlgorithm
    
    def occ(alphabetstr, pat)
        occs = {}
        for c in alphabetstr.chars
            occs[c] = -1
        end
        0.upto(pat.length-1) do |i| 
            occs[pat[i]] = i
        end
        occs
    end

    def suffixes(pat)
        suff = Array.new(pat.length)
        suff[pat.length-1] = pat.length
        g = pat.length-1
        (pat.length-2).downto(0) do |i|
            p suff
            p "i: #{i}"
            p "g: #{g}"
            f = i
            if i > g && suff[i+pat.length-1-f] != i-g
                suff[i] = [suff[i+pat.length-1-f], i-g].min
            else
                p "prev f: #{f}"
                f = i
                g = [g, i].min
                p "prev g: #{g}"
                while g >= 0 && pat[g] == pat[g+pat.length-1-f]
                    p g
                    g -= 1
                end
              
                p "f: #{f}"
                p "g: #{g}"
                suff[i] = f-g
            end
        end
        suff
    end

    def bed_1(j, s, pat)#match
        result = true
        for k in (j+1..pat.length)
            p "bed_1, k: #{k}"
            if s > k
                next
            elsif pat[k-s-1] != pat[k-1]
                p "bed_1 pat[k-s-1] (#{k-s-1}, #{pat[k-s-1]}) != pat[k-1] (#{k-1}, #{pat[k-1]})"
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
    
    def weak_shift(pat)
        shift = []
        for j in (0..pat.length-1)
            p "weak_shift, j: #{j}"
            1.upto(pat.length) do |s|
            p "weak_shift, s: #{s}"
                if bed_1(j, s, pat)
                    p "weak_shift, bed_1 true"        
                    shift << s
                    break
                end
            end
        end
        shift
    end

    def bm_shift(pat)
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
pat = "abab"
text = "abcabacbacbcaabccba"
#p Other.prepare_goodsuffix_heuristic(pat)
p "pat: #{pat}"
p "occ: #{boyerm.occ('abcd', pat)}"
p "suf: #{boyerm.suffixes(pat)}"
#p "weak_shift: #{boyerm.weak_shift(pat)}"
#p boyerm.bm_shift(pat)
#p boyerm.search(pat, text, all_occurrences=false)

#p naive.search(pat, text, all_occurrences=false)
#p naive.search(pat, text, all_occurrences=false)

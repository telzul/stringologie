require_relative 'algorithms'

class TestNaive 

  def setup
    @resultss = {}
    @resultsl = {}
  end

  def read_text(name)
    File.open("../txts/#{name}", 'r').read()
  end
  
  def search_pat(textname, pat_short, pat_long)
    text = read_text(textname)
    puts '\n' + textname + ', pattern: ' +pat_short
    @resultss[textname] = @alg.search(pat_short, text, true)
    puts textname + ', pattern: ' +pat_long
    @resultsl[textname] = @alg.search(pat_long, text, true)
  end

  def test_clmet
    @alg = InformedHeuristic.new(parse_heuristics('../heuristics/english'))
    pats = 'that '
    patl = 'that have been made'
    search_pat('clmet_complete', pats, patl)
  end

  def test_small5normal
    @alg = InformedHeuristic.new(parse_heuristics('../heuristics/small5normalheuristics'))
    pats = 'BBDBC'
    patl = 'CBCCBBACCBCCCACCCCBCBCCBCBBDCBBBCBACCCBBBDBCCABCCC'
    search_pat('small5normal', pats, patl)
  end
  
  def test_small5uniform
    @alg = InformedHeuristic.new(uniform_heuristics( 'ABCDE' ))
    pats = 'DBDDA'
    patl = 'ACBEEAACDCCDABCADEDBDDEBBDECBBDACCCAEBEEEBCDDDBDDA'
    search_pat('small5uniform', pats, patl)
  end
  
  def test_big5uniform
    @alg = InformedHeuristic.new(uniform_heuristics( 'ABCDE' ))
    pats = 'DDCAE'
    patl = 'BEBEDDDDBECEEDEBABDCDDBDBDADCECABAAACDDBCBACBDDCAE'
    search_pat('big5uniform', pats, patl)
  end

  def test_big5normal
    @alg = InformedHeuristic.new(parse_heuristics('../heuristics/big5normalheuristics'))
    pats = 'CDEBC'
    patl = 'DCCCBCABBBCCDBCAABDDCCBCDEBCCBACCCCCBDCBCBCCDBBBBC'
    search_pat('big5normal', pats, patl)
  end
  
  def test_small25normal
    @alg = InformedHeuristic.new(parse_heuristics('../heuristics/small25normalheuristics'))
    pats = 'IRYNH'
    patl = 'UNKIOHOHLIRHOLEIUQOMHBPIRYNHLJLOLJMUGCBGJELOGEJCGP'
    search_pat('small25normal', pats, patl)
  end  
  
  def test_small25uniform
    @alg = InformedHeuristic.new(uniform_heuristics( 'ABCDEFGHIJKLMNOPQRSTUVWXY' ))
    pats = 'SGSRE'
    patl = 'BNHWYCEKSMNPAIOASWPHQPWHHQVMJHPCNMLEYIXYUHMRTSGSRE'
    search_pat('small25uniform', pats, patl)
  end 
   
  def test_big25uniform
    @alg = InformedHeuristic.new(uniform_heuristics( 'ABCDEFGHIJKLMNOPQRSTUVWXY' ))
    pats = 'TSMAV'
    patl = 'GYGVSPQQGVOWXTYHCITMRPITJSBTNVODFDAAOQTFNGCOITSMAV'
    search_pat('big25uniform', pats, patl)
  end   

  def test_big25normal
    @alg = InformedHeuristic.new(parse_heuristics('../heuristics/big25normalheuristics'))
    pats = 'KNYKO'
    patl = 'KMHSCNIKPUUMLTNLMRLKOSOKNYKOMIVNKPLMHLPJBNWSSJJLPM'
    search_pat('big25normal', pats, patl)
  end
  
  def parse_heuristics(filename)
    f = File.open(filename, 'r').read
    return eval(f)
  end

  def uniform_heuristics(alphabet)
    Hash[alphabet.chars.collect { |c| [c, 1] }]
  end

  def write_res(filename)
    File.open(filename, 'w') do |file| 
      file.write("short\n")
      @resultss.each { |k, r| file.write("#{k}; #{r[:step_count]}; #{r[:result_count]}\n") }
      file.write("long\n")
      @resultsl.each { |k, r| file.write("#{k}; #{r[:step_count]}; #{r[:result_count]}\n") }
    end
  end

end

t = TestNaive.new
t.setup
t.test_clmet
t.test_big5normal
t.test_big5uniform
t.test_small5normal
t.test_small5uniform
t.test_big25normal
t.test_big25uniform
t.test_small25normal
t.test_small25uniform
t.write_res('res_heuristic')

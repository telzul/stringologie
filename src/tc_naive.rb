require_relative 'algorithms'


class TestNaive
  def setup
    @alg = Naive.new
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
    pats = 'that '
    patl = 'that have been made'
    search_pat('clmet_complete', pats, patl)
  end

  def test_small5normal
    pats = 'BBDBC'
    patl = 'CBCCBBACCBCCCACCCCBCBCCBCBBDCBBBCBACCCBBBDBCCABCCC'
    search_pat('small5normal', pats, patl)
  end
  
  def test_small5uniform
    pats = 'DBDDA'
    patl = 'ACBEEAACDCCDABCADEDBDDEBBDECBBDACCCAEBEEEBCDDDBDDA'
    search_pat('small5uniform', pats, patl)
  end
  
  def test_big5uniform
    pats = 'DDCAE'
    patl = 'BEBEDDDDBECEEDEBABDCDDBDBDADCECABAAACDDBCBACBDDCAE'
    search_pat('big5uniform', pats, patl)
  end

  def test_big5normal
    pats = 'CDEBC'
    patl = 'DCCCBCABBBCCDBCAABDDCCBCDEBCCBACCCCCBDCBCBCCDBBBBC'
    search_pat('big5normal', pats, patl)
  end
  
  def test_small25normal
    pats = 'IRYNH'
    patl = 'UNKIOHOHLIRHOLEIUQOMHBPIRYNHLJLOLJMUGCBGJELOGEJCGP'
    search_pat('small25normal', pats, patl)
  end  
  
  def test_small25uniform
    pats = 'SGSRE'
    patl = 'BNHWYCEKSMNPAIOASWPHQPWHHQVMJHPCNMLEYIXYUHMRTSGSRE'
    search_pat('small25uniform', pats, patl)
  end 
   
  def test_big25uniform
    pats = 'TSMAV'
    patl = 'GYGVSPQQGVOWXTYHCITMRPITJSBTNVODFDAAOQTFNGCOITSMAV'
    search_pat('big25uniform', pats, patl)
  end   
  
  def test_big25normal    
    pats = 'KNYKO'
    patl = 'KMHSCNIKPUUMLTNLMRLKOSOKNYKOMIVNKPLMHLPJBNWSSJJLPM'
    search_pat('big25normal', pats, patl)
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
t.write_res('res_naive')

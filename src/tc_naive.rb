require 'minitest/autorun'
require 'minitest/benchmark'
require_relative 'algorithms'


class TestNaive < MiniTest::Unit::TestCase
  def setup
    @alg = Naive.new
  end

  def read_text(name)
    File.open("../txts/#{name}", 'r').read()
  end
  
  def search_pat(textname, pat_short, pat_long)
    text = read_text(textname)
    p 
    p textname + ', pattern: ' +pat_short
    p @alg.search(pat_short, text, true)
    p ' '
    p textname + ', pattern: ' +pat_long
    p @alg.search(pat_long, text, true)
  end

  def test_clmet
    pats = 'that '
    patl = 'that have been made'
    search_pat('clmet_complete', pats, patl)
  end

  def test_small5normal
    pats = 'ABCCC'
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
    pats = 'CCABC'
    patl = 'CCBACCCCCBDCBCBCCDBBBBCCBBBCCBCCCABBBCBCBBCCCCCABC'
    search_pat('big5normal', pats, patl)
  end
  
  def test_small25normal
    pats = 'MJRLL'
    patl = 'SDJIMJMSHTTTFKRTILQMVPEMLKQQOMIGFNLPKFPNMLJOJMJRLL'
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
    pats = 'IRHGH'
    patl = 'FGPGSMPHFNMMOGLEJMLUCUHMJIQQHRVNIFPWIVLTQMOJGIRHGH'
    search_pat('big25normal', pats, patl)
  end
  

end

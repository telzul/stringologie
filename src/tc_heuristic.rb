require 'minitest/autorun'
require 'minitest/benchmark'
require_relative 'algorithms'


class TestNaive < MiniTest::Unit::TestCase

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
    @alg = InformedHeuristic.new(parse_heuristics('../heuristics/english'))
    pats = 'that '
    patl = 'that have been made'
    search_pat('clmet_complete', pats, patl)
  end

  def test_small5normal
    @alg = InformedHeuristic.new(parse_heuristics('../heuristics/small5normalheuristics'))
    pats = 'ABCCC'
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
    pats = 'CCABC'
    patl = 'CCBACCCCCBDCBCBCCDBBBBCCBBBCCBCCCABBBCBCBBCCCCCABC'
    search_pat('big5normal', pats, patl)
  end
  
  def test_small25normal
    @alg = InformedHeuristic.new(parse_heuristics('../heuristics/small25normalheuristics'))
    pats = 'MJRLL'
    patl = 'SDJIMJMSHTTTFKRTILQMVPEMLKQQOMIGFNLPKFPNMLJOJMJRLL'
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
    @alg = InformedHeuristic.new(uniform_heuristics( 'ABCDEFGHIJKLMNOPQRSTUVWXY' ))
    pats = 'IRHGH'
    patl = 'FGPGSMPHFNMMOGLEJMLUCUHMJIQQHRVNIFPWIVLTQMOJGIRHGH'
    search_pat('big25normal', pats, patl)
  end
  
  def parse_heuristics(filename)
    f = File.open(filename, 'r').read
    return eval(f)
  end

  def uniform_heuristics(alphabet)
    Hash[alphabet.chars.collect { |c| [c, 1] }]
  end


end

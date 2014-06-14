require 'simple-random'

def uniform(count, alphabet_size)
  sr = SimpleRandom.new
  str = ""
  0.upto(count) do
    r = sr.uniform(65,65+alphabet_size)
    str << r.floor.chr
  end
  str
end

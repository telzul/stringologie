require 'simple-random'

def uniform(name, count, alphabet_size)
  sr = SimpleRandom.new
  str = ""
  0.upto(count) do
    r = sr.uniform(65,65+alphabet_size)
    str << r.floor.chr
  end
  File.open(name, 'w') {|file| file.write(str)}
end

def normal(name, count, alphabet_size)
  sr = SimpleRandom.new
  str = ""
  i = 0
  counts = {}
  while i < count 
    r = sr.normal(alphabet_size/2, alphabet_size/2/2.5 )
    if r < 0 || r > alphabet_size;next;end
    r += 65
    c = r.floor.chr
    str << c
    counts[c] = counts[c] ? counts[c] + 1 : 1
    i += 1
  end
  File.open(name, 'w') {|file| file.write(str)}
  File.open(name+"heuristics", 'w') {|file| file.write(counts)}
end

def create_files()
  normal("small5normal", 1000000, 5) 
  uniform("small5uniform", 1000000, 5)
  uniform("small25uniform", 1000000, 25)
  uniform("big5uniform", 100000000, 5)
  uniform("big25uniform", 100000000, 25)
  normal("small25normal", 1000000, 25)
  normal("big5normal", 100000000, 5)
  normal("big25normal", 100000000, 25)
  
end

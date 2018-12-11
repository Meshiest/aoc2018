input = open('input.txt').read.chomp

def react str
  # Use a MASSIVE recursive regex
  # 

  regex = /(?:(aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|gG|Gg|hH|Hh|iI|Ii|jJ|Jj|kK|Kk|lL|Ll|mM|Mm|nN|Nn|oO|Oo|pP|Pp|qQ|Qq|rR|Rr|sS|Ss|tT|Tt|uU|Uu|vV|Vv|wW|Ww|xX|Xx|yY|Yy|zZ|Zz)|(a\g<1>A|A\g<1>a|b\g<1>B|B\g<1>b|c\g<1>C|C\g<1>c|d\g<1>D|D\g<1>d|e\g<1>E|E\g<1>e|f\g<1>F|F\g<1>f|g\g<1>G|G\g<1>g|h\g<1>H|H\g<1>h|i\g<1>I|I\g<1>i|j\g<1>J|J\g<1>j|k\g<1>K|K\g<1>k|l\g<1>L|L\g<1>l|m\g<1>M|M\g<1>m|n\g<1>N|N\g<1>n|o\g<1>O|O\g<1>o|p\g<1>P|P\g<1>p|q\g<1>Q|Q\g<1>q|r\g<1>R|R\g<1>r|s\g<1>S|S\g<1>s|t\g<1>T|T\g<1>t|u\g<1>U|U\g<1>u|v\g<1>V|V\g<1>v|w\g<1>W|W\g<1>w|x\g<1>X|X\g<1>x|y\g<1>Y|Y\g<1>y|z\g<1>Z|Z\g<1>z))/
  
  str.gsub!(regex, '') while str =~ regex

  return str.length
end

def react_stack str
  out = []
  arr = str.chars

  until arr.length == 0
    out << arr.shift
    out.pop 2 if out.length >= 2 and out[-2, 2].map(&:ord).reduce(&:^) == 32
  end

  return out.size
end

puts "Part 1: #{react_stack input}"
puts "Part 2: " + (?a..?z).map{|l|
  react_stack input.gsub(l, '').gsub(l.upcase, '')
}.min.to_s

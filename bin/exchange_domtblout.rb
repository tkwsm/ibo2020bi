#!/usr/bin/ruby

a = []
ARGF.each do |x|
  next if x =~ /^\#/
  a = x.chomp.split("\s")
  b = a[0..21] + [ a[22..-1].join(" ") ]
  c = b[0..3] + b[5..7] + b[9..10] +  b[15..18] + [ b[22] ]
  print "#{ c.join("\t") }\n"
end

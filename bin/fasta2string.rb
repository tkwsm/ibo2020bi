#!/usr/bin/ruby

defline  = ""
sequence = ""
ARGF.each do |x|
  if x =~ /^\>/
    defline  = x.slice(/^\>(.+)/, 1)
  else
    sequence << x.chomp
  end
end

## print "#{defline}\t#{sequence}\n"
print "#{sequence}"

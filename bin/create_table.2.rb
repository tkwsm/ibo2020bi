#!/usr/bin/ruby
#
require 'bio'
include Bio

ff = FlatFile.new(FastaFormat, ARGF)

# print "SID\tSequence\n"
print "Entry_ID\tSequence\n"
ff.each do |e|
  repenspid  = e.definition
  repenspseq = e.aaseq
  next if repenspseq.length < 30
  print "#{repenspid}\t#{repenspseq}\n"
end

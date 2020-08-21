#!/usr/bin/ruby
#
require 'bio'
include Bio

spname = ARGV.pop

ff = FlatFile.new(FastaFormat, ARGF)
ff.each_with_index do |e, i|
#  print e.aaseq.to_fasta( "#{spname}_#{(i+1)}", 60 )
  print e.aaseq.to_fasta( "#{spname}_#{sprintf("%05d", (i+1))}", 60 )
end

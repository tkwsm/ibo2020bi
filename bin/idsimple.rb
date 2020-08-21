#!/usr/bin/ruby
require 'bio'
include Bio

ff = FlatFile.new(FastaFormat, ARGF)
ff.each do |e|
  if e.definition.split("\s").size > 2
    seqid = e.definition.slice(/(\S+)/, 1)
    print e.aaseq.to_fasta( seqid, 60 )
  else
    print e.aaseq.to_fasta( e.definition, 60 )
  end
end

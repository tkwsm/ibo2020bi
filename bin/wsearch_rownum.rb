#!/usr/bin/ruby

# wSearch <- function( q_nuc=1, t_seq="", wsize=100, stepsize=1){

t_seq      = ARGV.shift
wsize    = ( ARGV.shift ).to_i
stepsize = ( ARGV.shift ).to_i

result_array = [[], [], []]
seq_array = t_seq.split("")
subseq_s = 1 - 1
subseq_e = 1 - 1 + wsize - 1
subseq   = ""

while ( subseq_e < t_seq.size ) do 
  subseq = seq_array[subseq_s..subseq_e]
  result_array[0] << subseq_s
  subseq_s += stepsize
  subseq_e  = subseq_s + wsize - 1
end

print result_array[0].size,"\n"




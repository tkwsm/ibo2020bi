#!/usr/bin/ruby

# wSearch <- function( q_nuc=1, t_seq="", wsize=100, stepsize=1){

nuc_id   = ( ARGV.shift ).to_i
seq      = ARGV.shift
wsize    = ( ARGV.shift ).to_i
stepsize = ( ARGV.shift ).to_i

h = { 1 =>   "A", 2 =>   "T", 3 =>   "G", 4 =>   "C",
                  5 => "A+T", 6 => "A+G", 7 => "A+C",
      8 => "T+A",             9 => "T+G",10 => "T+C",
     11 => "G+A",12 => "G+T",            13 => "G+C",
     14 => "C+A",15 => "C+T",16 => "C+G",
     17 =>   "N"                                     }

nuc = h[ nuc_id ]

result_array = []
seq_array = seq.split("")
subseq_s = 1 - 1
subseq_e = 1 - 1 + wsize - 1
subseq   = ""

while ( subseq_e < seq.size ) do 
  subseq = seq_array[subseq_s..subseq_e]
  result_array << [ subseq_s, subseq_e, 
                    subseq.join("").downcase.count( nuc.downcase )  ]
  subseq_s += stepsize
  subseq_e  = subseq_s + wsize - 1
end

# p result_array
# print result_array.join("\t"), "\n"
outstring = ""
result_array.each do |window_data|
  outstring += window_data.join("\t")
  outstring += "\n"
end
print outstring


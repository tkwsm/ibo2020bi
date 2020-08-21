#!/usr/bin/ruby

# wSearch <- function( subseq_s=1, subseq_e=100, q_nuc=1, t_seq="", wsize=100, stepsize=1){

subseq_s = ( ARGV.shift ).to_i - 1
subseq_e = ( ARGV.shift ).to_i - 1
nuc_id   = ( ARGV.shift ).to_i
wsize    = ( ARGV.shift ).to_i
stepsize = ( ARGV.shift ).to_i
t_seq_f  = ARGF

h = { 1 =>   "A", 2 =>   "T", 3 =>   "G", 4 =>   "C",
                  5 =>  "AT", 6 =>  "AG", 7 =>  "AC",
                              8 =>  "TG", 9 =>  "TC",
                                         10 =>  "GC",
     11 =>   "N", 
                 12 => "A-T",13 => "A-G",14 => "A-C",
     15 => "T-A",            16 => "T-G",17 => "T-C",
     18 => "G-A",19 => "G-T",            20 => "G-C",
     21 => "C-A",22 => "C-T",23 => "C-G",
     24 => "(A-T)/(A+T)", 25 => "(C-G)/(C+G)",
     26 => "CpG-Score"  }

def diff_type( nuc_pattern, clean_seq )
  pos_nuc = nuc_pattern.slice(/^(\S)-\S/, 1)
  neg_nuc = nuc_pattern.slice(/^\S-(\S)/, 1)
  pos_count = clean_seq.downcase.count( pos_nuc.downcase)
  neg_count = clean_seq.downcase.count( neg_nuc.downcase)
  return ( pos_count - neg_count )
end

def div_add2diff( nuc_pattern, clean_seq )
  dff_nuc_pattern = nuc_pattern.slice(/\((\S-\S)\)\/\(\S+\S\)/, 1)
  add_nuc_pattern = nuc_pattern.slice(/\(\S-\S\)\/\((\S+\S)\)/, 1)
  dff_count = diff_type( dff_nuc_pattern.downcase, clean_seq )
  add_count = clean_seq.downcase.count( add_nuc_pattern.downcase )

  if add_count == 0.0
    return 0.0
  else
    return ( dff_count.to_f / add_count.to_f )
  end
end

nuc_pattern = h[ nuc_id ]

t_seq_merged = ""
result_array = [[], [], []]
t_seq_f.each do |t_seq|
  next if t_seq =~ /^\>/
  next if t_seq !~ /\S/
  t_seq_merged += t_seq.chomp
end
subseq = t_seq_merged[ subseq_s..subseq_e ]

fragment_s = 1 - 1
fragment_e = 1 - 1 + wsize - 1
fragment   = ""

def calc_cpg_score( fragment )
  cpg_count = fragment.downcase.scan( "cg" ).size
  g_count   = fragment.downcase.count( "g" )
  c_count   = fragment.downcase.count( "c" )
  if (g_count + c_count ) == 0
    cpg_score = 0
  elsif cpg_count == 0
    cpg_score = 0
  else
    cpg_score = ( cpg_count * fragment.length ).to_f / ( g_count * c_count ).to_f
  end
  return cpg_score
end

while ( fragment_e < subseq.size ) do 
  fragment = subseq[ fragment_s..fragment_e ]
  result_array[0] << fragment_s
  result_array[1] << fragment_e
  if    [26].include?(nuc_id)
    result_array[2] << calc_cpg_score( fragment )
  else
  end

  fragment_s += stepsize
  fragment_e  = fragment_s + wsize - 1
end

outstring = result_array[2].join("\t") + "\n"

print outstring


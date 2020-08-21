#!/usr/bin/ruby

nuc_id = ( ARGV.shift ).to_i
seq    = ARGV.shift
clean_seq = ""
if seq == nil
  clean_seq = ""
else
  seq.split("").each{|nuc| clean_seq << nuc if nuc =~ /\S/}
end

h = { 1 =>   "A", 2 =>   "T", 3 =>   "G", 4 =>   "C",
                  5 =>  "AT", 6 =>  "AG", 7 =>  "AC",
                              8 =>  "TG", 9 =>  "TC",
                                         10 =>  "GC",
     11 =>   "N", 
                 12 => "A-T",13 => "A-G",14 => "A-C",
     15 => "T-A",            16 => "T-G",17 => "T-C",
     18 => "G-A",19 => "G-T",            20 => "G-C",
     21 => "C-A",22 => "C-T",23 => "C-G",
     24 => "(A-T)/(A+T)", 25 => "(C-G)/(C+G)"        }

nuc_pattern = h[nuc_id]

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
  return ( dff_count.to_f / add_count.to_f )
end

if    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].include?(nuc_id)
  nuc = nuc_pattern
  print clean_seq.downcase.count( nuc.downcase ), "\n"
elsif [12,13,14, 15,16,17, 18,19,20, 21,22,23].include?(nuc_id)
  print diff_type( nuc_pattern, clean_seq ), "\n"
elsif [24,25].include?(nuc_id)
  print div_add2diff( nuc_pattern, clean_seq ), "\n"
end


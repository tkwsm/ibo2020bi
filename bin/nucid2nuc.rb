#!/usr/bin/ruby

nuc_id   = ( ARGV.shift ).to_i

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

nuc = h[ nuc_id ]

print "\"#{nuc}\"\n"


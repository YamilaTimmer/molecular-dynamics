reinitialize

# inladen
load mutant_protein.pdb, mutant
load wildtype_protein.pdb, wt
align mutant, wt

load mutant_protein.xtc, mutant
load wildtype_protein.xtc, wt

#align/fit

intra_fit mutant
intra_fit wt


select domain1, resi 91-152
select domain2, resi 158-255
select domain3, resi 277-530

color marine, domain1
color purple, domain2
color blue, domain3


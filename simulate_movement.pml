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

select SH3, resi 91-152
select SH2, resi 158-255
select kinase, resi 277-530

color marine, SH3
color purple, SH2
color blue, kinase


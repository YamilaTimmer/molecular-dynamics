reinitialize

# inladen
load mutant_rmsf.pdb, mutant
load wildtype_rmsf.pdb, wt

align wt and name n+ca+c+o, mutant and name n+ca+c+o

load mutant_protein.xtc, mutant
load wildtype_protein.xtc, wt

#align/fit

intra_fit mutant
intra_fit wt
align wt and name n+ca+c+o, mutant and name n+ca+c+o

align mutant, wt and i. 277-530 and not ss L
intra_fit wt and i. 277-530 and not ss L
intra_fit mutant and i. 277-530 and not ss L
align mutant, wt and i. 277-530 and not ss L
clip near, -10
clip near, 10
hide cartoon
sho lines, name c+ca+n
set all_states,
color grey80, wt
color purple, mutant
hide everything, ss L
hide everything, byres ss L
orient visible
png image.png
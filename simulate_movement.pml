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

# breng gebied met mutatie in beeld
#sele region, resi 254-258
#zoom region
#show licorice, region


#stel kijkhoek in voor plek mutatie (get_view/set_view)

# maak plaatje (.png)
#png image.png


#maak filmpje (.mp4)


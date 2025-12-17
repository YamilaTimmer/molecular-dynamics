reinitialize

# inladen
load mutant_rmsf.pdb, mutant
load wildtype_rmsf.pdb, wt
align mutant, wt

load mutant_protein.xtc, mutant
load wildtype_protein.xtc, wt

#align/fit

intra_fit mutant
intra_fit wt
align mutant, wt

# kleur op RMSF
spectrum b, blue_white_red, minimum=0, maximum=10

# stel kijkhoek in
set_view (\
    -0.055591833,    0.468361706,    0.881789327,\
     0.711336672,   -0.601160347,    0.364150196,\
     0.700648606,    0.647490621,   -0.299743593,\
    -0.000592321,    0.000278279, -298.228088379,\
   122.347282410,  114.484191895,   63.868003845,\
   216.337890625,  380.216491699,  -20.000000000 )


# maak plaatje (.png)
ray 1586, 683, async=1
png rmsf_wt_mutant.png

# maak filmpje (gif)
set ray_trace_mode, 1
set antialias, 2
set movie_fps, 30
mset 1 x300
mdo 1:300, roll 1.2

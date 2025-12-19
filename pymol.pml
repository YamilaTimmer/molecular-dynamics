import numpy as np

cmd.set("antialias", 2)
cmd.set("ray_shadows", 1)
cmd.set("light_count", 2)
cmd.set("specular", 0.5)
cmd.set("ray_trace_frames", 1)

load mutant_protein.pdb, mutant
load_traj mutant_protein.xtc, mutant, 1,

load wildtype_protein.pdb, wildtype
load_traj wildtype_protein.xtc, wildtype, 1,

remove resn sol+na+cl

intra_fit mutant
intra_fit wildtype

align mutant, wildtype

color green, wildtype
color magenta, mutant

set_view (\
     0.922900677,    0.199289486,    0.329441577,\
     0.294477135,   -0.916582048,   -0.270468354,\
     0.248056859,    0.346631348,   -0.904608190,\
     0.000013635,   -0.000073875, -249.177322388,\
   102.586784363,   99.647575378,   47.628433228,\
   170.034896851,  328.359497070,  -20.000000000)


ray 3000,2000


# PCA mutant:

remove hydro
mdl = cmd.get_model("mutant")
X = np.array([ cmd.get_model("mutant", state=idx+1).get_coord_list() for idx in range (cmd.count_states("mutant"))])
mean = X.mean(axis=0)
X = (X-mean).reshape((len(X),-1))
vals, vecs = np.linalg.eigh(X@(X.T/len(X)))
loadings = X.T @ vecs[:,::-1]
loadings /= (loadings**2).sum(axis=0, keepdims=True)**0.5
scores = X@loadings
vals = vals[::-1]
L1 = loadings[:,0].reshape((-1,3))
S1 = scores[:,0]
xmin = S1.min() * L1 + mean
xmax = S1.max() * L1 + mean
cmd.load_cgo([u for (xs, ys, zs), (xe, ye, ze) in zip(xmin, xmax) for u in [9.0, xs, ys, zs, xe, ye, ze, 0.1, 0, 0, 1, 1, 0, 0]], "pc1")
M = cmd.get_model("mutant")
for idx, mx in enumerate(mean): M.atom[idx].coord = list(mx)
cmd.load_model(M, "mean")
sho cart
color palecyan, mean

# PCA wildtype:

remove hydro
mdl = cmd.get_model("wildtype")
X = np.array([ cmd.get_model("wildtype", state=idx+1).get_coord_list() for idx in range (cmd.count_states("wildtype"))])
mean = X.mean(axis=0)
X = (X-mean).reshape((len(X),-1))
vals, vecs = np.linalg.eigh(X@(X.T/len(X)))
loadings = X.T @ vecs[:,::-1]
loadings /= (loadings**2).sum(axis=0, keepdims=True)**0.5
scores = X@loadings
vals = vals[::-1]
L1 = loadings[:,0].reshape((-1,3))
S1 = scores[:,0]
xmin = S1.min() * L1 + mean
xmax = S1.max() * L1 + mean
cmd.load_cgo([u for (xs, ys, zs), (xe, ye, ze) in zip(xmin, xmax) for u in [9.0, xs, ys, zs, xe, ye, ze, 0.1, 0, 0, 1, 1, 0, 0]], "pc1")
M = cmd.get_model("wildtype")
for idx, mx in enumerate(mean): M.atom[idx].coord = list(mx)
cmd.load_model(M, "mean")
sho cart
color palecyan, mean


# Animatie PCA:

cmd.disable("pc1")

cmd.hide("everything", "wildtype")
cmd.hide("everything", "mutant")
cmd.show("cartoon", "mean")
cmd.show("cgo", "pc1")

cmd.set("cgo_line_width", 3)
cmd.center("mean")
cmd.zoom("mean")

cmd.mset("1 x360")

cmd.movie.roll(1, 360, 1, axis='y')

# Eerste 20 frames enkel mean structuur te zien:
cmd.mdo(1, "disable pc1")
cmd.mdo(30, "enable pc1")

cmd.movie.produce("mutant_PCA.mp4", mode="ray", quality=100)
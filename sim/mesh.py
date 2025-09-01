import sys

from electroacPy import gtb

meshname = sys.argv[1]

# %% Set global size
base_freq = 300  # use 1kHz or higher normally
lmax = 343 / base_freq / 6
lmid = lmax / 3
lmin = lmax / 9

cad = gtb.meshCAD(f"./meshes/{meshname}.step", minSize=lmin, maxSize=lmax)

cad.addSurfaceGroup("woofers", surface=[14, 15], groupNumber=1)
# cad.addSurfaceGroup("front_face", surface=[16], groupNumber=91, meshSize=lmax)
cad.addSurfaceGroup("bmr", surface=[16], groupNumber=2, meshSize=lmid)
cad.addSurfaceGroup(
    "roundovers", surface=[18, 20, 12, 5, 21, 19, 17, 11], groupNumber=92, meshSize=lmin
)


cad.mesh(f"./meshes/{meshname}")

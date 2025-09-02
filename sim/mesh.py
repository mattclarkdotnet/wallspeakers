import json
import sys

from electroacPy import gtb

meshname = sys.argv[1]
base_freq = int(sys.argv[2])

if base_freq < 10:
    exit("Invalid base frequency, must be >10")

with open(f"./meshes/{meshname}_surfaces.json") as f:
    surfaces = json.load(f)

print(surfaces)

# %% Set global size
lmax = 343 / base_freq / 6
lmid = lmax / 3
lmin = lmax / 9

cad = gtb.meshCAD(f"./meshes/{meshname}.step", minSize=lmin, maxSize=lmax)

cad.addSurfaceGroup("woofers", surface=surfaces["woofers"], groupNumber=1)
cad.addSurfaceGroup("bmr", surface=surfaces["bmr"], groupNumber=2, meshSize=lmid)
cad.addSurfaceGroup(
    "roundovers", surface=surfaces["roundovers"], groupNumber=92, meshSize=lmin
)


cad.mesh(f"./meshes/{meshname}")

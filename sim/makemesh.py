import json
import sys

from electroacPy import gtb

from setup import bmr_bem_group, woofer_bem_group

meshname = sys.argv[1]
max_freq = int(sys.argv[2])

if max_freq < 20:
    exit("Invalid max frequency, must be >20")

with open(f"./meshes/{meshname}_surfaces.json") as f:
    surfaces = json.load(f)

print(surfaces)

# %% Set global size
lmax = 343 / 20 / 6
lmin = 343 / max_freq / 6

lbmr = 343 / max_freq / 6  # model the bmr at max_freq
lwoofer = 343 / min(max_freq, 2000) / 6  # Never model the woffer beyond 2kHz
lround = 343 / max_freq / 6  # Model any roundovers at the max freq

cad = gtb.meshCAD(f"./meshes/{meshname}.step", minSize=lmin, maxSize=lmax)

cad.addSurfaceGroup(
    "woofers",
    surfaces["woofers"],
    groupNumber=woofer_bem_group,
    meshSize=lwoofer,
)
cad.addSurfaceGroup(
    "bmr", surface=surfaces["bmr"], groupNumber=bmr_bem_group, meshSize=lbmr
)


if len(surfaces["roundovers"]) > 0:
    cad.addSurfaceGroup(
        "roundovers", surface=surfaces["roundovers"], groupNumber=92, meshSize=lround
    )


cad.mesh(f"./meshes/{meshname}")

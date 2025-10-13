import sys

import electroacPy as ep
from electroacPy import gtb

from setup import bmr_bem_group, woofer_bem_group

runid = sys.argv[1]
meshname = sys.argv[2]

# %% frequency axis and system initialization
frequency = gtb.freqop.freq_log10(20, 20e3, 120)
system = ep.loudspeakerSystem(frequency)

# # %% Load drivers
system.lem_driver(
    "LW150",
    U=1,  # input voltage
    Le=0.86e-3,
    Re=3.6,
    Cms=0.3e-3,
    Mms=21.9e-3,
    Rms=1.41,
    Bl=6.52,
    Sd=87e-4,
)

system.lem_driver(
    "BMR28",
    U=1,
    Le=0.1e-3,
    Re=3.8,
    Cms=1.0e-3,
    Mms=1.19e-3,
    Rms=0.31,
    Bl=2.9,
    Sd=8.55e-4,
)

# Define enclosures
#
system.lem_enclosure(
    "sealed_LF",
    Vb=3.2e-3,
    Qab=120,
    Qal=60,
    ref2bem=woofer_bem_group,  # this is the group number assigned in mesh.py to the LF surfaces
    setDriver="LW150",
    Nd=2,
    wiring="series",
)

system.lem_enclosure(
    "sealed_BMR",
    Vb=0.4e-3,
    Qab=120,
    Qal=60,
    ref2bem=bmr_bem_group,
    setDriver="BMR28",
    Nd=1,
)

system.enclosure["sealed_LF"].plotXVA()
system.enclosure["sealed_BMR"].plotXVA()

from electroacPy.acousticSim.bem import boundaryConditions

bc = boundaryConditions()
bc.addInfiniteBoundary(
    normal="z", offset=-0.02
)  # offset should be smaller but we want to avoid overlap in the model

system.study_acousticBEM(
    "half_space",
    f"./meshes/{meshname}.msh",
    ["sealed_LF", "sealed_BMR"],
    domain="exterior",
    boundary_conditions=bc,
)

system.study_acousticBEM(
    "free_space",
    f"./meshes/{meshname}.msh",
    ["sealed_LF", "sealed_BMR"],
    domain="exterior",
)

system.run()

# %% save state
ep.save(f"./outputs/study{runid}", system)

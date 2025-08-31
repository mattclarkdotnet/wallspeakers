import electroacPy as ep
from electroacPy import gtb

# %% frequency axis and system initialization
frequency = gtb.freqop.freq_log10(1, 20e3, 125)
system = ep.loudspeakerSystem(frequency)

# %% Load drivers
system.lem_driver(
    "LW150",
    1,
    Le=0.86e-3,
    Re=3.6,
    Cms=0.3e-3,
    Mms=21.9e-3,
    Rms=1.41,
    Bl=6.52,
    Sd=87e-4,
    ref2bem=1,
)
system.lem_driver(
    "BMR28",
    2,
    Le=0.1e-3,
    Re=3.8,
    Cms=1.0e-3,
    Mms=1.19e-3,
    Rms=0.31,
    Bl=2.9,
    Sd=8.55e-4,
    ref2bem=2,
)


# %% Define ported enclosure
system.lem_enclosure(
    "sealed_LF",
    Vb=3.2e-3,
    Qab=120,
    Qal=30,
    ref2bem=1,  # this is the group number assigned in mesh.py to the LF surfaces
    setDriver="LW150",
    Nd=2,
    wiring="parallel",
)

system.lem_enclosure("sealed_BMR", 4e-4, ref2bem=2, setDriver="BMR28")

from electroacPy.acousticSim.bem import boundaryConditions

bc = boundaryConditions()
bc.addInfiniteBoundary(normal="z", offset=0)

system.study_acousticBEM(
    "half_space",
    "./meshes/roundovers.msh",
    ["sealed_LF", "sealed_BMR"],
    domain="exterior",
    boundary_conditions=bc,
)

system.run()

# %% save state
ep.save("./outputs/bem_study", system)

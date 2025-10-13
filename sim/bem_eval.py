import sys

import electroacPy as ep

from setup import step_angle

runid = sys.argv[1]

system = ep.load(f"./outputs/study{runid}")

offset = [0, 0, 0.05]

system.evaluation_polarRadiation(
    ["half_space", "free_space"],
    "polar_hor",
    -180,
    180 - step_angle,
    step_angle,
    on_axis="z",
    direction="x",
    radius=2,
    offset=offset,
)

system.evaluation_polarRadiation(
    ["half_space", "free_space"],
    "polar_ver",
    -180,
    180 - step_angle,
    step_angle,
    on_axis="z",
    direction="y",
    radius=2,
    offset=offset,
)

system.evaluation_pressureField(
    ["free_space", "half_space"],
    "field_hor",
    L1=2.0,
    L2=2.0,
    step=343 / 2500 / 6,
    plane="xz",
    offset=[-1, 0, -1],
)

system.evaluation_pressureField(
    ["free_space", "half_space"],
    "field_ver",
    L1=2.0,
    L2=2.0,
    step=343 / 2500 / 6,
    plane="yz",
    offset=[0, -1, -1],
)

# system.evaluation_sphericalRadiation(
#     "half_space",
#     "spherical",
#     nMic=1000,
#     radius=2,
#     offset=offset,
# )

# system.evaluation_sphericalRadiation(
#     "free_space",
#     "spherical_free",
#     nMic=1000,
#     radius=2,
#     offset=offset,
# )

system.run()
ep.save(f"./outputs/eval{runid}", system)

from electroacPy import gtb

# %% Set global size (1kHz)
lmax = 343 / 1e3 / 6
lmin = lmax / 10  # 10kHz

lmid = 354 / 5e3 / 6

cad = gtb.meshCAD("./roundovers.step", minSize=lmin, maxSize=lmax)

cad.addSurfaceGroup("woofers", surface=[22, 24], groupNumber=1, meshSize=lmax)
cad.addSurfaceGroup("bmr", surface=[23], groupNumber=2, meshSize=lmid)
cad.addSurfaceGroup("front_face", surface=[13], groupNumber=91)
cad.addSurfaceGroup(
    "roundovers", surface=[12, 5, 11, 15, 14, 16, 17, 18], groupNumber=92, meshSize=lmin
)


cad.mesh("./meshes/roundovers")

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(452.12, -975.34, 25.7), 5.4, 13.2, {
      minZ = 24.7,
      maxZ = 27.7,
    }) -- MRPD
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(372.12875366211, -1623.8637695313, 28.76994514465), 10, 5, {
      name="benny14",
      heading=0,
      minZ=28 - 1,
      maxZ=29 + 1
    })--davis
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(856.58923339844, -1311.0611572266, 24.320365905762), 10, 5, {
      heading=0,
      minZ=24 - 1,
      maxZ=25 + 1
    })--sasp
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(1869.4097900391, 3693.7495117188, 33.360683441162), 10, 5, {
      heading=0,
      --debugPoly=true,
      minZ=33 - 1,
      maxZ=33 + 1
    })--sandy pd
    -- exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-34.12, -1054.31, 28.4), 6.0, 12.4, {
    --   minZ = 27.4,
    --   maxZ = 33.0,
    --   heading = 312,
    -- }) -- Hub
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(110.8, 6626.46, 31.89), 7.4, 8, {
      minZ = 30.0,
      maxZ = 36.0,
      heading = 44.0,
    }) -- Paleto
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-458.6, 5980.71, 31.33), 9.8, 5.4, {
      heading=314,
      minZ=29.93,
      maxZ=33.33,
    }) -- Paleto PD
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-809.83, -1507.21, 14.4), 14.2, 13.4, {
      minZ = -0.4,
      maxZ = 6.8,
      heading = 291,
      data = { type = "boats" },
    }) -- Boats
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-1652.52, -3143.0, 13.99), 10, 10, {
      minZ = 12.99,
      maxZ = 16.99,
      heading = 240,
      data = { type = "planes" },
    }) -- Planes
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(2522.64, 2621.78, 37.96), 7.4, 5.8, {
      minZ = 36.96,
      maxZ = 39.96,
      heading = 270,
    }) -- Rex
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(340.39, -570.6, 28.8), 8.4, 4.4, {
      minZ=27.8,
      maxZ=31.8,
      heading = 340,
    }) -- Pillbox
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-1818.56, 2966.05, 32.81), 14.6, 15.6, {
      minZ=31.61,
      maxZ=35.61,
      heading = 330,
      data = { type = "planes" },
    }) 
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-1117.81, -826.58, 3.75), 6.25, 4.0, {
      minZ=2.75,
      maxZ=5.95,
      heading = 36
    })
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(1865.55, 3700.5, 33.37), 13.4, 8, {
      heading=30,
      minZ=32.37,
      maxZ=37.57
    })
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(145.01, -3030.59, 7.04), 6.8, 4.4, {
      heading=0,
      minZ=6.04,
      maxZ=9.24
    })
    --pdm preview bennys
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-33.2, -1053.37, 28.4), 8.0, 9.4, {
      heading=340,
      minZ=25.72,
      maxZ=29.52
    })

    -- tuner catalog
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(135.88, -3030.43, 7.04), 6.4, 4.0, {
      heading = 0,
      minZ = 6.04,
      maxZ = 9.04
    })

    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(124.54, -3047.26, 7.04), 6.4, 4.0, {
      heading = 90,
      minZ = 6.04,
      maxZ = 9.04
    })

    -- Park Rangers PD
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(373.04, 787.57, 186.81), 6.8, 4.6, {
      heading=0,
      minZ=185.31,
      maxZ=189.91
    })

    -- Bogg Bikes
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-1114.66, -1686.83, 4.37), 5.0, 4.2, {
      heading=35,
      minZ=3.17,
      maxZ=6.57
    })

    -- Davis PD
    exports["varial-polyzone"]:AddBoxZone("bennys", vector3(378.69, -1626.95, 28.77), 8.4, 6.4, {
      heading=139,
      minZ=27.97,
      maxZ=31.97
    })

    -- Flight school
    -- disabled the below in favor of civ hub
    -- exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-211.88, -1323.91, 30.89), 8.4, 6.6, {minZ=29.0, maxZ=35.0}) -- pdm
    -- exports["varial-polyzone"]:AddBoxZone("bennys", vector3(731.57, -1088.78, 22.17), 5.0, 11.2, {minZ=21.0, maxZ=28.0}) -- bridge
    --   exports["varial-polyzone"]:AddBoxZone("bennys", vector3(938.14, -970.93, 39.51), 6, 8, {minZ=37.0, maxZ=43.0}) -- tuner
    -- exports["varial-polyzone"]:AddBoxZone("bennys", vector3(-771.46, -233.66, 37.08), 7.4, 8, {minZ=36.0, maxZ=42.0}) -- import
end)

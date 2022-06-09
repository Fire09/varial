By default all exports are set for my server aka "shadow-" make sure to change to you according files.

Add in animation for stage 2 and stage 3 in the client file

Included is the sql make sure to run it in your datbase it has a test bench at the coords: 1008, -2325, 30

Add into target file:

local methtable = {
            518749770,
        }
    
        AddTargetModel(methtable,
            {
                options = {
                    {
                        event = "MethStage1",
                        icon = "fas fa-wrench",
                        label = "Cook Meth??"
                    },
                    {
                        event = "RemoveMeth",
                        icon = "fas fa-wrench",
                        label = "Pickup Table"
                    }
                },
                job = {"all"},
                distance = 1
            }
        )

        AddBoxZone("Get Meth table", vector3(1445.71, 6331.22, 23.9), 1, 1, {
            name="Get Meht tbale",
            heading=0,
            minZ=1,
            maxZ=100
        }, {
            options = {
                {
                    event = 'receivetable',
                    icon = "fas fa-terminal",
                    label = "A Table Seller"
                }
            },
            job = {"all"},
            distance = 1.5
        })

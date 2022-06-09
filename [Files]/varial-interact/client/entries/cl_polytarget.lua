local Entries = {}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'bar:grabDrink' },
    data = {
        {
            id = "bar:grabDrink",
            label = "Grab Drink",
            icon = "circle",
            event = "varial-interact:grabDrink"
        }
    },
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'bar:openFridge' },
    data = {
        {
            id = "bar:openFridge",
            label = "Open Fridge",
            icon = "circle",
            event = "varial-interact:openFridge"
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
  type = 'polytarget',
  group = { 'tbar:chargeCustomer' },
  data = {
      {
          id = "tbar:chargeCustomer",
          label = "Charge Customer",
          icon = "dollar-sign",
          event = "varial-tavern:peekAction",
          parameters = { action = "chargeCustomer" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'polytarget',
  group = { 'tbar:getBag' },
  data = {
      {
          id = "tbar:getBag",
          label = "Grab Bag",
          icon = "circle",
          event = "varial-tavern:peekAction",
          parameters = { action = "getBag" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'polytarget',
  group = { 'tbar:craftToxicMenu' },
  data = {
      {
          id = "tbar:craftToxicMenu",
          label = "Be Toxic",
          icon = "circle",
          event = "varial-tavern:peekAction",
          parameters = { action = "craftToxicMenu" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'townhall:gavel' },
    data = {
        {
            id = "townhall:gavel",
            label = "Use Gavel",
            icon = "circle",
            event = "varial-gov:gavel",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'officer_sign_in' },
    data = {
        {
            id = "officer_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "varial-signin:peekAction",
            parameters = { name = "officer" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'ems_sign_in' },
    data = {
        {
            id = "ems_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "varial-signin:peekAction",
            parameters = { name = "ems" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'ems_volunteer_sign_in' },
    data = {
        {
            id = "ems_volunteer_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "varial-signin:peekAction",
            parameters = { name = "ems_volunteer" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'fire_dept_sign_in' },
    data = {
        {
            id = "fire_dept_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "varial-signin:peekAction",
            parameters = { name = "fire_dept" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'public_services_sign_in' },
    data = {
        {
            id = "public_services_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "varial-signin:peekAction",
            parameters = { name = "public_services" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'driving_instructor_sign_in' },
    data = {
        {
            id = "driving_instructor_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "varial-signin:peekAction",
            parameters = { name = "driving_instructor" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'varial-jail:prison_services' },
    data = {
        {
            id = "prison_services",
            label = "Prison Services",
            icon = "circle",
            event = "varial-jail:services",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

-- casino

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoChipSeller' },
    data = {
        {
            id = "casino_purchase_chips",
            label = "Purchase Chips",
            icon = "circle",
            event = "varial-casino:purchaseChipsAction",
            parameters = { "purchase" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoChipSeller' },
    data = {
        {
            id = "casino_withdraw_cash",
            label = "Cashout (Cash)",
            icon = "wallet",
            event = "varial-casino:purchaseChipsAction",
            parameters = { "withdraw:cash" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoChipSeller' },
    data = {
        {
            id = "casino_withdraw_bank",
            label = "Cashout (Bank)",
            icon = "university",
            event = "varial-casino:purchaseChipsAction",
            parameters = { "withdraw:bank" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoChipSeller' },
    data = {
        {
            id = "casino_transfer_chips",
            label = "Transfer Chips",
            icon = "circle",
            event = "varial-casino:purchaseChipsAction",
            parameters = { "transfer" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoChipSeller' },
    data = {
        {
            id = "casino_transfer_chips",
            label = "Transfer Chips",
            icon = "circle",
            event = "varial-casino:purchaseChipsAction",
            parameters = { "transfer" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}

-- membership

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoMembershipGiver' },
    data = {
        {
            id = "casino_membership_hotel_vip",
            label = "Get Hotel VIP Card",
            icon = "circle",
            event = "varial-casino:getHotelVIPCard",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoMembershipGiver' },
    data = {
        {
            id = "casino_membership_loyalty",
            label = "Get Loyalty Card",
            icon = "circle",
            event = "varial-casino:getLoyaltyCard",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoMembershipGiver' },
    data = {
        {
            id = "casino_membership_giver",
            label = "Purchase Membership ($250)",
            icon = "circle",
            event = "varial-casino:purchaseMembershipCard",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoMembershipGiver' },
    data = {
        {
            id = "casino_membership_giver_emp",
            label = "Get Membership Card",
            icon = "circle",
            event = "varial-casino:purchaseMembership",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}

-- casino drink givers

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoDrinkGiver' },
    data = {
        {
            id = "casino_drink_giver",
            label = "Purchase Drinks",
            icon = "circle",
            event = "varial-casino:purchaseDrinks",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}

-- luckywheel

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'isCasinoLuckyWheel' },
    data = {
        {
            id = "casino_wheel_spin_npc_toggle",
            label = "Toggle Wheel Enabled",
            icon = "circle",
            event = "varial-casino:wheel:toggleEnable",
        },
        {
            id = "casino_wheel_spin_npc_spin",
            label = "Spin Wheel! ($500)",
            icon = "dollar-sign",
            event = "varial-casino:wheel:spinWheel",
        },
        {
            id = "casino_wheel_spin_npc_turbo",
            label = "Turbo Spin! ($5,000)",
            icon = "dollar-sign",
            event = "varial-casino:wheel:spinWheelTurbo",
        },
        {
            id = "casino_wheel_spin_npc_omega",
            label = "Omega Spin! ($20,000)",
            icon = "dollar-sign",
            event = "attempt:spin-in",
        },
        {
            id = "casino_wheel_spin_npc_check",
            label = "Check Spent Amount",
            icon = "dollar-sign",
            event = "varial-casino:wheel:checkSpentAmount",
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
    
}

-- Entries[#Entries + 1] = {
--     type = 'polytarget',
--     group = { 'craftweapons' },
--     data = {
--         {
--             id = 'craftweapons',
--             label = "Open Crafting Bench",
--             icon = "circle",
--             event = "craft:weapons",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 1.5 },
--     }
-- }





Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        if entry.type == 'flag' then
            AddPeekEntryByFlag(entry.group, entry.data, entry.options)
        elseif entry.type == 'model' then
            AddPeekEntryByModel(entry.group, entry.data, entry.options)
        elseif entry.type == 'entity' then
            AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
        elseif entry.type == 'polytarget' then
            AddPeekEntryByPolyTarget(entry.group, entry.data, entry.options)
        end
    end
end)

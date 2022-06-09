AddEventHandler('inventory:saveHoneyItem', function(pSource, pItemId, pAmount, pCost, pTargetInv)





    local user = exports["varial-base"]:getModule("Player"):GetUser(pSource)

    if not user then return end

    exports["varial-log"]:AddLog("Exploiter", user, ("User duped inventory item [%s]x%s"):format(pItemId or 'N/A', pAmount or 'N/A'), { item = pItemId, amount = pAmount, target = pTargetInv})
=======
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSource)

    if not user then return end

    exports["varial-log"]:AddLog("Exploiter", user, ("User duped inventory item [%s]x%s"):format(pItemId or 'N/A', pAmount or 'N/A'), { item = pItemId, amount = pAmount, target = pTargetInv})

=======
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSource)

    if not user then return end

    exports["varial-log"]:AddLog("Exploiter", user, ("User duped inventory item [%s]x%s"):format(pItemId or 'N/A', pAmount or 'N/A'), { item = pItemId, amount = pAmount, target = pTargetInv})

=======
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSource)

    if not user then return end

    exports["varial-log"]:AddLog("Exploiter", user, ("User duped inventory item [%s]x%s"):format(pItemId or 'N/A', pAmount or 'N/A'), { item = pItemId, amount = pAmount, target = pTargetInv})

=======
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSource)

    if not user then return end

    exports["varial-log"]:AddLog("Exploiter", user, ("User duped inventory item [%s]x%s"):format(pItemId or 'N/A', pAmount or 'N/A'), { item = pItemId, amount = pAmount, target = pTargetInv})

=======
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSource)

    if not user then return end

    exports["varial-log"]:AddLog("Exploiter", user, ("User duped inventory item [%s]x%s"):format(pItemId or 'N/A', pAmount or 'N/A'), { item = pItemId, amount = pAmount, target = pTargetInv})

end)
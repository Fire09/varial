Void.Commands = Void.Commands or {}
Void.Commands.Registered = Void.Commands.Registered or {}

AddEventHandler("varial-base:exportsReady", function()
    addModule("Commands", Void.Commands)
end)

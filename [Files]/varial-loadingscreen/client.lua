
local spawn1 = false

AddEventHandler("varial-base:spawnInitialized", function()
	if not spawn1 then
		ShutdownLoadingScreenNui()
		spawn1 = true
	end
end)

--TriggerEvent("varial-base:playerSpawned")
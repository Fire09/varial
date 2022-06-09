RegisterCommand('nots', function()
    -- SendNUIMessage({
    --     openSection = "notify"
    -- })
    local handle = "@Tomato_Man"
    local app = "twat"
    local data = {twat = {text = "Hello RPRP Welcome! asdasdasdasdasdasdasdasdasdasd"}}
    SendNUIMessage({
        openSection = "notify",
         Napp = app, 
         Ndata = data, 
         Nhandle = handle, 
         Ntime = 2500
    })
end)

RegisterCommand('tweat', function()
    local data = {twat = {text = "Hello RPRP Welcome! asdasdasdasdasdasdasdasdasdasd"}}
    local handle = exports["isPed"]:isPed("twitterhandle")
    TriggerServerEvent('Tweet', handle, data)
end)

-- phoneNotification("sms", message,pname)
function phoneNotification(app,data,handle)
    -- print("phone notification is working?",app,"message",data,"handle",handle)
    SendNUIMessage({
        openSection = "notify",
        pNotify = true,
         Napp = app, 
         Ndata = data, 
         Nhandle = handle, 
         Ntime = 2500
    })
end

exports('phoneNotification', phoneNotification)

function phoneCallNotification(app,data,handle)
    -- print("phone notification is working?",app,"message",data,"handle",handle)
    SendNUIMessage({
        openSection = "notify",
        pNotify = false,
         Napp = app, 
         Ndata = data, 
         Nhandle = handle, 
         Ntime = 2500
    })
end

function phonePingNotification(app,handle)
    -- print("PHONE PING NOTIFICATION",app,handle)
    if handle ~= nil then
        SendNUIMessage({
            openSection = "notify",
            pNotify = false,
            Napp = app, 
            Ndata = "sent you a ping.", 
            Nhandle = handle, 
            Ntime = 2500
        })
    end
    -- SendNUIMessage({
    --     openSection = 'pingNotif',
    --     pingName = pCharacterName
    --   })
end

---this is the fucking notifation motherfucker
-- <div class="notification-container" style="display: block;">
--                     <div class="app-bar" style="display: block;">
--                         <div class="icon"><i style="color: #35baf8;" class="rounded-square-icon fab fa-twitter-square twittercs"></i>
--                         </div>
--                         <div class="text name">Twaatter</div>
--                         <p> Just now</p>
--                         <div class="content">
--                            This is only test shit
--                         </div>
--                     </div>
--                 </div>
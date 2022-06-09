local registered = {}

function RegisterInterfaceCallback(name, cb)
  local function interceptCb(data, innerCb)
    cb(data, function(result)
      if result.meta.ok then
        result.meta.message = "done"
      end
      innerCb(result)
    end)
  end
  AddEventHandler(('_vpx_uiReq:%s'):format(name), interceptCb)

  if (GetResourceState("p-int") == "started") then 
    exports["p-int"]:RegisterIntefaceEvent(name) 
  end

  registered[#registered + 1] = name
end

function SendInterfaceMessage(data)
  exports["p-int"]:SendInterfaceMessage(data)
end

function SetInterfaceFocus(hasFocus, hasCursor)
  exports["p-int"]:SetInterfaceFocus(hasFocus, hasCursor)
end

function GetInterfaceFocus()
  return exports["p-int"]:GetInterfaceFocus()
end

AddEventHandler("_vpx_uiReady", function()
  for _, eventName in ipairs(registered) do
    exports["p-int"]:RegisterIntefaceEvent(eventName)
  end
end)
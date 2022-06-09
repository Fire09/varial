const registered = [];

function RegisterUICallback(name, cb) {
    AddEventHandler(`_vui_uiReq:${name}`, cb);

    if (GetResourceState('varial-ui') === 'started') exports['varial-ui'].RegisterUIEvent(name);

    registered.push(name);
}

function SendUIMessage(data) {
    exports['varial-ui'].SendUIMessage(data);
}

function SetUIFocus(hasFocus, hasCursor) {
    exports['varial-ui'].SetUIFocus(hasFocus, hasCursor);
}

function GetUIFocus() {
    return exports['varial-ui'].GetUIFocus();
}

AddEventHandler('_vui_uiReady', () => {
    registered.forEach((eventName) => exports['varial-ui'].RegisterUIEvent(eventName));
});
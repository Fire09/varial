// [ SIDEBAR ] \\

MC.AdminMenu.LoadCategory = function(Category) {
    if (Category == 'Actions') {
        MC.AdminMenu.LoadItems();
    } else if (Category == 'PlayerList') {
        MC.AdminMenu.LoadPlayerList();
    } else if (Category == 'RecentBans') {

    } else if (Category == 'PlayerLogs') {

    } else if (Category == 'Options') {

    }
}

MC.AdminMenu.SidebarAction = function(Action, Element) {
    if (Action == 'DevMode') {
        if ($(Element).hasClass('enabled')) {
            $(Element).removeClass('enabled')
            $.post(`https://${GetParentResourceName()}/Admin/DevMode`, JSON.stringify({
                Toggle: false,
            }));
        } else {
            $(Element).addClass('enabled')
            $.post(`https://${GetParentResourceName()}/Admin/DevMode`, JSON.stringify({
                Toggle: true,
            }));
        }
    } else if (Action == 'PinnedTargets') {
        if ($('.menu-pinned-players').is(':visible')) {
            $('.menu-pinned-players').fadeOut(150);
        } else {
            $('.menu-pinned-players').fadeIn(150);
        }
    } else if (Action == 'ToggleMenu') {
        MC.AdminMenu.Close();
    }
}

// [ CLICKS ] \\
let Timeout = false;
$(document).on('click', ".menu-sidebar-action", function (e) {
    e.preventDefault();

    let NewSidebarCat = $(this);
    let OldSidebarCat = $(this).attr('data-Action');
    if (MC.AdminMenu.Sidebar.Selected != OldSidebarCat && !Timeout) {
        Timeout = true;
        setTimeout(() => {
            Timeout = false;
        }, 300);
        if (NewSidebarCat.hasClass('lower')) {
            MC.AdminMenu.SidebarAction(OldSidebarCat, NewSidebarCat)
        } else {
            let PreviousSidebarCat = $(`[data-Action="${MC.AdminMenu.Sidebar.Selected}"]`);

            MC.AdminMenu.LoadCategory(OldSidebarCat);
            // DebugMessage(`Changing Sidebar Category: ${MC.AdminMenu.Sidebar.Selected} -> ${OldSidebarCat}`)
            
            $(PreviousSidebarCat).removeClass('selected');
            $(NewSidebarCat).addClass('selected');
    
            $(`[data-Page="${MC.AdminMenu.Sidebar.Selected}"`).fadeOut(150);
            $(`[data-Page="${OldSidebarCat}"`).fadeIn(150);
    
            setTimeout(function(){ MC.AdminMenu.Sidebar.Selected = OldSidebarCat; }, 200);
        }
    }
});
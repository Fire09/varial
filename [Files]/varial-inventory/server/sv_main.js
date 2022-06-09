let DroppedInventories = [];
let InUseInventories = [];
let DataEntries = 0;
let hasBrought = [];
let CheckedDeginv = [];
const DROPPED_ITEM_KEEP_ALIVE = 1000 * 60 * 15;

function clean() {
    for (let Row in DroppedInventories) {
        if (new Date(DroppedInventories[Row].lastUpdated + DROPPED_ITEM_KEEP_ALIVE).getTime() < Date.now() && DroppedInventories[Row].used && !InUseInventories[DroppedInventories[Row].name]) {
            emitNet("Inventory-Dropped-Remove", -1, [DroppedInventories[Row].name])
            delete DroppedInventories[Row];
        }
    }
}

setInterval(clean, 20000)


function db(string) {
    exports.oxmysql.execute(string, {}, function(result) {});
}


RegisterServerEvent("server-remove-item")
onNet("server-remove-item", async (player, itemidsent, amount, openedInv) => {
    functionRemoveAny(player, itemidsent, amount, openedInv)
});

RegisterServerEvent("server-update-item")
onNet("server-update-item", async (player, itemidsent, slot, data) => {
    let src = source
    let playerinvname = 'ply-' + player
    let string = `UPDATE user_inventory2 SET information='${data}' WHERE item_id='${itemidsent}' and name='${playerinvname}' and slot='${slot}'`

    exports.oxmysql.execute(string, {}, function() {
        emit("server-request-update-src", player, src)

    });
});

RegisterServerEvent("inventory:degItem")
onNet("inventory:degItem", async (itemID, amount) => {
    exports.oxmysql.execute("UPDATE user_inventory2 SET creationDate = creationDate - :amount WHERE id=:id", {
        amount: amount,
        id: itemID,
    });
});

function functionRemoveAny(player, itemidsent, amount, openedInv) {
    let src = source
    let playerinvname = 'ply-' + player
    let string = `DELETE FROM user_inventory2 WHERE name='${playerinvname}' and item_id='${itemidsent}' LIMIT ${amount}`

    exports.oxmysql.execute(string, {}, function() {
        emit("server-request-update-src", player, src)
    });

}

RegisterServerEvent("request-dropped-items")
onNet("request-dropped-items", async (player) => {
    let src = source;
    emitNet("requested-dropped-items", src, JSON.stringify(Object.assign({}, DroppedInventories)));
});

RegisterServerEvent("server-request-update")
onNet("server-request-update", async (player) => {
    let src = source
    let playerinvname = 'ply-' + player
    let string = `SELECT count(item_id) as amount, id, item_id, name, information, slot, dropped, creationDate FROM user_inventory2 WHERE name = 'ply-${player}' group by item_id`;
    exports.oxmysql.execute(string, {}, function(inventory) {
        emitNet("inventory-update-player", src, [inventory, 0, playerinvname]);

    });
});

RegisterServerEvent("inventory:degItem")
onNet("inventory:degItem", async (pItemid, percent, pItemName, pCid) => {
    let playerinvname = "ply-" + pCid
    exports.oxmysql.execute(`UPDATE user_inventory2 SET creationDate = creationDate - '${percent * 10000000}' WHERE id = '${pItemid}' AND name = '${playerinvname}' AND item_id = '${pItemName}'`, {}, function() {});
  
});


RegisterServerEvent("server-request-update-src")
onNet("server-request-update-src", async (player, src) => {

    let playerinvname = 'ply-' + player
    let string = `SELECT count(item_id) as amount, item_id, id, name, information, slot, dropped, creationDate, MIN(creationDate) as creationDate FROM user_inventory2 WHERE name = '${playerinvname}' group by item_id`; // slot
    exports.oxmysql.execute(string, {}, function(inventory) {
        emitNet("inventory-update-player", src, [inventory, 0, playerinvname]);
    });
});

function makeid(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghikjlmnopqrstuvwxyz'; //abcdef
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

function GenerateInformation(src, player, itemid, itemdata) {
    let data = Object.assign({}, itemdata);
    let returnInfo = "{}"
    return new Promise((resolve, reject) => {
        if (itemid == "") return resolve(returninfo);
        let timeout = 0;
        if (!isNaN(itemid)) {
            var identifier = Math.floor((Math.random() * 99999) + 1)
            if (itemdata && itemdata.fakeWeaponData) {
                identifier = Math.floor((Math.random() * 99999) + 1)
                identifier = identifier.toString()
            }

            // should I remove that?
            let cartridgeCreated = makeid(3) + "-" + Math.floor((Math.random() * 999) + 1);
            returnInfo = JSON.stringify({
                cartridge: cartridgeCreated,
                serial: identifier
            })
            timeout = 1;
            clearTimeout(timeout);
            emit("weapons:set:data", src, cartridgeCreated);
            return resolve(returnInfo);
        } else if (Object.prototype.toString.call(itemid) === '[object String]') {
            switch (itemid.toLowerCase()) {
                case "rentalpapers":
                    returnInfo = JSON.stringify({
                        Plate: itemdata.Plate,
                    })
                    timeout = 1
                    clearTimeout(timeout)
                    return resolve(returnInfo);					
                
                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);                   
                case "idcard":
                    if (itemdata == itemdata.fake) {
                        returnInfo = JSON.stringify({
                            identifier: itemdata,
                            charID,
                            Name: itemdata.first.replace(/[^\w\s]/gi, ''),
                            Surname: itemdata.last.replace(/[^\w\s]/gi, ''),
                            Sex: itemdata.sex,
                            DOB: itemdata.dob
                        })
                        timeout = 1
                        clearTimeout(timeout)
                        return resolve(returnInfo);
                    } else {
                        let string = `SELECT first_name,last_name,gender,dob FROM characters WHERE id = '${player}'`;
                        exports.oxmysql.execute(string, {}, function(result) {
                            returnInfo = JSON.stringify({
                                identifier: player.toString(),
                                Name: result[0].first_name.replace(/[^\w\s]/gi, ''),
                                Surname: result[0].last_name.replace(/[^\w\s]/gi, ''),
                                Sex: result[0].gender,
                                DOB: result[0].dob
                            })
                            timeout = 1
                            clearTimeout(timeout)
                            return resolve(returnInfo);
                        });
                    }
                    break;
                case "casing":
                    returnInfo = JSON.stringify({
                        Identifier: itemdata.identifier,
                        type: itemdata.eType,
                        other: itemdata.other
                    })
                    timeout = 1
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                case "evidence":
                    returnInfo = JSON.stringify({
                        Identifier: itemdata.identifier,
                        type: itemdata.eType,
                        other: itemdata.other
                    })
                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                case "ownerreceipt":
                    returnInfo = JSON.stringify({
                        Price: itemdata.Price,
                        Creator: itemdata.Creator,
                        Comment: itemdata.Comment
                    })
                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                case "pdbadge":
                    exports.oxmysql.query(`SELECT c.first_name, c.last_name, c.job, (CASE WHEN m.image IS NULL THEN "0" ELSE m.image END) AS image, gr.name AS rank_name, (CASE WHEN j.callsign IS NULL THEN "000" ELSE j.callsign END) AS callsign FROM characters c INNER JOIN groups_members gm ON (gm.cid = c.id AND gm.group = c.job) INNER JOIN groups_ranks gr ON (gr.group = c.job AND gr.rank = gm.rank) LEFT JOIN mdt_profiles m ON m.cid = c.id LEFT JOIN jobs_callsigns j ON (j.cid = c.id AND j.job = c.job) WHERE c.id = '${pCid}'`, [], function(result) {
                        returnInfo = JSON.stringify({
                            ["_hideKeys"]: ["image", "job"],
                            ["Nome"]: result[0].first_name.replace(/[^\w\s]/gi, ''),
                            ["Sobrenome"]: result[0].last_name.replace(/[^\w\s]/gi, ''),
                            ["Rank"]: result[0].rank_name,
                            ["Callsign"]: result[0].callsign,
                            ["image"]: result[0].image,
                            ["job"]: result[0].job,
                        })
    
                        return resolve(returnInfo);
                    })
                case "rentalpaper":
                        returnInfo = JSON.stringify({
                            Price: itemdata.Price,
                            Creator: itemdata.Creator,
                            Comment: itemdata.Comment
                        })
                        timeout = 1;
                        clearTimeout(timeout)
                        return resolve(returnInfo);
                case "hacklaptop":
                    returnInfo = JSON.stringify({
                        Uses: itemdata.Uses
                    })
                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                case "receipt":
                    returnInfo = JSON.stringify({
                        Price: itemdata.Price,
                        Creator: itemdata.Creator,
                        Comment: itemdata.Comment
                    })
                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                }
        } else {
            return resolve(returnInfo);q
        }

        setTimeout(() => {
            if (timeout == 0) {
                return resolve(returnInfo);
            }
        }, 500)
    });
}

RegisterServerEvent("server-inventory-give")
onNet("server-inventory-give", async (player, itemid, slot, amount, generateInformation, itemdata, openedInv) => {

    let src = source
    let playerinvname = 'ply-' + player
    let information = "{}"
    let creationDate = Date.now()

    if (itemid == "idcard") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }

    if (itemid == "rentalpapers") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }

    if (itemid == "evidence") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }

    if (itemid == "ownerreceipt") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }

    if (itemid == "rentalpaper") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }
    
    if (itemid == "receipt") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }

    if (itemid == "hacklaptop") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }
    
    if (itemid == "pd_badge") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }

    let values = `('${playerinvname}','${itemid}','${information}','${slot}','${creationDate}')`
    if (amount > 1) {
        for (let i = 2; i <= amount; i++) {
            values = values + `,('${playerinvname}','${itemid}','${information}','${slot}','${creationDate}')`

        }
    }

    let query = `INSERT INTO user_inventory2 (name,item_id,information,slot,creationDate) VALUES ${values};`
    exports.oxmysql.execute(query, {}, function() {
        emit("server-request-update-src", player, src)
    });

});


RegisterServerEvent("server-inventory-refresh")
onNet("server-inventory-refresh", async (player, sauce) => {
    let src = source
    if (!src) {
        src = sauce
    }

    let string = `SELECT count(item_id) as amount, id, name, item_id, information, slot, dropped, creationDate FROM user_inventory2 where name= 'ply-${player}' group by slot`;
    exports.oxmysql.execute(string, {}, function(inventory) {
        if (!inventory) {} else {
            var invArray = inventory;
            var arrayCount = 0;
            var playerinvname = player
            emitNet("inventory-update-player", src, [invArray, arrayCount, playerinvname]);
        }
    })
})

RegisterServerEvent("server-inventory-open")
onNet("server-inventory-open", async (coords, player, secondInventory, targetName, itemToDropArray, sauce) => {

    let src = source

    if (!src) {
        src = sauce
    }

    let playerinvname = 'ply-' + player

    if (InUseInventories[targetName] || InUseInventories[playerinvname]) {

        if (InUseInventories[playerinvname]) {
            if ((InUseInventories[playerinvname] != player)) {
                return
            } else {

            }
        }
        if (InUseInventories[targetName]) {
            if (InUseInventories[targetName] == player) {

            } else {
                secondInventory = "69"
            }
        }
    }
    let string = `SELECT count(item_id) as amount, id, name, item_id, information, slot, dropped, creationDate FROM user_inventory2 where name= 'ply-${player}'  group by slot`;

    exports.oxmysql.execute(string, {}, function(inventory) {

        var invArray = inventory;
        var i;
        var arrayCount = 0;

        InUseInventories[playerinvname] = player;

        if (secondInventory == "1") {

            var targetinvname = targetName

            let string = `SELECT count(item_id) as amount, id, name, item_id, information, slot, dropped, creationDate FROM user_inventory2 WHERE name = '${targetinvname}' group by slot`;
            exports.oxmysql.execute(string, {}, function(inventory2) {
                emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, inventory2, 0, targetinvname, 500, true]);

                InUseInventories[targetinvname] = player
            });
        } else if (secondInventory == "3") {

            let Key = "" + DataEntries + "";
            let NewDroppedName = 'Drop-' + Key;

            DataEntries = DataEntries + 1
            var invArrayTarget = [];
            DroppedInventories[NewDroppedName] = {
                position: {
                    x: coords[0],
                    y: coords[1],
                    z: coords[2]
                },
                name: NewDroppedName,
                used: false,
                lastUpdated: Date.now()
            }


            InUseInventories[NewDroppedName] = player;

            invArrayTarget = JSON.stringify(invArrayTarget)
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, invArrayTarget, 0, NewDroppedName, 500, false]);

        } else if (secondInventory == "13") {

            let Key = "" + DataEntries + "";
            let NewDroppedName = 'Drop-' + Key;
            DataEntries = DataEntries + 1
            for (let Key in itemToDropArray) {
                for (let i = 0; i < itemToDropArray[Key].length; i++) {
                    let objectToDrop = itemToDropArray[Key][i];
                    db(`UPDATE user_inventory2 SET slot='${i+1}', name='${NewDroppedName}', dropped='1' WHERE name='${Key}' and slot='${objectToDrop.faultySlot}' and item_id='${objectToDrop.faultyItem}' `);
                }
            }

            DroppedInventories[NewDroppedName] = {
                position: {
                    x: coords[0],
                    y: coords[1],
                    z: coords[2]
                },
                name: NewDroppedName,
                used: false,
                lastUpdated: Date.now()
            }
            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[NewDroppedName])

        } else if(secondInventory == "2") {
                        
                var targetinvname = targetName;
                var shopArray = ConvenienceStore();
                var shopAmount = 10;
                emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);

            }
            else if(secondInventory == "4")
        {
            var targetinvname = targetName;
            var shopArray = HardwareStore();
            var shopAmount = 11;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
            else if(secondInventory == "5")
            {
                var targetinvname = targetName;
                var shopArray = GunStore();
                var shopAmount = 9;
                emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
        else if(secondInventory == "6")
        {
            var targetinvname = targetName;
            var shopArray = NonGunStore();
            var shopAmount = 7;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }

        else if(secondInventory == "60")
        {
            var targetinvname = targetName;
            var shopArray = RacingThingy();
            var shopAmount = 4;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }

        else if(secondInventory == "45")
        {
            var targetinvname = targetName;
            var shopArray = BurgerShotStore();
            var shopAmount = 10;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }

        else if(secondInventory == "46")
        {
            var targetinvname = targetName;
            var shopArray = PearlsStore();
            var shopAmount = 15;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }

        else if(secondInventory == "1313")
        {
            var targetinvname = targetName;
            var shopArray = MixDrink();
            var shopAmount = 6;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }

        else if(secondInventory == "50")
        {
            var targetinvname = targetName;
            var shopArray = RedCircle();
            var shopAmount = 8;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }

        else if(secondInventory == "54")
        {
            var targetinvname = targetName;
            var shopArray = UwUCafeFridge();
            var shopAmount = 8;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }

        else if(secondInventory == "48")
        {
            var targetinvname = targetName;
            var shopArray = WineryStore();
            var shopAmount = 3;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
            else if(secondInventory == "10")
        {
            var targetinvname = targetName;
            var shopArray = PoliceArmory();
            var shopAmount = 18;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }    

        else if(secondInventory == "198")
        {
            var targetinvname = targetName;
            var shopArray = HuntingShop();
            var shopAmount = 4;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }    

        else if(secondInventory == "47")
        {
            var targetinvname = targetName;
            var shopArray = EMT();
            var shopAmount = 13;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }    
        else if(secondInventory == "14")
        {
            var targetinvname = targetName;
            var shopArray = courthouse();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  
        else if(secondInventory == "18")
        {
            var targetinvname = targetName;
            var shopArray = TacoTruck();
            var shopAmount = 14;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  
        else if(secondInventory == "22")
        {
            var targetinvname = targetName;
            var shopArray = JailFood();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  
        else if(secondInventory == "25")
        {
            var targetinvname = targetName;
            var shopArray = JailMeth();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  
        else if(secondInventory == "12")
        {
            var targetinvname = targetName;
            var shopArray = burgiestore();
            var shopAmount = 8;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }   
            else if(secondInventory == "600")
        {
            var targetinvname = targetName;
            var shopArray = policeveding();
            var shopAmount = 9;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  

        else if(secondInventory == "27")
        {
            var targetinvname = targetName;
            var shopArray = Mechanic();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
        else if(secondInventory == "7777")
        {
            var targetinvname = targetName;
            var shopArray = Mechanic();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
        else if(secondInventory == "141")
        {
            var targetinvname = targetName;
            var shopArray = recycle();
            var shopAmount = 8;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }

            else if(secondInventory == "31")
        {
            var targetinvname = targetName;
            var shopArray = weaponcrafting();
            var shopAmount = 11;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
        else if(secondInventory == "998")
        {
            var targetinvname = targetName;
            var shopArray = slushy();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  


        else if(secondInventory == "921")
        {
            var targetinvname = targetName;
            var shopArray = asslockpick();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  

        else if(secondInventory == "26")
        {
            var targetinvname = targetName;
            var shopArray = assphone();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  
        else if(secondInventory == "1032")
        {
            var targetinvname = targetName;
            var shopArray = HarmonyCraft();
            var shopAmount = 7;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
        else if(secondInventory == "213")
        {
            var targetinvname = targetName;
            var shopArray = CosmicStore();
            var shopAmount = 9;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
        else if(secondInventory == "714")
        {
            var targetinvname = targetName;
            var shopArray = smelter();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
        else if(secondInventory == "997")
        {
            var targetinvname = targetName;
            var shopArray = prison();
            var shopAmount = 7;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  
        else if(secondInventory == "9775")
        {
            var targetinvname = targetName;
            var shopArray = FishingShopMillers();
            var shopAmount = 4;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  
        else if(secondInventory == "42073")
        {
            var targetinvname = targetName;
            var shopArray = DigitelDenShop();
            var shopAmount = 2;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  
        else if(secondInventory == "422")
        {
            var targetinvname = targetName;
            var shopArray = coffeevend();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  

        else if(secondInventory == "4242")
        {
            var targetinvname = targetName;
            var shopArray = foodvend();
            var shopAmount = 2;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  

        
        else if(secondInventory == "421")
        {
            var targetinvname = targetName;
            var shopArray = watervend();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  

        else if(secondInventory == "4292")
        {
            var targetinvname = targetName;
            var shopArray = sodavending();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }  
        

        else if(secondInventory == "7")
        {
            var targetinvname = targetName;
            var shopArray = DroppedItem(itemToDropArray);
            
            itemToDropArray = JSON.parse(itemToDropArray)
            var shopAmount = itemToDropArray.length;
            
            emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
        }
        else {
            emitNet("inventory-update-player", src, [invArray,arrayCount,playerinvname]);
        }
    });
});


RegisterServerEvent("server-inventory-close")
onNet("server-inventory-close", async (player, targetInventoryName) => {
    let src = source
    if (targetInventoryName.startsWith("Trunk"))
        emitNet("toggle-animation", src, false);
        InUseInventories = InUseInventories.filter(item => item != player);
    if (targetInventoryName.indexOf("Drop") > -1 && DroppedInventories[targetInventoryName]) {
        if (DroppedInventories[targetInventoryName].used === false) {
            delete DroppedInventories[targetInventoryName];
        } else {
            let string = `SELECT count(item_id) as amount, item_id, name, information, slot, dropped FROM user_inventory2 WHERE name='${targetInventoryName}' group by item_id `;
            exports.oxmysql.execute(string, {}, function(result) {
                if (result.length == 0 && DroppedInventories[targetInventoryName]) {
                    delete DroppedInventories[targetInventoryName];
                    emitNet("Inventory-Dropped-Remove", -1, [targetInventoryName])
                }
            });
        }
    }

    emit("server-request-update-src", player, source)
});


RegisterServerEvent("server-inventory-remove")
onNet("server-inventory-remove-slot", async (player, itemidsent, amount, slot) => {
    var playerinvname = 'ply-' + player
    db(`DELETE FROM user_inventory2 WHERE name='${playerinvname}' and item_id='${itemidsent}' and slot='${slot}' LIMIT ${amount}`);
});

RegisterServerEvent("server-ragdoll-items")
onNet("server-ragdoll-items", async (player) => {
    let currInventoryName = `ply-${player}`
    let newInventoryName = `wait-${player}`
    db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="mobilephone" `);
    db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="idcard" `);
    await db(`DELETE FROM user_inventory2 WHERE name='${currInventoryName}'`);
    db(`UPDATE user_inventory2 SET name='${currInventoryName}', WHERE name='${newInventoryName}' and dropped=0`);
});

RegisterServerEvent('server-jail-item')
onNet("server-jail-item", async (player, isSentToJail) => {
    let currInventoryName = `${player}`
    let newInventoryName = `${player}`

    if (isSentToJail) {
        currInventoryName = `jail-${player}`
        newInventoryName = `${player}`
    } else {
        currInventoryName = `${player}`
        newInventoryName = `jail-${player}`
    }

    db(`UPDATE user_inventory2 SET name='${currInventoryName}' WHERE name='${newInventoryName}' and dropped=0`);
});

function removecash(pSrc, amount) {
    emit('cash:remove', pSrc, amount)
}


setTimeout(CleanDroppedInventory, 5)

function DroppedItem(itemArray) {
    itemArray = JSON.parse(itemArray)
    var shopItems = [];

    shopItems[0] = {
        item_id: itemArray[0].itemid,
        id: 0,
        name: "shop",
        information: "{}",
        slot: 1,
        amount: itemArray[0].amount
    };

    return JSON.stringify(shopItems);
}

const DEGREDATION_INVENTORY_CHECK = 1000 * 60 * 60;
const DEGREDATION_TIME_BROKEN = 1000 * 60 * 40320;
const DEGREDATION_TIME_WORN = 1000 * 60 * 201000;



RegisterServerEvent("server-inventory-move")
onNet("server-inventory-move", async (player, data, coords) => {
    let src = source
    let targetslot = data[0]
    let startslot = data[1]
    let targetName = data[2].replace(/"/g, "");
    let startname = data[3].replace(/"/g, "");
    let purchase = data[4]
    let itemCosts = data[5]
    let itemidsent = data[6]
    let amount = data[7]
    let crafting = data[8]
    let isWeapon = data[9]
    let PlayerStore = data[10]
    let creationDate = Date.now()

    if ((targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) && DroppedInventories[targetName]) {

        if (DroppedInventories[targetName].used === false) {

            DroppedInventories[targetName] = {
                position: {
                    x: coords[0],
                    y: coords[1],
                    z: coords[2]
                },
                name: targetName,
                used: true,
                lastUpdated: Date.now()
            }
            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[targetName])
        }
    }

    let info = "{}"

    if (purchase) {
        if (isWeapon) {


        }
        info = await GenerateInformation(src, player, itemidsent)
        removecash(src, itemCosts)

        if (!PlayerStore) {
            for (let i = 0; i < parseInt(amount); i++) {

                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
            }
        } else if (crafting) {

            info - await GenerateInformation(src, player, itemidsent)
            for (let i = 0; i < parseInt(amount); i++) {
                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
            }
        } else {
            if (targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) {

                db(`INSERT INTO user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='1' WHERE slot='${startslot}' AND name='${startname}'`);

            } else {
                db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='0' WHERE slot='${startslot}' and name='${startname}'`);

            }
        }
    } else {

        if (crafting == true) {
            info - await GenerateInformation(src, player, itemidsent)
            for (let i = 0; i < parseInt(amount); i++) {
                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
            }
        }

        db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='0' WHERE slot='${startslot}' and name='${startname}'`);

    }
});


function CleanDroppedInventory() {
    onNet("server-ragdoll-items", async (player) => {
        let currInventoryName = `ply-${player}`
        let newInventoryName = player
        db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="mobilephone" `);
        db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="idcard" `);
        db(`UPDATE user_inventory2 SET name='${currInventoryName}', WHERE name='${newInventoryName}' and dropped=0`);
    })
};

RegisterServerEvent("server-inventory-stack")
onNet("server-inventory-stack", async (player, data, coords) => {
    let targetslot = data[0]
    let moveAmount = data[1]
    let targetName = data[2].replace(/"/g, "");
    let src = source
    let originSlot = data[3]
    let originInventory = data[4].replace(/"/g, "");
    let purchase = data[5]
    let itemCosts = data[6]
    let itemidsent = data[7]
    let amount = data[8]
    let crafting = data[9]
    let isWeapon = data[10]
    let PlayerStore = data[11]
    let amountRemaining = data[12]
    let creationDate = Date.now()
    if ((targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) && DroppedInventories[targetName]) {

        if (DroppedInventories[targetName].used === false) {
            DroppedInventories[targetName] = {
                position: {
                    x: coords[0],
                    y: coords[1],
                    z: coords[2]
                },
                name: targetName,
                used: true,
                lastUpdated: Date.now()
            }
            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[targetName])
        }
    }

    let info = "{}"

    if (purchase) {

        if (isWeapon) {
            db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);

        }
        info = await GenerateInformation(src, player, itemidsent)
        removecash(src, itemCosts)

        if (!PlayerStore) {
            for (let i = 0; i < parseInt(amount); i++) {

                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);


            }
        }

        if (PlayerStore) {

            db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetname}', dropped = '0' WHERE slot='${startslot}' AND name='${startname}'`);
        }


    } else if (crafting) {
        info = await GenerateInformation(src, player, itemidsent)
        for (let i = 0; i < parseInt(amount); i++) {

            db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
        }
    } else {
        let string = `SELECT item_id, id FROM user_inventory2 WHERE slot='${originSlot}' and name='${originInventory}' LIMIT ${moveAmount}`;

        exports.oxmysql.execute(string, {}, function(result) {

            var itemids = "0"
            for (let i = 0; i < result.length; i++) {
                itemids = itemids + "," + result[i].id
            }

            if (targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) {
                db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='1' WHERE id IN (${itemids})`);

            } else {
                db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='0' WHERE id IN (${itemids})`);
            }
        });
    }
});

RegisterServerEvent("server-inventory-swap")
onNet("server-inventory-swap", (player, data, coords) => {
    let targetslot = data[0]
    let targetname = data[1].replace(/"/g, "");
    let startslot = data[2]
    let startname = data[3].replace(/"/g, "");

    let string = `SELECT id FROM user_inventory2 WHERE slot='${targetslot}' AND name='${targetname}'`;

    exports.oxmysql.execute(string, {}, function(startid) {
        var itemids = "0"
        for (let i = 0; i < startid.length; i++) {
            itemids = itemids + "," + startid[i].id

        }

        let string = false;
        if (targetname.indexOf("Drop") > -1 || targetname.indexOf("hidden") > -1) {
            string = `UPDATE user_inventory2 SET slot='${targetslot}', name ='${targetname}', dropped='1' WHERE slot='${startslot}' AND name='${startname}'`;
        } else {
            string = `UPDATE user_inventory2 SET slot='${targetslot}', name ='${targetname}', dropped='0' WHERE slot='${startslot}' AND name='${startname}'`;
        }

        exports.oxmysql.execute(string, {}, function(inventory) {
            if (startname.indexOf("Drop") > -1 || startname.indexOf("hidden") > -1) {
                db(`UPDATE user_inventory2 SET slot='${startslot}', name='${startname}', dropped='1' WHERE id IN (${itemids})`);
            } else {
                db(`UPDATE user_inventory2 SET slot='${startslot}', name='${startname}', dropped='0' WHERE id IN (${itemids})`);
            }
        });
    });
});


RegisterServerEvent("inv:playerSpawned")
onNet("inv:playerSpawned", () => {
    db(`DELETE FROM user_inventory2 WHERE name like '%Drop%' OR name like '%Hidden%' OR name like '%trash-1%'`)
    console.log("[varial-inventory] Drops & broken items were deleted.")
});


RegisterServerEvent("inventory:scan")
onNet("inventory:scan", (item_id, creationDate) => {
    if (ConvertQuality(item_id, creationDate) <= 1) {
        emit("inventory:del:shit", item_id, creationDate)
    }
});

const TimeAllowed = 1000 * 60 * 40320; // 28 days,
function ConvertQuality(itemID, creationDate) {
    let StartDate = new Date(creationDate).getTime();
    let DecayRate = itemList[itemID].decayrate;
    let TimeExtra = TimeAllowed * DecayRate;
    let percentDone = 100 - Math.ceil(((Date.now() - StartDate) / TimeExtra) * 100);

    if (DecayRate == 0.0) {
        percentDone = 100;
    }
    if (percentDone < 0) {
        percentDone = 0;
    }
    return percentDone;
}

async function GenerateInformation(pSource, pCid, pItemID, pItemData) {
    return new Promise((resolve, reject) => {
        if (pItemID == "") return resolve("{}");

        let returnInfo = "{}"

        if (!isNaN(pItemID)) {
            returnInfo = JSON.stringify({
                serial: makeid(3) + "-" + Math.floor((Math.random() * 999) + 1),
                ammo: 0,
            })

            return resolve(returnInfo);
        } else if (Object.prototype.toString.call(pItemID) === '[object String]') {
            switch (pItemID.toLowerCase()) {
                case "idcard":
                    if (pItemData.fake) {
                        returnInfo = JSON.stringify(pItemData)

                        return resolve(returnInfo);
                    } else {
                        let gender = "Male"
                        if (exports["varial-base"].getChar(pSource, "gender") === 1) {
                            gender = "Female"
                        }

                        returnInfo = JSON.stringify({
                            ["ID"]: pCid,
                            ["Nome"]: exports["varial-base"].getChar(pSource, "first_name").replace(/[^\w\s]/gi, ''),
                            ["Sobrenome"]: exports["varial-base"].getChar(pSource, "last_name").replace(/[^\w\s]/gi, ''),
                            ["Sexo"]: gender,
                            ["Data de Nascimento"]: exports["varial-base"].getChar(pSource, "dob")
                        })

                        return resolve(returnInfo);
                    }
                case "pdbadge":
                    exports.oxmysql.query(`SELECT c.first_name, c.last_name, c.job, (CASE WHEN m.image IS NULL THEN "0" ELSE m.image END) AS image, gr.name AS rank_name, (CASE WHEN j.callsign IS NULL THEN "000" ELSE j.callsign END) AS callsign FROM characters c INNER JOIN groups_members gm ON (gm.cid = c.id AND gm.group = c.job) INNER JOIN groups_ranks gr ON (gr.group = c.job AND gr.rank = gm.rank) LEFT JOIN mdt_profiles m ON m.cid = c.id LEFT JOIN jobs_callsigns j ON (j.cid = c.id AND j.job = c.job) WHERE c.id = '${pCid}'`, [], function(result) {
                        returnInfo = JSON.stringify({
                            ["_hideKeys"]: ["image", "job"],
                            ["Nome"]: result[0].first_name.replace(/[^\w\s]/gi, ''),
                            ["Sobrenome"]: result[0].last_name.replace(/[^\w\s]/gi, ''),
                            ["Rank"]: result[0].rank_name,
                            ["Callsign"]: result[0].callsign,
                            ["image"]: result[0].image,
                            ["job"]: result[0].job,
                        })

                        return resolve(returnInfo);
                    })
                    break;
                default:
                    if (pItemData === undefined) {
                        pItemData = {}
                    }

                    returnInfo = JSON.stringify(pItemData);

                    return resolve(returnInfo);
            }
        } else {
            return resolve(returnInfo);
        }
    });
};
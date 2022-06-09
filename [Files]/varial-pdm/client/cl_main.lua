RegisterNetEvent('FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop:spawnVehicle')
local vehshop_blips = {}
local financedPlates = {}
local FullBuyPlates = {}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0
local commissionbuy = 0
local insideVehShop = false
local rank = 0

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


local currentCarSpawnLocation = 0
local ownerMenu = false

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 2500, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 2500, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 10000, description = {}, model = "rumpo"},
				{name = "Food Truck New", costs = 2500, description = {}, model = "taco"},
				{name = "Best Bud Van", costs = 20000, description = {}, model = "nspeedo"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 150, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 2500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 2600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 2900, description = {}, model = "tribike3"},
			}
		},		
	}
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
				{name = "Compacts", description = ''},
				{name = "Coupes", description = ''},
				{name = "Sedans", description = ''},
				{name = "Sports", description = ''},
				{name = "Sports Classics", description = ''},
				{name = "Super Cars", description = ''},
				{name = "Muscle", description = ''},
				{name = "Off-Road", description = ''},
				{name = "SUVs", description = ''},
				{name = "Vans", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 2500, description = {}, model = "taxi"},
				{name = "Flatbed", costs = 2500, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 10000, description = {}, model = "rumpo"},
				--{name = "Patriot Stretch", costs = 10000, description = {}, model = "patriot2"},
				--{name = "Stretch", costs = 10000, description = {}, model = "stretch"},
				{name = "Taco Van", costs = 2500, description = {}, model = "taco"},
			}
		},
		["compacts"] = {
			title = "compacts",
			name = "compacts",
			buttons = {	
				{name = "Asbo", costs = 15000, description = {}, model = "asbo"},		
				{name = "Blista", costs = 32000, description = {}, model = "blista"},
				{name = "Blista Kanjo", costs = 78000, description = {}, model = "kanjo"},
				{name = "Brioso R/A", costs = 81000, description = {}, model = "brioso"},
				{name = "Club", costs = 45000, description = {}, model = "club"},
				{name = "Dilettante", costs = 16000, description = {}, model = "Dilettante"},
				{name = "Issi", costs = 20000, description = {}, model = "issi2"},
				{name = "Issi Classic", costs = 26000, description = {}, model = "issi3"},
				{name = "Panto", costs = 20000, description = {}, model = "panto"},
				{name = "Prairie", costs = 35000, description = {}, model = "prairie"},
				{name = "Rhapsody", costs = 22000, description = {}, model = "rhapsody"},
			}
		},
		["coupes"] = {
			title = "coupes",
			name = "coupes",
			buttons = {
				{name = "Cognoscenti Cabrio", costs = 81000, description = {}, model = "cogcabrio"},
				{name = "Exemplar", costs = 35000, description = {}, model = "exemplar"},
				{name = "F620", costs = 83000, description = {}, model = "f620"},
				{name = "Felon", costs = 37000, description = {}, model = "felon"},
				{name = "Felon GT", costs = 45000, description = {}, model = "felon2"},
				{name = "Jackal", costs = 33000, description = {}, model = "jackal"},
				{name = "Oracle", costs = 32000, description = {}, model = "oracle"},
				{name = "Oracle XS", costs = 35000, description = {}, model = "oracle2"},
				{name = "Sentinel", costs = 35000, description = {}, model = "sentinel2"},
				{name = "Sentinel XS", costs = 33000, description = {}, model = "sentinel"},
				{name = "Windsor", costs = 34000, description = {}, model = "windsor"},
				{name = "Windsor Drop", costs = 83000, description = {}, model = "windsor2"},
				{name = "Zion", costs = 83000, description = {}, model = "zion"},
				{name = "Zion Cabrio", costs = 86000, description = {}, model = "zion2"},
			}
		},
		["sports"] = {
			title = "sports",
			name = "sports",
			buttons = {
				{name = "9F", costs = 83000, description = {}, model = "ninef"},
				{name = "9F Cabrio", costs = 90000, description = {}, model = "ninef2"},
				{name = "Alpha", costs = 80000, description = {}, model = "alpha"},
				{name = "Banshee", costs = 71000, description = {}, model = "banshee"},
				{name = "Banshee 900R", costs = 112000, description = {}, model = "banshee2"},
				{name = "Bestia GTS", costs = 75000, description = {}, model = "bestiagts"},
				{name = "Blista Compact", costs = 28000, description = {}, model = "blista2"},
				{name = "Buffalo", costs = 29000, description = {}, model = "buffalo"},
				{name = "Buffalo S", costs = 32000, description = {}, model = "buffalo2"},
				{name = "Carbonizzare", costs = 80000, description = {}, model = "carbonizzare"},
				{name = "Comet", costs = 78000, description = {}, model = "comet2"},
				{name = "Comet Retro Custom", costs = 126000, description = {}, model = "comet3"},
				{name = "Comet Safari", costs = 42000, description = {}, model = "comet4"},
				{name = "Comet SR", costs = 92000, description = {}, model = "comet5"},
				{name = "Coquette", costs = 72000, description = {}, model = "coquette"},
				{name = "Coquette D10", costs = 183000, description = {}, model = "coquette4"},
				{name = "Drafter", costs = 82000, description = {}, model = "drafter"},
				-- {name = "Drift Tampa", costs = 999999, description = {}, model = "tampa2"},
				{name = "Elegy Retro Custom", costs = 110000, description = {}, model = "elegy"},
				{name = "Elegy", costs = 88000, description = {}, model = "elegy2"},
				{name = "Feltzer", costs = 82000, description = {}, model = "feltzer2"},
				{name = "Flash GT", costs = 78000, description = {}, model = "flashgt"},
				{name = "Furore GT", costs = 81000, description = {}, model = "furoregt"},
				{name = "Fusilade", costs = 35000, description = {}, model = "fusilade"},
				{name = "Futo", costs = 28000, description = {}, model = "futo"},
				{name = "GB200", costs = 48000, description = {}, model = "gb200"},
				{name = "Imorgon", costs = 78000, description = {}, model = "imorgon"},
				{name = "Issi Sport", costs = 48000, description = {}, model = "issi7"},
				{name = "Itali GTO", costs = 175000, description = {}, model = "italigto"},
				{name = "Jester", costs = 83000, description = {}, model = "jester"},
				{name = "Jester Classic", costs = 88000, description = {}, model = "jester3"},
				{name = "Jugular", costs = 88000, description = {}, model = "jugular"},
				-- {name = "Khamelion", costs = 999999, description = {}, model = "khamelion"},
				{name = "Komoda", costs = 75000, description = {}, model = "komoda"},
				{name = "Kuruma", costs = 36000, description = {}, model = "kuruma"},
				{name = "Locust", costs = 128000, description = {}, model = "locust"},
				{name = "Lynx", costs = 82000, description = {}, model = "lynx"},
				{name = "Massacro", costs = 85000, description = {}, model = "massacro"},
				{name = "Neo", costs = 134000, description = {}, model = "neo"},
				{name = "Neon", costs = 105000, description = {}, model = "neon"},
				{name = "Omnis", costs = 48000, description = {}, model = "omnis"},
				{name = "Paragon R", costs = 84000, description = {}, model = "paragon"},
				{name = "Pariah", costs = 81000, description = {}, model = "pariah"},
				{name = "Penumbra", costs = 81000, description = {}, model = "penumbra"},
				{name = "Penumbra FF", costs = 125000, description = {}, model = "penumbra2"},
				{name = "Raiden", costs = 100000, description = {}, model = "raiden"},
				{name = "Rapid GT", costs = 80000, description = {}, model = "rapidgt"},
				{name = "Rapid GT Cabrio", costs = 83000, description = {}, model = "rapidgt2"},
				-- {name = "Raptor", costs = 999999, description = {}, model = "raptor"},
				{name = "Revolter", costs = 95000, description = {}, model = "revolter"},
				-- {name = "Ruston", costs = 999999, description = {}, model = "ruston"},
				{name = "Schafter V12", costs = 40000, description = {}, model = "schafter3"},
				{name = "Schlagen GT", costs = 165000, description = {}, model = "schlagen"},
				-- {name = "Schwarzer", costs = 999999, description = {}, model = "schwarzer"},
				{name = "Sentinel Classic", costs = 37000, description = {}, model = "sentinel3"},
				{name = "Seven 70", costs = 160000, description = {}, model = "seven70"},
				-- {name = "Specter", costs = 999999, description = {}, model = "specter"},
				{name = "Specter Custom", costs = 91000, description = {}, model = "specter2"},
				{name = "Streiter", costs = 31000, description = {}, model = "streiter"},
				{name = "Sugoi", costs = 39000, description = {}, model = "sugoi"},
				{name = "Sultan", costs = 38000, description = {}, model = "sultan"},
				{name = "Sultan Classic", costs = 99000, description = {}, model = "sultan2"},				
				{name = "Sultan RS", costs = 130000, description = {}, model = "sultanrs"},
				{name = "Surano", costs = 82000, description = {}, model = "surano"},
				{name = "Tropos Rallye", costs = 48000, description = {}, model = "tropos"},
				{name = "V-STR", costs = 90000, description = {}, model = "vstr"},
				{name = "Verlierer", costs = 75000, description = {}, model = "verlierer2"},
			}
		},
		["sportsclassics"] = {
			title = "sports classics",
			name = "sportsclassics",
			buttons = {
				{name = "190z", costs = 83000, description = {}, model = "z190"},
				{name = "Casco", costs = 45000, description = {}, model = "casco"},
				{name = "Cheburek", costs = 40000, description = {}, model = "cheburek"},
				{name = "Cheetah Classic", costs = 92000, description = {}, model = "cheetah2"},
				{name = "Coquette Classic", costs = 45000, description = {}, model = "coquette2"},
				{name = "Dynasty", costs = 20000, description = {}, model = "dynasty"},
				-- {name = "Fagaloa", costs = 999999, description = {}, model = "fagaloa"},
				-- {name = "Franken Stange", costs = 999999, description = {}, model = "btype2"},
				{name = "GT500", costs = 44000, description = {}, model = "gt500"},
				{name = "Infernus Classic", costs = 110000, description = {}, model = "infernus2"},
				{name = "JB 700", costs = 55000, description = {}, model = "jb700"},
				{name = "Mamba", costs = 68000, description = {}, model = "mamba"},
				-- {name = "Manana", costs = 999999, description = {}, model = "manana"},
				-- {name = "Michelli GT", costs = 999999, description = {}, model = "michelli"},
				{name = "Nebula Turbo", costs = 78000, description = {}, model = "nebula"},
				-- {name = "Peyote", costs = 999999, description = {}, model = "peyote"},
				-- {name = "Peyote Custom", costs = 999999, description = {}, model = "peyote3"},
				{name = "Pigalle", costs = 20000, description = {}, model = "pigalle"},
				{name = "Rapid GT Classic", costs = 45000, description = {}, model = "rapidgt3"},
				{name = "Retinue", costs = 48000, description = {}, model = "retinue"},
				{name = "Retinue MKII", costs = 51000, description = {}, model = "retinue2"},
				-- {name = "Roosevelt", costs = 999999, description = {}, model = "btype"},
				{name = "Roosevelt Valor", costs = 70000, description = {}, model = "btype3"},
				{name = "Savestra", costs = 34000, description = {}, model = "savestra"},
				{name = "Stinger", costs = 44000, description = {}, model = "stinger"},
				{name = "Stinger GT", costs = 48000, description = {}, model = "stingergt"},
				{name = "Stirling GT", costs = 44000, description = {}, model = "feltzer3"},
				{name = "Swinger", costs = 80000, description = {}, model = "swinger"},
				-- {name = "Torero", costs = 999999, description = {}, model = "torero"},
				-- {name = "Tornado", costs = 999999, description = {}, model = "tornado"},
				-- {name = "Tornado Cabrio", costs = 999999, description = {}, model = "tornado2"},
				{name = "Tornado Custom", costs = 44000, description = {}, model = "tornado5"},
				{name = "Turismo Classic", costs = 125000, description = {}, model = "turismo2"},
				{name = "Viseris", costs = 85000, description = {}, model = "viseris"}, 
				-- {name = "Z-Type", costs = 999999, description = {}, model = "ztype"},
				{name = "Zion Classic", costs = 33000, description = {}, model = "zion3"},
			}
		},
		["supercars"] = {
			title = "super cars",
			name = "supercars",
			buttons = {
				{name = "Entity XXR", costs = 255000, description = {}, model = "entity2"},
				{name = "T20", costs = 220000, description = {}, model = "t20"},
				{name = "Vacca", costs = 155000, description = {}, model = "vacca"},
				{name = "Voltic", costs = 125000, description = {}, model = "voltic"},
				{name = "Reaper", costs = 170000, description = {}, model = "reaper"},
				{name = "Itali GTB Custom", costs = 190000, description = {}, model = "italigtb2"},
				{name = "Furia", costs = 215000, description = {}, model = "furia"},
				{name = "XA-21", costs = 200000, description = {}, model = "xa21"},
				{name = "FMJ", costs = 180000, description = {}, model = "fmj"},
			}
		},
		["muscle"] = {
			title = "muscle",
			name = "muscle",
			buttons = {
				{name = "Blade", costs = 65000, description = {}, model = "blade"},
				{name = "Buccaneer", costs = 38000, description = {}, model = "buccaneer"},
				{name = "Buccaneer Lowrider", costs = 51000, description = {}, model = "buccaneer2"},
				{name = "Chino", costs = 26000, description = {}, model = "chino"},
				{name = "Chino Lowrider", costs = 30000, description = {}, model = "chino2"},
				{name = "Clique", costs = 65000, description = {}, model = "clique"},
				{name = "Coquette BlackFin", costs = 48000, description = {}, model = "coquette3"},
				{name = "Deviant", costs = 105000, description = {}, model = "deviant"},
				{name = "Dominator", costs = 83000, description = {}, model = "dominator"},
				{name = "Dominator GTX", costs = 144000, description = {}, model = "dominator3"},
				{name = "Drift Yosemite", costs = 75000, description = {}, model = "yosemite2"},
				{name = "Dukes", costs = 86000, description = {}, model = "dukes"},
				{name = "Elliie", costs = 87000, description = {}, model = "ellie"},
				{name = "Faction", costs = 41000, description = {}, model = "faction"},
				{name = "Faction Lowrider", costs = 51000, description = {}, model = "faction2"},
				{name = "Faction Lowrider DONK", costs = 55000, description = {}, model = "faction3"},
				{name = "Gauntlet", costs = 83000, description = {}, model = "gauntlet"},
				{name = "Gauntlet Classic", costs = 85000, description = {}, model = "gauntlet3"},
				{name = "Gauntlet Classic Custom", costs = 92000, description = {}, model = "gauntlet5"},
				{name = "Gauntlet Hellfire", costs = 130000, description = {}, model = "gauntlet4"},
				{name = "Hermes", costs = 70000, description = {}, model = "hermes"},
				-- {name = "Hotknife", costs = 999999, description = {}, model = "hotknife"},
				{name = "Hustler", costs = 40000, description = {}, model = "hustler"},
				--{name = "Impaler", costs = 999999, description = {}, model = "impaler"},
				{name = "Lost Slamvan", costs = 55000, description = {}, model = "slamvan2"},
				-- {name = "Manana Custom", costs = 999999, description = {}, model = "manana2"},
				{name = "Moonbeam", costs = 20000, description = {}, model = "moonbeam"},
				{name = "Moonbeam Custom", costs = 35000, description = {}, model = "moonbeam2"},
				{name = "Nightshade", costs = 80000, description = {}, model = "nightshade"},
				{name = "Peyote Gasser", costs = 85000, description = {}, model = "peyote2"},
				{name = "Phoenix", costs = 40000, description = {}, model = "phoenix"},
				{name = "Picador", costs = 41000, description = {}, model = "picador"},
				--{name = "Rat-Truck", costs = 999999, description = {}, model = "ratloader2"},
				{name = "Ruiner", costs = 62000, description = {}, model = "ruiner"},
				{name = "Sabre Turbo", costs = 82000, description = {}, model = "sabregt"},
				{name = "Sabre Turbo Custom", costs = 44000, description = {}, model = "sabregt2"},
				{name = "Slamvan", costs = 85000, description = {}, model = "slamvan"},
				{name = "Slamvan Custom", costs = 90000, description = {}, model = "slamvan3"},
				-- {name = "Stallion", costs = 999999, description = {}, model = "stalion"},
				{name = "Tampa", costs = 81000, description = {}, model = "tampa"},
				{name = "Tornado Lowrider", costs = 25000, description = {}, model = "tornado5"},
				{name = "Tulip", costs = 42000, description = {}, model = "tulip"},
				{name = "Vamos", costs = 84000, description = {}, model = "vamos"},
				{name = "Vigero", costs = 42000, description = {}, model = "vigero"},
				{name = "Virgo", costs = 42000, description = {}, model = "virgo"},
				-- {name = "Virgo Classic", costs = 999999, description = {}, model = "virgo3"},
				{name = "Virgo Classic Custom", costs = 55000, description = {}, model = "virgo2"},
				{name = "Voodoo Lowrider", costs = 25000, description = {}, model = "voodoo"},
				{name = "Yosemite", costs = 84000, description = {}, model = "yosemite"},			
			}
		},
		["offroad"] = {
			title = "off-road",
			name = "off-road",
			buttons = {
				{name = "Bifta", costs = 31000, description = {}, model = "bifta"},
				{name = "Blazer", costs = 7000, description = {}, model = "blazer"},
				{name = "Blazer Sport", costs = 21000, description = {}, model = "blazer4"},
				{name = "Bodhi", costs = 16000, description = {}, model = "bodhi2"},
				{name = "Brawler", costs = 24000, description = {}, model = "brawler"},
				{name = "Caracara", costs = 31000, description = {}, model = "caracara2"},
				{name = "Desert Raid", costs = 41000, description = {}, model = "trophytruck2"},
				{name = "Dubsta 6x6", costs = 50000, description = {}, model = "dubsta3"},
				{name = "Dune Buggy", costs = 20000, description = {}, model = "dune"},
				{name = "Everon", costs = 43000, description = {}, model = "everon"},
				{name = "Freecrawler", costs = 48000, description = {}, model = "freecrawler"},
				{name = "Guardian", costs = 32000, description = {}, model = "guardian"},
				{name = "Hellion", costs = 50000, description = {}, model = "hellion"},
				-- {name = "Injection", costs = 999999, description = {}, model = "bfinjection"},
				{name = "Kamacho", costs = 31000, description = {}, model = "kamacho"},
				{name = "Lifted Mesa", costs = 35000, description = {}, model = "mesa3"},
				{name = "Outlaw", costs = 40000, description = {}, model = "outlaw"},
				{name = "Rebel", costs = 21000, description = {}, model = "rebel2"},
				{name = "Riata", costs = 35000, description = {}, model = "riata"},
				{name = "Sandking", costs = 35000, description = {}, model = "sandking"},
				{name = "Trophy Truck", costs = 42000, description = {}, model = "trophytruck"},
				{name = "Vagrant", costs = 41000, description = {}, model = "vagrant"},
				-- {name = "Yosemite Rancher", costs = 999999, description = {}, model = "yosemite3"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Baller", costs = 20000, description = {}, model = "baller"},
				{name = "Baller 2", costs = 25000, description = {}, model = "baller2"},
				{name = "Baller LE", costs = 41000, description = {}, model = "baller3"},
				{name = "Baller LE LWB", costs = 45000, description = {}, model = "baller4"},
				--{name = "BeeJay XL", costs = 999999, description = {}, model = "bjxl"},
				-- {name = "Cavalcade", costs = 999999, description = {}, model = "cavalcade"},
				{name = "Cavalcade 2", costs = 30000, description = {}, model = "cavalcade2"},
				{name = "Contender", costs = 55000, description = {}, model = "contender"},
				{name = "Dubsta", costs = 40000, description = {}, model = "dubsta"},
				-- {name = "FQ 2", costs = 999999, description = {}, model = "fq2"},
				{name = "Granger", costs = 26000, description = {}, model = "granger"},
				{name = "Gresley", costs = 35000, description = {}, model = "gresley"},
				-- {name = "Habanero", costs = 999999, description = {}, model = "habanero"},
				{name = "Huntley S", costs = 42000, description = {}, model = "huntley"},
				{name = "Landstalker", costs = 26000, description = {}, model = "landstalker"},
				{name = "Landstalker XL", costs = 32000, description = {}, model = "landstalker2"},
				{name = "Mesa", costs = 29000, description = {}, model = "mesa"},
				{name = "Novak", costs = 42000, description = {}, model = "novak"},
				{name = "Patriot", costs = 25000, description = {}, model = "patriot"},
				{name = "Radius", costs = 22000, description = {}, model = "radi"},
				{name = "Rebla", costs = 40000, description = {}, model = "rebla"},
				{name = "Rocoto", costs = 40000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 21000, description = {}, model = "seminole"},
				--{name = "Seminole Frontier", costs = 999999, description = {}, model = "seminole2"},
				-- {name = "Serrano", costs = 999999, description = {}, model = "serrano"},
				{name = "Toros", costs = 65000, description = {}, model = "toros"},
				{name = "XLS", costs = 40000, description = {}, model = "xls"},
			}
		},
		["vans"] = {
			title = "vans",
			name = "vans",
			buttons = {
				{name = "Bison", costs = 22000, description = {}, model = "bison"},
				{name = "Bobcat XL", costs = 25000, description = {}, model = "bobcatxl"},
				{name = "Camper", costs = 20000, description = {}, model = "camper"},
				{name = "Gang Burrito", costs = 20000, description = {}, model = "gburrito2"},
				{name = "Gang Burrito (Lost MC)", costs = 15000, description = {}, model = "gburrito"},
				{name = "Journey", costs = 15000, description = {}, model = "journey"},
				{name = "Minivan", costs = 20000, description = {}, model = "minivan"},
				{name = "Minivan Custom", costs = 50000, description = {}, model = "minivan2"},
				{name = "Paradise", costs = 18000, description = {}, model = "paradise"},
				--{name = "Pony", costs = 999999, description = {}, model = "pony"},
				--{name = "Rumpo", costs = 999999, description = {}, model = "rumpo"},
				{name = "Rumpo Custom", costs = 25000, description = {}, model = "rumpo3"},
				{name = "Surfer", costs = 15000, description = {}, model = "surfer"},
				{name = "Youga", costs = 24000, description = {}, model = "youga"},
				{name = "Youga Classic", costs = 21000, description = {}, model = "youga2"},
				{name = "Youga Classic 4x4", costs = 40000, description = {}, model = "youga3"},
			}
		},
		["sedans"] = {
			title = "sedans",
			name = "sedans",
			buttons = {
				{name = "Asea", costs = 16000, description = {}, model = "asea"},
				{name = "Asterope", costs = 20000, description = {}, model = "asterope"},
				{name = "Cognoscenti 55", costs = 35000, description = {}, model = "cognoscenti"},
				{name = "Emperor", costs = 15000, description = {}, model = "emperor"},
				{name = "Fugitive", costs = 32000, description = {}, model = "fugitive"},
				{name = "Glendale", costs = 20000, description = {}, model = "glendale"},
				-- {name = "Glendale Custom", costs = 999999, description = {}, model = "glendale2"},
				-- {name = "Ingot", costs = 999999, description = {}, model = "ingot"},
				{name = "Intruder", costs = 35000, description = {}, model = "intruder"},
				{name = "Premier", costs = 32000, description = {}, model = "premier"},
				--{name = "Primo", costs = 999999, description = {}, model = "primo"},
				{name = "Primo Custom", costs = 35000, description = {}, model = "primo2"},
				{name = "Regina", costs = 15000, description = {}, model = "regina"},
				{name = "Schafter", costs = 34000, description = {}, model = "schafter2"},
				{name = "Stafford", costs = 86000, description = {}, model = "stafford"},
				{name = "Stanier", costs = 22000, description = {}, model = "stanier"},
				{name = "Stratum", costs = 33000, description = {}, model = "stratum"},
				{name = "Super Diamond", costs = 41000, description = {}, model = "superd"},
				{name = "Surge", costs = 60000, description = {}, model = "surge"},
				{name = "Tailgater", costs = 38000, description = {}, model = "tailgater"},
				{name = "Tornado", costs = 18000, description = {}, model = "tornado"},
				{name = "Warrener", costs = 25000, description = {}, model = "warrener"},
				{name = "Washington", costs = 23000, description = {}, model = "washington"},
			}
		},
		["motorcycles"] = {
			title = "MOTORCYCLES",
			name = "motorcycles",
			buttons = {
				{name = "Akuma", costs = 35000, description = {}, model = "AKUMA"}, 
				{name = "Avarus", costs = 30000, description = {}, model = "avarus"},
				{name = "Bagger", costs = 30000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 25000, description = {}, model = "bati"},
				{name = "BF400", costs = 20000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 35000, description = {}, model = "carbonrs"},
				{name = "Chimera", costs = 40000, description = {}, model = "chimera"},
				--{name = "Cliffhanger", costs = 999999, description = {}, model = "cliffhanger"},
				{name = "Daemon (Lost)", costs = 25000, description = {}, model = "daemon"},
				{name = "Daemon", costs = 30000, description = {}, model = "daemon2"},
				{name = "Defiler", costs = 40000, description = {}, model = "defiler"},
				--{name = "Diabolus", costs = 999999, description = {}, model = "diablous"},
				--{name = "Diabolus Custom", 999999 = 38000, description = {}, model = "diablous2"},
				{name = "Double-T", costs = 40000, description = {}, model = "double"},
				{name = "Enduro", costs = 20000, description = {}, model = "enduro"},
				{name = "Esskey", costs = 30000, description = {}, model = "esskey"},
				{name = "Faggio", costs = 5000, description = {}, model = "faggio2"},
				--{name = "Faggio Mod", costs = 999999, description = {}, model = "faggio3"},
				{name = "Faggio Sport", costs = 5000, description = {}, model = "faggio"},
				--{name = "FCR 1000", costs = 999999, description = {}, model = "fcr"},
				--{name = "FCR 1000 Custom", costs = 999999, description = {}, model = "fcr2"},
				{name = "Gargoyle", costs = 35000, description = {}, model = "gargoyle"},
				{name = "Hakuchou", costs = 56000, description = {}, model = "hakuchou"},
				{name = "Hakuchou Drag", costs = 63000, description = {}, model = "hakuchou2"},
				{name = "Hexer", costs = 35000, description = {}, model = "hexer"},
				{name = "Innovation", costs = 35000, description = {}, model = "innovation"},
				{name = "Lectro", costs = 35000, description = {}, model = "lectro"},
				{name = "Manchez", costs = 25000, description = {}, model = "manchez"},
				{name = "Nightblade", costs = 48000, description = {}, model = "nightblade"},
				{name = "Nemesis", costs = 25000, description = {}, model = "nemesis"},
				{name = "PCJ-600", costs = 30000, description = {}, model = "pcj"},
				-- {name = "Rampant Rocket", costs = 999999, description = {}, model = "rrocket"},
				-- {name = "Rat Bike", costs = 999999, description = {}, model = "ratbike"},
				{name = "Ruffian", costs = 30000, description = {}, model = "ruffian"},
				--{name = "Sanchez", costs = 999999, description = {}, model = "sanchez2"},
				{name = "Sanchez (Livery)", costs = 15000, description = {}, model = "sanchez"},
				{name = "Sanctus", costs = 38000, description = {}, model = "sanctus"},
				{name = "Sovereign", costs = 40000, description = {}, model = "sovereign"},
				{name = "Stryder", costs = 55000, description = {}, model = "stryder"},
				-- {name = "Thrust", costs = 999999, description = {}, model = "thrust"},
				{name = "Vader", costs = 25000, description = {}, model = "vader"},
				--{name = "Vindicator", costs = 999999, description = {}, model = "vindicator"},
				{name = "Vortex", costs = 25000, description = {}, model = "vortex"},
				{name = "Wolfsbane", costs = 45000, description = {}, model = "wolfsbane"},
				{name = "Zombie Bobber", costs = 40000, description = {}, model = "zombiea"},
				{name = "Zombie Chopper", costs = 42000, description = {}, model = "zombieb"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 550, description = {}, model = "bmx"},
				--{name = "Unicycle", costs = 75, description = {}, model = "unicycle"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 2500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 2600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 2900, description = {}, model = "tribike3"},
			}
		},
	}
}




local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = {-33.737,-1102.322,26.422},
		inside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
		outside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
	}
}

local carspawns = {
	[1] =  { ['x'] = -38.25,['y'] = -1104.18,['z'] = 26.43,['h'] = 14.46, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = -36.36,['y'] = -1097.3,['z'] = 26.43,['h'] = 109.4, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = -43.11,['y'] = -1095.02,['z'] = 26.43,['h'] = 67.77, ['info'] = ' Car Spot 3' },
	[4] =  { ['x'] = -50.45,['y'] = -1092.66,['z'] = 26.43,['h'] = 116.33, ['info'] = ' Car Spot 4' },
	[5] =  { ['x'] = -56.24,['y'] = -1094.33,['z'] = 26.43,['h'] = 157.08, ['info'] = ' Car Spot 5' },
	[6] =  { ['x'] = -49.73,['y'] = -1098.63,['z'] = 26.43,['h'] = 240.99, ['info'] = ' Car Spot 6' },
	[7] =  { ['x'] = -45.58,['y'] = -1101.4,['z'] = 26.43,['h'] = 287.3, ['info'] = ' Car Spot 7' },
}

local carTable = {
	[1] = { ["model"] = "gauntlet", ["baseprice"] = 100000, ["commission"] = 15 }, 
	[2] = { ["model"] = "dubsta3", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "landstalker", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "bobcatxl", ["baseprice"] = 100000, ["commission"] = 15 },
	[5] = { ["model"] = "surfer", ["baseprice"] = 100000, ["commission"] = 15 },
	[6] = { ["model"] = "glendale", ["baseprice"] = 100000, ["commission"] = 15 },
	[7] = { ["model"] = "washington", ["baseprice"] = 100000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	carTable[currentCarSpawnLocation]["model"] = model
	carTable[currentCarSpawnLocation]["baseprice"] = price
	carTable[currentCarSpawnLocation]["name"] = name
	TriggerServerEvent("carshop:table",carTable)
end



local myspawnedvehs = {}

RegisterNetEvent("car:testdrive")
AddEventHandler("car:testdrive", function()
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end	

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end
	
	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-51.51, -1077.96, 26.92, 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,-51.51, -1077.96, 26.92,80.0,true,false)
		local vehplate = "CAR"..math.random(10000,99999) 
		SetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		local plt = GetVehicleNumberPlateText(veh)
		TriggerEvent("keys:addNew",veh, plt)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)

		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		myspawnedvehs[veh] = true
	else

		TriggerEvent("DoLongHudText","A car is on the spawn point.",2)

	end

end)

RegisterCommand('finance', function()
	TriggerEvent('finance')
end)
	
RegisterCommand("testdrive", function(source)
	TriggerEvent("car:testdrive")
end)

RegisterNetEvent("finance")
AddEventHandler("finance", function()
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end	
	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)	
	TriggerServerEvent("finance:enable",vehplate)
end)

RegisterNetEvent("finance:enableOnClient")
AddEventHandler("finance:enableOnClient", function(addplate)
	financedPlates[addplate] = true
	Citizen.Wait(60000)
	financedPlates[addplate] = nil
end)	




RegisterCommand('enablebuy', function()
	TriggerEvent('buy')
end)

RegisterNetEvent("buy")
AddEventHandler("buy", function()
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end	
	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)	
	TriggerServerEvent("buy:enable",vehplate)
end)

RegisterNetEvent("buy:enableOnClient")
AddEventHandler("buy:enableOnClient", function(addplate)
	FullBuyPlates[addplate] = true
	Citizen.Wait(60000)
	FullBuyPlates[addplate] = nil
end)	








RegisterNetEvent("commission")
AddEventHandler("commission", function(newAmount)
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("carshop:table",carTable)

		end
	end
end)

RegisterNetEvent("varial-vehicleshop:returnTable")
AddEventHandler("varial-vehicleshop:returnTable", function(newTable)

	carTable = newTable
	DespawnSaleVehicles()
	SpawnSaleVehicles()

end)

local hasspawned = false

local spawnedvehicles = {}
local vehicles_spawned = false
function BuyMenu()
	for i = 1, #carspawns do

		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end

			
			DisableControlAction(0,23)
			if IsControlJustReleased(0,47) then
				local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
				local addplate = GetVehicleNumberPlateText(veh)
				if FullBuyPlates[addplate] ~= nil then
					TriggerEvent("DoLongHudText","Attempting Purchase")
					AttemptBuy(i,false)
				else
					TriggerEvent("DoLongHudText", "You need a sales rep to help you")
				end
			end

			if IsControlJustReleased(0,23) or IsDisabledControlJustReleased(0,23) then
				local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
				local addplate = GetVehicleNumberPlateText(veh)
				if financedPlates[addplate] ~= nil then
					TriggerEvent("DoLongHudText","Attempting Purchase")
					AttemptBuy(i,true)
				else
					TriggerEvent("DoLongHudText", "You need a sales rep to help you")
				end
			end
		end
	end
end

function AttemptBuy(tableid,financed)

	local veh = GetClosestVehicle(carspawns[tableid]["x"],carspawns[tableid]["y"],carspawns[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end

	local model = carTable[tableid]["model"]
	local commission = carTable[tableid]["commission"]
	local baseprice = carTable[tableid]["baseprice"]
	local price = baseprice + (baseprice * commission/100)
	local vehname = GetDisplayNameFromVehicleModel(model)
	if baseprice > 200000 and not financed then
		TriggerEvent("DoLongHudText","This vehicle must be financed.",2)
		return
	end
	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerServerEvent('CheckMoneyForVeh', vehname, model, price, financed)
	commissionbuy = (baseprice * commission/200)

end



function OwnerMenu()

	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
				TriggerEvent("DoLongHudText","We Opened")
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
	end

end

function DrawPrices()
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local rank = exports["isPed"]:GroupRank("car_shop")
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if rank > 0 then
				if financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price/3) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy | [F] to Finance ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy. ")
				end
			else
				if financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " $" .. math.ceil(price) .. " upfront, $" .. math.ceil(price/3) .. " over 10 weeks, [F] to finance. ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " ")
				end			
			end
		end
	end
end
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
function SpawnSaleVehicles()
	if not hasspawned then
		TriggerServerEvent("carshop:requesttable")
		Citizen.Wait(1500)
	end
	DespawnSaleVehicles(true)
	hasspawned = true
	for i = 1, #carTable do
		local model = GetHashKey(carTable[i]["model"])
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]-1,carspawns[i]["h"],false,false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)

		FreezeEntityPosition(veh,true)
		spawnedvehicles[#spawnedvehicles+1] = veh
		SetVehicleNumberPlateText(veh, i .. "CARSALE")
	end
	vehicles_spawned = true
end

function DespawnSaleVehicles(pDontWait)
	if pDontWait == nil and not pDontWait then
		Wait(15000)
	end
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	vehicles_spawned = false
end




Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {18,"Enter"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["generalUseSecondary"] = table["generalUseSecondary"]
end)

--[[Functions]]--

function LocalPed()
	return PlayerPedId()
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Vehicle Shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			SetBlipScale(blip, 0.7)
			SetBlipColour(blip, 3)
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false

				if #(vector3(-45.98,-1082.97, 26.27) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(-45.98,-1082.97, 26.27,"["..Controlkey["generalUse"][2].."] return vehicle")
						if IsControlJustReleased(0,Controlkey["generalUse"][1]) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
					if insideVehShop then
						currentlocation = b
						if not vehicles_spawned then
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 25 then
							DrawPrices()
						end

						if vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) <= 1 then

							inrange = true
						end

						if vehshop.opened == true then
							DisplayHelpText('~g~'..Controlkey["generalUse"][2]..'~s~ or ~g~'..Controlkey["generalUseSecondary"][2]..'~s~ Accepts ~g~Arrows~s~ Move ~g~Backspace~s~ Exit')
						end

						if rank > 0 then
							OwnerMenu()
						end

						BuyMenu()
						

					else
						if vehicles_spawned then
							DespawnSaleVehicles()
						end
						Citizen.Wait(1000)
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	
	if ownerMenu then
		vehshop = vehshopOwner	
	else
		vehshop = vehshopDefault
	end


	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])




	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end
local endingCreator = false
function CloseCreator(name, veh, price, financed)
	Citizen.CreateThread(function()
		if not endingCreator then
			endingCreator = true
			local ped = LocalPed()
			if not boughtcar then
				local pos = currentlocation.pos.entering
				SetEntityCoords(ped,pos[1],pos[2],pos[3])
				FreezeEntityPosition(ped,false)
				SetEntityVisible(ped,true)
			else			
				local name = name	
				local vehicle = veh
				local price = price		
				local veh = GetVehiclePedIsUsing(ped)
				local model = GetEntityModel(veh)
				local colors = table.pack(GetVehicleColours(veh))
				local extra_colors = table.pack(GetVehicleExtraColours(veh))

				local mods = {}
				for i = 0,24 do
					mods[i] = GetVehicleMod(veh,i)
				end
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
				local pos = currentlocation.pos.outside

				FreezeEntityPosition(ped,false)
				RequestModel(model)
				while not HasModelLoaded(model) do
					Citizen.Wait(0)
				end
				personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
				SetModelAsNoLongerNeeded(model)

				if name == "rumpo" then
					SetVehicleLivery(personalvehicle,0)
				end

				if name == "taxi" then
					SetVehicleExtra(personalvehicle, 8, 0)
					SetVehicleExtra(personalvehicle, 9, 0)
					SetVehicleExtra(personalvehicle, 5, 1)
				end



				for i,mod in pairs(mods) do
					SetVehicleModKit(personalvehicle,0)
					SetVehicleMod(personalvehicle,i,mod)
				end

				SetVehicleOnGroundProperly(personalvehicle)

				local plate = GetVehicleNumberPlateText(personalvehicle)
				SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
				local id = NetworkGetNetworkIdFromEntity(personalvehicle)
				SetNetworkIdCanMigrate(id, true)
				Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
				SetVehicleColours(personalvehicle,colors[1],colors[2])
				SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
				TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
				TriggerEvent("keys:addNew", model, plate)
				local vehname = GetDisplayNameFromVehicleModel(model)
				SetEntityVisible(ped,true)			
				local primarycolor = colors[1]
				local secondarycolor = colors[2]	
				local pearlescentcolor = extra_colors[1]
				local wheelcolor = extra_colors[2]
				TriggerServerEvent('BuyForVeh', plate, vehname, vehicle, price, financed)
				DespawnSaleVehicles()
				SpawnSaleVehicles()
				Citizen.Wait(4000)
				TriggerServerEvent("garages:loaded:in")
			end
			vehshop.opened = false
			vehshop.menu.from = 1
			vehshop.menu.to = 10
			endingCreator = false
		end
	end)
end


RegisterNetEvent("carshop:failedpurchase")
AddEventHandler("carshop:failedpurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)


RegisterNetEvent("varial-vehicleshop:setPlate")
AddEventHandler("varial-vehicleshop:setPlate", function(vehicle, plate)
	SetVehicleNumberPlateText(vehicle, plate)
	Citizen.Wait(1000)
	TriggerEvent("keys:addNew", vehicle, plate)

	TriggerServerEvent('garages:SetVehOut', vehicle, plate)
	TriggerServerEvent('veh.getVehicles', plate, vehicle)
	TriggerServerEvent("garages:CheckGarageForVeh")

	local plt = GetVehicleNumberPlateText(vehicle)
	TriggerServerEvent("request:illegal:upgrades",plate)

end)




function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,51,122,181,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(250,250,250, 255)
	else
		SetTextColour(0, 0, 0, 255)
		
	end
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,51,122,181,250)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255, 255, 255,250) 
	end
	

end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end



function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = PlayerPedId()
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Cycles" then
			OpenMenu('cycles')
		end
	elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('sports')
		elseif btn == "Sedans" then
			OpenMenu('sedans')
		elseif btn == "Job Vehicles" then
			OpenMenu('jobvehicles')
		elseif btn == "Compacts" then
			OpenMenu('compacts')
		elseif btn == "Coupes" then
			OpenMenu('coupes')
		elseif btn == "Sports Classics" then
			OpenMenu("sportsclassics")
		elseif btn == "Super Cars" then
			OpenMenu("supercars")
		elseif btn == "Muscle" then
			OpenMenu('muscle')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
		end

	elseif this == "jobvehicles" or this == "compacts" or this == "coupes" or this == "sedans" or this == "sports" or this == "sportsclassics" or this == "supercars" or this == "muscle" or this == "offroad" or this == "suvs" or this == "vans" or this == "industrial" or this == "cycles" or this == "motorcycles" then

		if ownerMenu then

			updateCarTable(button.model,button.costs,button.name)

		else

			TriggerServerEvent('CheckMoneyForVeh',button.name, button.model, button.costs)

		end
		
	end

end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "supercars" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

function resetscaleform(topspeed,handling,braking,accel,resetscaleform,i)
    scaleform = RequestScaleformMovie(resetscaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

	topspeedc = topspeed / 20
	handlingc = handling / 20
	brakingc = braking / 20
	accelc = accel / 20

    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString("LOADING")
    PushScaleformMovieFunctionParameterString("Brand New Vehicle")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Handling")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Downforce")


	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
    PushScaleformMovieFunctionParameterInt( (20 * i)-1 )

	PopScaleformMovieFunctionVoid()

end


--[[Citizen]]--
function Initialize(scaleform,veh,vehname)

    scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString(vehname)
    PushScaleformMovieFunctionParameterString("Brand New Vehicle")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Handling")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Downforce")

	local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 4)
    local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
    local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
    local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 

    if topspeed > 100 then
    	topspeed = 100
    end
    if handling > 100 then
    	handling = 100
    end
    if braking > 100 then
    	braking = 100
    end
    if accel > 100 then
    	accel = 100
    end
    Citizen.Trace(topspeed)
    Citizen.Trace(handling)
    Citizen.Trace(braking)
    Citizen.Trace(accel)

    PushScaleformMovieFunctionParameterInt( topspeed )
    PushScaleformMovieFunctionParameterInt( handling )
    PushScaleformMovieFunctionParameterInt( braking )
    PushScaleformMovieFunctionParameterInt( accel )
    PopScaleformMovieFunctionVoid()

    return scaleform
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if vehshop.opened then

			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				local br = button.rank ~= nil and button.rank or 0
				if rank >= br and i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then

						drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)

					end
					y = y + 0.04
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "supercars" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)


								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								SetModelAsNoLongerNeeded(hash)
								local timer = 9000
								while not DoesEntityExist(veh) and timer > 0 do
									timer = timer - 1
									Citizen.Wait(1)
								end
								TriggerEvent("vehsearch:disable",veh)

	


								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}

									local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 2)
								    local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
								    local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
								    local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 
								
								if button.model == "rumpo" then
									SetVehicleLivery(veh,2)
								end


								-- not sure why it doesnt refresh itself, but blocks need to be set to their maximum 20 40 60 80 100 before a new number is pushed.
								for i = 1, 5 do
								 	scaleform = resetscaleform(topspeed,handling,braking,accel,"mp_car_stats_01",i)
							        x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
							        Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x-1,y+1.8,z+7.0, 0.0, 180.0, 90.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0)
								end

								scaleform = Initialize("mp_car_stats_01",fakecar.car,fakecar.model)
							end
						end
					end
					if selected and ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])  ) then
						ButtonSelected(button)
					end
				end
			end

			if DoesEntityExist(fakecar.car) then
				if vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
					daz = 6.0
					if fakecar.model == "Chimera" then
						daz = 8.0
					end
					if fakecar.model == "bmx" then
						daz = 8.0
					end
					 x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, daz))
		        	Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 7.0, 7.0, 7.0, 0)
				else
		       		x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, 10.0))
		       		Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 10.0, 10.0, 10.0, 0)		
				end
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.car,-1)
		    end

		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)

AddEventHandler('FinishMoneyCheckForVeh', function(name, vehicle, price,financed)	
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price, financed)
	local plt = GetVehicleNumberPlateText(vehicle)
	TriggerEvent("keys:addNew",vehicle, plt)
end)

ShowVehshopBlips(true)
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		--326 car blip 227 225
		ShowVehshopBlips(true)
		firstspawn = 1
	end
end)

AddEventHandler('vehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		local plate = GetVehicleNumberPlateText(veh)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
		TriggerEvent('varial-vehicleshop:setPlate', veh, plate)
	end
end)

RegisterNetEvent("varial-vehicleshop:update:plate")
AddEventHandler("varial-vehicleshop:update:plate", function(plate)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	SetVehicleNumberPlateText(veh, plate)
	local NPlate = GetVehicleNumberPlateText(veh)
	Citizen.Wait(100)
	TriggerEvent("keys:addNew",veh, NPlate)
end)


local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)

local vehshopLoc = PolyZone:Create({
	vector2(-17.224317550659, -1125.9611816406),
	vector2(-70.010810852051, -1128.2976074219),
	vector2(-76.185691833496, -1127.8470458984),
	vector2(-79.25121307373, -1123.7583007813),
	vector2(-79.670585632324, -1118.4036865234),
	vector2(-59.549613952637, -1063.388671875),
	vector2(-1.2465063333511, -1081.7679443359)
}, {
    name = "varial-vehicleshop",
    minZ = 0,
    maxZ = 40.5,
    debugGrid = false,
    gridDivisions = 25
})

local HeadBone = 0x796e;
Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coord = GetPedBoneCoords(plyPed, HeadBone)
        local inPoly = vehshopLoc:isPointInside(coord)
        -- if true, then player just entered zone
        if inPoly and not insideVehShop then
            insideVehShop = true
        elseif not inPoly and insideVehShop then
            insideVehShop = false
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if insideVehShop then
            rank = exports["isPed"]:GroupRank("car_shop")
            Citizen.Wait(10000)
        end
    end
end)

RegisterNetEvent("varial-vehicleshop:repo:success")
AddEventHandler("varial-vehicleshop:repo:success", function()
	local veh = GetVehiclePedIsIn(PlayerPedId())
	if veh ~= 0 then
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
		TriggerEvent("DoLongHudText", "You have successfully repossed the vehicle")
	end
end)


RegisterNetEvent("search:list:repo")
AddEventHandler("search:list:repo", function()
	local valid = exports["varial-keyboard"]:KeyboardInput({
		header = "Search Repo List",
		rows = {
			{
				id = 0,
				txt = "Vehicle Plate Number"
			},
		}
	})
	if valid then
		TriggerServerEvent("varial-vehicleshop:checkrepo", valid[1].input)
	end
end)

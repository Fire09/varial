RegisterNetEvent('FinishMoneyCheckForVehtuner')
RegisterNetEvent('tunervehshop:spawnVehicle')
local vehshop_blips = {}
local buyPlate = {}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0
local commissionbuy = 0
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
				{name = "vehicles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "vehicles",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 4000, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 7000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 4000, description = {}, model = "rumpo"},
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
			title = "vehicles",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
				{name = "Tuners", description = ''},
				{name = "Casino", description = ''},
				{name = "Compacts", description = ''},
				{name = "Coupes", description = ''},
				{name = "Muscle", description = ''},
				{name = "Off-Road", description = ''},
				{name = "Sedans", description = ''},
				{name = "Sports", description = ''},
				{name = "Sports Classics", description = ''},
				{name = "Supers", description = ''},
				{name = "SUVs", description = ''},
				{name = "Vans", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 7500, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 10000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 9500, description = {}, model = "rumpo"},
			}
		},
		["tuners"] = {
			title = "tuners",
			name = "tuners",
			buttons = {
				{name = "Calico GTF", costs = 165000, description = {}, model = "calico"},
				{name = "Dominator GTT", costs = 145000, description = {}, model = "dominator8"},
				{name = "Euros", costs = 155000, description = {}, model = "euros"},
				{name = "Futo GTX", costs = 115000, description = {}, model = "futo2"},
				{name = "Jester RR", costs = 185000, description = {}, model = "jester4"},
				{name = "Remus", costs = 145000, description = {}, model = "remus"},
				{name = "RT3000", costs = 132500, description = {}, model = "rt3000"},
				{name = "Tailgater S", costs = 165000, description = {}, model = "tailgater2"},
				{name = "Warrener HKR", costs = 14750, description = {}, model = "warrener2"},
				{name = "ZR350", costs = 125000, description = {}, model = "zr350"},
				{name = "Comet S2", costs = 189000, description = {}, model = "comet6"},
				{name = "Dominator ASP", costs = 156750, description = {}, model = "dominator7"},
				{name = "Vectre", costs = 186500, description = {}, model = "vectre"},
				{name = "Growler", costs = 192500, description = {}, model = "growler"},
				{name = "Sultan RS Classic", costs = 175000, description = {}, model = "sultan3"},
				{name = "Cypher", costs = 165000, description = {}, model = "cypher"},
				{name = "Previon", costs = 145000, description = {}, model = "previon"},
			}
		},
		["casino"] = {
			title = "casino",
			name = "casino",
			buttons = {
				{name = "Drafter", costs = 160000, description = {}, model = "drafter"},
				{name = "Jugular", costs = 130000, description = {}, model = "jugular"},
				{name = "Peyote Gasser", costs = 110000, description = {}, model = "peyote2"},
				{name = "Gauntlet Hellfire", costs = 115000, description = {}, model = "gauntlet4"},
				{name = "Caracara", costs = 85000, description = {}, model = "caracara2"},
				{name = "Novak", costs = 110000, description = {}, model = "Novak"},
				{name = "Issi Sport", costs = 80000, description = {}, model = "issi7"},
				{name = "Hellion", costs = 75000, description = {}, model = "hellion"},
				{name = "Gauntlet Classic", costs = 75000, description = {}, model = "gauntlet3"},
				{name = "Nebula Turbo", costs = 70000, description = {}, model = "nebula"},
				{name = "Zion Classic", costs = 69000, description = {}, model = "zion3"},
				{name = "Komoda", costs = 135000, description = {}, model = "komoda"},
				{name = "Rebla", costs = 100000, description = {}, model = "rebla"},
				{name = "Retinue", costs = 90000, description = {}, model = "retinue2"},
				{name = "Sugoi", costs = 125000, description = {}, model = "sugoi"},
				{name = "VSTR", costs = 165000, description = {}, model = "vstr"},
				{name = "Paragon R", costs = 155000, description = {}, model = "paragon"},
				{name = "Thrax", costs = 350000, description = {}, model = "thrax"},
				{name = "Neo", costs = 165000, description = {}, model = "neo"},
				{name = "Emerus", costs = 270000, description = {}, model = "emerus"},
				{name = "Locust", costs = 150000, description = {}, model = "locust"},
				{name = "Krieger", costs = 300000, description = {}, model = "krieger"},
				{name = "Dynasty", costs = 100000, description = {}, model = "dynasty"},
				{name = "Zorrusso", costs = 310000, description = {}, model = "zorrusso"},
				{name = "Asbo", costs = 60000, description = {}, model = "asbo"},
				{name = "Everon", costs = 125000, description = {}, model = "everon"},
				{name = "Retinue MKII", costs = 115000, description = {}, model = "retinue2"},
				{name = "Vagrant", costs = 75000, description = {}, model = "vagrant"},
				{name = "Outlaw", costs = 75000, description = {}, model = "outlaw"},
				{name = "Furia", costs = 250000, description = {}, model = "furia"},
				{name = "Sultan Classic", costs = 115000, description = {}, model = "sultan2"},
				{name = "Drift Yosemite", costs = 70000, description = {}, model = "yosemite2"},
				{name = "Kanjo", costs = 85000, description = {}, model = "kanjo"},
				{name = "Stryder", costs = 25500, description = {}, model = "stryder"},
				{name = "Imorgon", costs = 120000, description = {}, model = "imorgon"},
			}
		},
		["compacts"] = {
			title = "compacts",
			name = "compacts",
			buttons = {			
				{name = "Blista", costs = 25000, description = {}, model = "blista"},
				{name = "Brioso R/A", costs = 35000, description = {}, model = "brioso"},
				{name = "Brioso 300", costs = 30000, description = {}, model = "brioso2"},
				{name = "Club", costs = 57000, description = {}, model = "club"},
				{name = "Dilettante", costs = 15000, description = {}, model = "Dilettante"},
				{name = "Issi", costs = 14000, description = {}, model = "issi2"},
				{name = "Issi Classic", costs = 18000, description = {}, model = "issi3"},
				{name = "Panto", costs = 10000, description = {}, model = "panto"},
				{name = "Prairie", costs = 16500, description = {}, model = "prairie"},
				{name = "Rhapsody", costs = 15000, description = {}, model = "rhapsody"},
				{name = "Weevil", costs = 35000, description = {}, model = "weevil"},
			
			}
		},
		["coupes"] = {
			title = "coupes",
			name = "coupes",
			buttons = {
				{name = "Cognoscenti Cabrio", costs = 45000, description = {}, model = "cogcabrio"},
				{name = "Exemplar", costs = 30000, description = {}, model = "exemplar"},
				{name = "F620", costs = 24000, description = {}, model = "f620"},
				{name = "Felon", costs = 20000, description = {}, model = "felon"},
				{name = "Felon GT", costs = 23000, description = {}, model = "felon2"},
				{name = "Jackal", costs = 50000, description = {}, model = "jackal"},
				{name = "Oracle", costs = 35000, description = {}, model = "oracle"},
				{name = "Oracle XS", costs = 32000, description = {}, model = "oracle2"},
				{name = "Sentinel XS", costs = 40000, description = {}, model = "sentinel"},
				{name = "Sentinel", costs = 45000, description = {}, model = "sentinel2"},
				{name = "Windsor", costs = 60000, description = {}, model = "windsor"},
				{name = "Windsor Drop", costs = 65000, description = {}, model = "windsor2"},
				{name = "Zion", costs = 35000, description = {}, model = "zion"},
				{name = "Zion Cabrio", costs = 38000, description = {}, model = "zion2"},
			}
		},
		["muscle"] = {
			title = "muscle",
			name = "muscle",
			buttons = {
				{name = "Blade", costs = 15000, description = {}, model = "blade"},
				{name = "Buccaneer", costs = 20000, description = {}, model = "buccaneer"},
				{name = "Buccaneer Lowrider", costs = 25000, description = {}, model = "buccaneer2"},
				{name = "Chino", costs = 20000, description = {}, model = "chino"},
				{name = "Chino Lowrider", costs = 25000, description = {}, model = "chino2"},
				{name = "Coquette BlackFin", costs = 115000, description = {}, model = "coquette3"},
				{name = "Clique", costs = 45000, description = {}, model = "clique"},
				{name = "Deviant", costs = 65000, description = {}, model = "deviant"},
				{name = "Dominator", costs = 20000, description = {}, model = "dominator"},
				{name = "Dominator GTX", costs = 45000, description = {}, model = "dominator3"},
				{name = "Dukes", costs = 16500, description = {}, model = "dukes"},
				{name = "Ellie", costs = 36500, description = {}, model = "ellie"},
				{name = "Faction", costs = 16500, description = {}, model = "faction"},
				{name = "Faction Lowrider", costs = 20000, description = {}, model = "faction2"},
				{name = "Faction Lowrider DONK", costs = 30000, description = {}, model = "faction3"},
				{name = "Gauntlet", costs = 16500, description = {}, model = "gauntlet"},
				{name = "Gauntlet Classic Custom", costs = 90000, description = {}, model = "gauntlet5"},
				{name = "Hermes", costs = 145000, description = {}, model = "hermes"},
				{name = "Hustler", costs = 32500, description = {}, model = "hustler"},
				{name = "Impaler", costs = 40000, description = {}, model = "impaler"},
				{name = "Lurcher", costs = 45000, description = {}, model = "lurcher"},
				{name = "Manana Custom", costs = 60000, description = {}, model = "manana2"},
				{name = "Moonbeam", costs = 15000, description = {}, model = "moonbeam"},
				{name = "Moonbeam Lowrider", costs = 22500, description = {}, model = "moonbeam2"},
				{name = "Nightshade", costs = 45000, description = {}, model = "nightshade"},
				{name = "Phoenix", costs = 12500, description = {}, model = "phoenix"},
				{name = "Picador", costs = 11250, description = {}, model = "picador"},
				{name = "Rat Truck", costs = 19500, description = {}, model = "ratloader2"},
				{name = "Ruiner", costs = 14500, description = {}, model = "ruiner"},
				{name = "Sabre Turbo", costs = 20000, description = {}, model = "sabregt"},
				{name = "SabreGT Custom", costs = 25000, description = {}, model = "sabregt2"},
				{name = "Slamvan", costs = 19750, description = {}, model = "slamvan"},
				{name = "Slamvan Custom", costs = 26500, description = {}, model = "slamvan3"},
				{name = "Stallion", costs = 17000, description = {}, model = "stalion"},
				{name = "Tampa", costs = 18500, description = {}, model = "tampa"},
				{name = "Tulip", costs = 22500, description = {}, model = "tulip"},
				{name = "Vamos", costs = 24000, description = {}, model = "vamos"},
				{name = "Vigero", costs = 17500, description = {}, model = "vigero"},
				{name = "Virgo", costs = 16500, description = {}, model = "virgo"},
				{name = "Virgo Classic", costs = 22250, description = {}, model = "virgo3"},
				{name = "Virgo Classic Custom", costs = 26000, description = {}, model = "virgo2"},
				{name = "Voodoo", costs = 12500, description = {}, model = "voodoo2"},
				{name = "Voodoo Custom", costs = 20000, description = {}, model = "voodoo"},
				{name = "Yosemite", costs = 56750, description = {}, model = "yosemite"},
			}
		},
		["offroad"] = {
			title = "off-road",
			name = "off-road",
			buttons = {
				{name = "BF Injection", costs = 12500, description = {}, model = "bfinjection"},
				{name = "Bifta", costs = 15000, description = {}, model = "bifta"},
				{name = "Blazer", costs = 9000, description = {}, model = "blazer"},
				{name = "Bodhi", costs = 10500, description = {}, model = "bodhi2"},
				{name = "Brawler", costs = 45000, description = {}, model = "brawler"},
				{name = "Desert Raid", costs = 65000, description = {}, model = "trophytruck2"},
				{name = "Dubsta 6x6", costs = 75000, description = {}, model = "dubsta3"},
				{name = "Dune Buggy", costs = 12000, description = {}, model = "dune"},
				{name = "Dune Loader", costs = 5000, description = {}, model = "dloader"},
				{name = "Freecrawler", costs = 55000, description = {}, model = "freecrawler"},
				{name = "Hotrod Blazer", costs = 12500, description = {}, model = "blazer3"},
				{name = "Kalahari", costs = 17000, description = {}, model = "kalahari"},
				{name = "Kamacho", costs = 50000, description = {}, model = "kamacho"},
				{name = "Mesa", costs = 15500, description = {}, model = "mesa"},
				{name = "Mesa Off-Road", costs = 45500, description = {}, model = "mesa3"},
				{name = "Rancher XL", costs = 17000, description = {}, model = "rancherxl"},
				{name = "Rebel", costs = 12000, description = {}, model = "rebel2"},
				{name = "Riata", costs = 35000, description = {}, model = "riata"},
				{name = "Sadler", costs = 20000, description = {}, model = "sadler"},
				{name = "Sandking XL", costs = 25000, description = {}, model = "sandking"},
				{name = "Sandking SWB", costs = 27500, description = {}, model = "sandking2"},
				{name = "Street Blazer", costs = 18500, description = {}, model = "blazer4"},
				{name = "Trophy Truck", costs = 65000, description = {}, model = "trophytruck"},
				{name = "Verus", costs = 19500, description = {}, model = "verus"},
				{name = "Winky", costs = 19420, description = {}, model = "winky"},
				{name = "Yosemite Rancher", costs = 65000, description = {}, model = "yosemite3"},
			}
		},
		["sedans"] = {
			title = "sedans",
			name = "sedans",
			buttons = {
				{name = "Fugitive", costs = 26500, description = {}, model = "fugitive"},
				{name = "Asea", costs = 10000, description = {}, model = "asea"},
				{name = "Asterope", costs = 12500, description = {}, model = "asterope"},
				{name = "Cognoscenti", costs = 70000, description = {}, model = "cognoscenti"},
				{name = "Cognoscenti 55", costs = 65000, description = {}, model = "cog55"},
				{name = "Emperor", costs = 13000, description = {}, model = "emperor"},
				{name = "Regina", costs = 17500, description = {}, model = "regina"},
				{name = "Glendale", costs = 13000, description = {}, model = "glendale"},
				{name = "Glendale Custom", costs = 19500, description = {}, model = "glendale2"},
				{name = "Ingot", costs = 9000, description = {}, model = "ingot"},
				{name = "Intruder", costs = 14750, description = {}, model = "intruder"},
				{name = "Premier", costs = 13500, description = {}, model = "premier"},
				{name = "Primo", costs = 16000, description = {}, model = "primo"},
				{name = "Primo Custom", costs = 25000, description = {}, model = "primo2"},
				{name = "Schafter", costs = 32000, description = {}, model = "schafter2"},
				{name = "Stafford", costs = 45000, description = {}, model = "stafford"},
				{name = "Stanier", costs = 20000, description = {}, model = "stanier"},
			    {name = "Stratum", costs = 16500, description = {}, model = "stratum"},
				{name = "Super Diamond", costs = 50000, description = {}, model = "superd"},
				{name = "Surge", costs = 17500, description = {}, model = "surge"},
				{name = "Tailgater", costs = 32500, description = {}, model = "tailgater"},
				{name = "Warrener", costs = 10000, description = {}, model = "warrener"},
				{name = "Washington", costs = 13500	, description = {}, model = "washington"},
			}
		},
		["sports"] = {
			title = "sports",
			name = "sports",
			buttons = {
				{name = "9F", costs = 85000, description = {}, model = "ninef"},
				{name = "9F Cabrio", costs = 90000, description = {}, model = "ninef2"},
				{name = "Alpha", costs = 65000, description = {}, model = "alpha"},
				{name = "Banshee", costs = 75000, description = {}, model = "banshee"},
				{name = "Bestia GTS", costs = 82500, description = {}, model = "bestiagts"},
				{name = "Bista Compact", costs = 13000, description = {}, model = "blista2"},
				{name = "Buffalo", costs = 36000, description = {}, model = "buffalo"},
				{name = "Buffalo Sport", costs = 40000, description = {}, model = "buffalo2"},
				{name = "Carbonizzare", costs = 62500, description = {}, model = "carbonizzare"},
				{name = "Comet", costs = 75000, description = {}, model = "comet2"},
				{name = "Comet Retro Custom", costs = 85000, description = {}, model = "comet3"},
				{name = "Comet Safari", costs = 92500, description = {}, model = "comet4"},
				{name = "Comet SR", costs = 105000, description = {}, model = "comet5"},
				{name = "Coquette", costs = 72500, description = {}, model = "coquette"},
				{name = "Coquette D10", costs = 172500, description = {}, model = "coquette4"},
				{name = "Drift Tampa", costs = 116500, description = {}, model = "tampa2"},
				{name = "Elegy RH8", costs = 85000, description = {}, model = "elegy2"},
				{name = "Elegy Retro Custom", costs = 117250, description = {}, model = "elegy"},
				{name = "Feltzer", costs = 72500, description = {}, model = "feltzer2"},
				{name = "Flash GT", costs = 62500, description = {}, model = "flashgt"},
				{name = "Furore GT", costs = 45000, description = {}, model = "furoregt"},
				{name = "Fusilade", costs = 22500, description = {}, model = "fusilade"},
				{name = "Futo", costs = 16500, description = {}, model = "futo"},
				{name = "GB200", costs = 52500, description = {}, model = "gb200"},
				{name = "Go Go Monkey Blista", costs = 14500, description = {}, model = "blista3"},
				{name = "Hotring Sabre", costs = 450000, description = {}, model = "hotring"},
				{name = "Itali GTO", costs = 225000, description = {}, model = "italigto"},
				{name = "Itali RSX", costs = 265000, description = {}, model = "italirsx"},
				{name = "Jester", costs = 115000, description = {}, model = "jester"},
				{name = "Jester Classic", costs = 92500, description = {}, model = "jester3"},
				{name = "Khamelion", costs = 130000, description = {}, model = "khamelion"},
				{name = "Kuruma", costs = 76500, description = {}, model = "kuruma"},
				{name = "Lynx", costs = 115000, description = {}, model = "lynx"},
				{name = "Massacro", costs = 95000, description = {}, model = "massacro"},
				{name = "Neon", costs = 175000, description = {}, model = "neon"},
				{name = "Omnis", costs = 62500, description = {}, model = "omnis"},
				{name = "Pariah", costs = 135000, description = {}, model = "pariah"},
				{name = "Penumbra", costs = 65000, description = {}, model = "penumbra"},
				{name = "Penumbra FF", costs = 85000, description = {}, model = "penumbra2"},
				{name = "Raiden", costs = 122000, description = {}, model = "raiden"},
				{name = "Rapid GT", costs = 95000, description = {}, model = "rapidgt"},
				{name = "Rapid GT Cabrio", costs = 97500, description = {}, model = "rapidgt2"},
				{name = "Raptor", costs = 132500, description = {}, model = "raptor"},
				{name = "Revolter", costs = 165000, description = {}, model = "revolter"},
				{name = "Ruston", costs = 125000, description = {}, model = "ruston"},
				{name = "Schafter LWB", costs = 105000, description = {}, model = "schafter4"},
				{name = "Schafter V12", costs = 100000, description = {}, model = "schafter3"},
				{name = "Schlagen GT", costs = 132500, description = {}, model = "schlagen"},
				{name = "Schwartzer", costs = 82500, description = {}, model = "schwarzer"},
				{name = "Sentinel Classic", costs = 75000, description = {}, model = "sentinel3"},
				{name = "Seven-70", costs = 135000, description = {}, model = "seven70"},
				{name = "Specter", costs = 100000, description = {}, model = "specter"},
				{name = "Specter Custom", costs = 125000, description = {}, model = "specter2"},
				{name = "Streiter", costs = 75000, description = {}, model = "streiter"},
				{name = "Sultan", costs = 85000, description = {}, model = "sultan"},
				{name = "Surano", costs = 125000, description = {}, model = "Surano"},
				{name = "Tropos Rallye", costs = 117500, description = {}, model = "tropos"},
				{name = "Verlierer", costs = 145000, description = {}, model = "verlierer2"},
				{name = "Veto Classic", costs = 25000, description = {}, model = "veto"},
				{name = "Veto Modern", costs = 35000, description = {}, model = "veto2"},
			}
		},
		["sportsclassics"] = {
			title = "sportsclassics",
			name = "sportsclassics",
			buttons = {
				{name = "190z", costs = 75000, description = {}, model = "z190"},
				{name = "Ardent", costs = 900000, description = {}, model = "ardent"},
				{name = "Casco", costs = 175000, description = {}, model = "casco"},
				{name = "Cheburek", costs = 65000, description = {}, model = "cheburek"},
				{name = "Cheetah Classic", costs = 210000, description = {}, model = "cheetah2"},
				{name = "Coquette Classic", costs = 165000, description = {}, model = "coquette2"},
				{name = "Deluxo", costs = 188000, description = {}, model = "deluxo2"},
				{name = "Fagaloa", costs = 32500, description = {}, model = "fagaloa"},
				{name = "Franken Stange", costs = 162500, description = {}, model = "ninef"},
				{name = "GT500", costs = 145000, description = {}, model = "gt500"},
				{name = "Infernus Classic", costs = 210000, description = {}, model = "infernus2"},
				{name = "JB700", costs = 220007, description = {}, model = "jb700"},
				{name = "Mamba", costs = 195000, description = {}, model = "mamba"},
				{name = "Manana", costs = 50000, description = {}, model = "manana"},
				{name = "Michelli GT", costs = 115000, description = {}, model = "michelli"},
				{name = "Monroe", costs = 185000, description = {}, model = "monroe"},
				{name = "Peyote", costs = 65000, description = {}, model = "peyote"},
				{name = "Peyote Custom", costs = 75000, description = {}, model = "peyote2"},
				{name = "Pigalle", costs = 95000, description = {}, model = "pigalle"},
				{name = "Rapid GT Classic", costs = 115000, description = {}, model = "rapidgt3"},
				{name = "Roosevelt", costs = 250000, description = {}, model = "btype"},
				{name = "Roosevelt Valor", costs = 275000, description = {}, model = "btype3"},
				{name = "Savestra", costs = 145000, description = {}, model = "savestra"},
				{name = "Stinger", costs = 165000, description = {}, model = "stinger"},
				{name = "Stinger GT", costs = 150000, description = {}, model = "stingergt"},
				{name = "Stirling GT", costs = 155000, description = {}, model = "feltzer3"},
				{name = "Swinger", costs = 180000, description = {}, model = "swinger"},
				{name = "Torero", costs = 195000, description = {}, model = "Torero"},
				{name = "Tornado", costs = 30000, description = {}, model = "tornado"},
				{name = "Tornado Drop", costs = 36500, description = {}, model = "tornado2"},
				{name = "Tornado Custom", costs = 45000, description = {}, model = "tornado5"},
				{name = "Tornado Rat Rod", costs = 65000, description = {}, model = "tornado6"},
				{name = "Turismo Classic", costs = 200000, description = {}, model = "turismo2"},
				{name = "Z-type", costs = 400000, description = {}, model = "ztype"},
			}
		},
		["supers"] = {
			title = "supers",
			name = "supers",
			buttons = {
				{name = "811", costs = 262000, description = {}, model = "pfister811"},
				{name = "Adder", costs = 200000, description = {}, model = "adder"},
				{name = "Autarch", costs = 245000, description = {}, model = "autarch"},
				{name = "Banshee 900R", costs = 165000, description = {}, model = "banshee2"},
				{name = "Bullet", costs = 150000, description = {}, model = "bullet"},
				{name = "Cheetah", costs = 165000, description = {}, model = "cheetah"},
				{name = "Cyclone", costs = 215000, description = {}, model = "cyclone"},
				{name = "Deveste Eight", costs = 365000, description = {}, model = "deveste"},
				{name = "Entity XF", costs = 185000, description = {}, model = "entityxf"},
				{name = "Entity XXR", costs = 225000, description = {}, model = "entity2"},
				{name = "FMJ", costs = 230000, description = {}, model = "fmj"},
				{name = "Furia", costs = 260000, description = {}, model = "furia"},
				{name = "GP1", costs = 230000, description = {}, model = "gp1"},
				{name = "Infernus", costs = 165000, description = {}, model = "infernus"},
				{name = "Itali GTB", costs = 195000, description = {}, model = "italigtb"},
				{name = "Itali GTB Custom", costs = 215000, description = {}, model = "italigtb2"},
				{name = "Nero", costs = 265000, description = {}, model = "nero"},
				{name = "Nero Custom", costs = 295000, description = {}, model = "nero2"},
				{name = "Osiris", costs = 245000, description = {}, model = "osiris"},
				{name = "Penetrator", costs = 225000, description = {}, model = "penetrator"},
				{name = "Reaper", costs = 195750, description = {}, model = "reaper"},
				{name = "SC1", costs = 182500, description = {}, model = "sc1"},
				{name = "Sultan RS", costs = 188250, description = {}, model = "sultanrs"},
				{name = "T20", costs = 235000, description = {}, model = "t20"},
				{name = "Taipan", costs = 345000, description = {}, model = "taipan"},
				{name = "Tempesta", costs = 265000, description = {}, model = "tempesta"},
				{name = "Tezeract", costs = 500000, description = {}, model = "Tezeract"},
				{name = "Tigon", costs = 245500, description = {}, model = "Tigon"},
				{name = "Turismo R", costs = 172500, description = {}, model = "turismor"},
				{name = "Tyrant", costs = 345000, description = {}, model = "tyrant"},
				{name = "Tyrus", costs = 475000, description = {}, model = "tyrus"},
				{name = "Vacca", costs = 232000, description = {}, model = "vacca"},
				{name = "Vagner", costs = 285000, description = {}, model = "vagner"},
				{name = "Visione", costs = 292500, description = {}, model = "visione"},
				{name = "Voltic", costs = 165000, description = {}, model = "voltic"},
				{name = "X80 Proto", costs = 500000, description = {}, model = "prototipo"},
				{name = "XA-21", costs = 465000, description = {}, model = "xa21"},
				{name = "Zentorno", costs = 200000, description = {}, model = "zentorno"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Cavalcade", costs = 17000, description = {}, model = "cavalcade"},
				{name = "Cavalcade Gen2", costs = 20000, description = {}, model = "cavalcade2"},
				{name = "Contender", costs = 45000, description = {}, model = "contender"},
				{name = "Granger", costs = 20000, description = {}, model = "granger"},
				{name = "Huntley S", costs = 35000, description = {}, model = "huntley"},
				{name = "Landstalker", costs = 20000, description = {}, model = "landstalker"},
				{name = "Landstalker XL", costs = 85000, description = {}, model = "landstalker2"},
				{name = "Radius", costs = 22000, description = {}, model = "radi"},
				{name = "Rocoto", costs = 32000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 18500, description = {}, model = "seminole"},
				{name = "Seminole Frontier", costs = 60000, description = {}, model = "seminole2"},
				{name = "XLS", costs = 32500, description = {}, model = "xls"},
				{name = "Dubsta", costs = 40000, description = {}, model = "dubsta"},
				{name = "Dubsta LE", costs = 50000, description = {}, model = "dubsta2"},
				{name = "Patriot", costs = 35000, description = {}, model = "patriot"},
				{name = "Gresley", costs = 17500, description = {}, model = "gresley"},
				{name = "Toros", costs = 85000, description = {}, model = "toros"},
				{name = "Baller", costs = 25000, description = {}, model = "baller"},
				{name = "Baller Gen2", costs = 30000, description = {}, model = "baller2"},
				{name = "Baller LE", costs = 45000, description = {}, model = "baller3"},
				{name = "Baller LWB", costs = 60000, description = {}, model = "baller4"},
				{name = "BeeJay XL", costs = 26500, description = {}, model = "bjxl"},
				{name = "FQ2", costs = 16500, description = {}, model = "fq2"},
				{name = "Habanero", costs = 23500, description = {}, model = "habanero"},
				{name = "Serrano", costs = 16500, description = {}, model = "serrano"},
			}
		},
		["vans"] = {
			title = "vans",
			name = "vans",
			buttons = {
				{name = "Bison", costs = 16500, description = {}, model = "bison"},
				{name = "Bobcat XL", costs = 14500, description = {}, model = "bobcatxl"},
				{name = "Burrito", costs = 16500, description = {}, model = "burrito3"},
				{name = "Camper Van", costs = 16500, description = {}, model = "camper"},
				{name = "Gang Burrito", costs = 16500, description = {}, model = "gburrito2"},
			    {name = "Journey", costs = 16500, description = {}, model = "journey"},
				{name = "Minivan", costs = 16500, description = {}, model = "minivan"},
				{name = "Minvan Custom", costs = 16500, description = {}, model = "minivan2"},
				{name = "Paradise", costs = 16500, description = {}, model = "paradise"},
				{name = "Pony", costs = 16500, description = {}, model = "pony"},
				{name = "Smokey Pony", costs = 16500, description = {}, model = "pony2"},
				{name = "Rumpo", costs = 16500, description = {}, model = "rumpo"},
				{name = "Rumpo Custom", costs = 120000, description = {}, model = "rumpo3"},
			}
		},
		["motorcycles"] = {
			title = "MOTORCYCLES",
			name = "motorcycles",
			buttons = {		
				{name = "Akuma", costs = 13500, description = {}, model = "akuma"},
				{name = "Avarus", costs = 17500, description = {}, model = "avarus"},
				{name = "Bagger", costs = 8000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 14500, description = {}, model = "bati"},
				{name = "BF400", costs = 9000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 12500, description = {}, model = "carbonrs"},
				{name = "Chimera", costs = 22000, description = {}, model = "chimera"},
				{name = "Cliffhanger", costs = 14500, description = {}, model = "chimera"},
				{name = "Daemon", costs = 12500, description = {}, model = "daemon2"},
				{name = "Defiler", costs = 14500, description = {}, model = "defiler"},
				{name = "Diabolus", costs = 16500, description = {}, model = "diablous"},
				{name = "Diabolus Custom", costs = 22500, description = {}, model = "diablous2"},
				{name = "Double T", costs = 14750, description = {}, model = "double"},
				{name = "Enduro", costs = 12000, description = {}, model = "enduro"},
				{name = "Esskey", costs = 11000, description = {}, model = "esskey"},
				{name = "Faggio", costs = 4000, description = {}, model = "faggio2"},
				{name = "Faggio Mod", costs = 4750, description = {}, model = "faggio3"},
				{name = "Faggio Sport", costs = 5300, description = {}, model = "faggio"},
				{name = "FCR 1000", costs = 13500, description = {}, model = "fcr"},
				{name = "FCR 1000 Custom", costs = 17750, description = {}, model = "fcr2"},
				{name = "Gargoyle", costs = 14500, description = {}, model = "gargoyle"},
				{name = "Hakuchou", costs = 25000, description = {}, model = "hakuchou"},
				{name = "Hakuchou Drag", costs = 30000, description = {}, model = "hakuchou2"},
				{name = "Hexer", costs = 10000, description = {}, model = "hexer"},
				{name = "Innovation", costs = 17500, description = {}, model = "innovation"},
				{name = "Lectro", costs = 14500, description = {}, model = "lectro"},
			    {name = "Manchez", costs = 12500, description = {}, model = "manchez"},
				{name = "Manchez Scout", costs = 14000, description = {}, model = "manchez2"},
				{name = "Nemesis", costs = 13000, description = {}, model = "nemesis"},
				{name = "Nightblade", costs = 17500, description = {}, model = "nightblade"},
				{name = "PCJ 600", costs = 15750, description = {}, model = "pcj"},
				{name = "Rampant Rocket", costs = 75000, description = {}, model = "rrocket"},
				{name = "Rat Bike", costs = 7500, description = {}, model = "ratbike"},
				{name = "Ruffian", costs = 12500, description = {}, model = "ruffian"},
				{name = "Sanchez", costs = 6000, description = {}, model = "sanchez2"},
				{name = "Sanctus", costs = 16666, description = {}, model = "sanctus"},
				{name = "Shotaro", costs = 125000, description = {}, model = "shotaro"},
				{name = "Sovereign", costs = 14500, description = {}, model = "sovereign"},
				{name = "Thrust", costs = 16500, description = {}, model = "thrust"},
				{name = "Vader", costs = 18200, description = {}, model = "vader"},
				{name = "Vindicator", costs = 19500, description = {}, model = "vindicator"},
				{name = "Vortex", costs = 16750, description = {}, model = "vortex"},
				{name = "Wolfsbane", costs = 14500, description = {}, model = "wolfsbane"},
				{name = "Zombie", costs = 13500, description = {}, model = "zombieb"},
				{name = "Zombie Bobber", costs = 14000, description = {}, model = "zombiea"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 100, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 200, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 300, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 250, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 850, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 850, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 850, description = {}, model = "tribike3"},
			}
		},
	}
}

local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = {-32.953842163086,-1097.5648193359,27.257934570312},
		inside = {-75.283508300781,-819.25714111328,326.17358398438},
		outside = {-32.953842163086,-1097.5648193359,27.257934570312},
	}
}

local carspawns = {
	[1] =  { ['x'] = 124.0144,['y'] = -3047.3811,['z'] = 7.0409,['h'] = 269.1627, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = 124.0144,['y'] = -3041.1477,['z'] = 7.0409,['h'] = 269.1627, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = 124.0144,['y'] = -3035.0281,['z'] = 7.0409,['h'] = 269.1627, ['info'] = ' Car Spot 3' },
}

local carTable = { 
	[1] = { ["model"] = "subwrx", ["baseprice"] = 100000, ["commission"] = 15 },
	[2] = { ["model"] = "c7", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "demon", ["baseprice"] = 100000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	for i=1, #carTable do
		carTable[currentCarSpawnLocation]["id"] = i
		carTable[currentCarSpawnLocation]["model"] = model
		carTable[currentCarSpawnLocation]["baseprice"] = price
		carTable[currentCarSpawnLocation]["name"] = name
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
		TriggerServerEvent("varial-tuner:CarTabletuner",carTable)
=======
		TriggerServerEvent("varial-pdm:CarTablePDM",carTable)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
		TriggerServerEvent("varial-pdm:CarTablePDM",carTable)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
		TriggerServerEvent("varial-pdm:CarTablePDM",carTable)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
		TriggerServerEvent("varial-pdm:CarTablePDM",carTable)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
	end
end

local myspawnedvehs = {}

:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
RegisterNetEvent("varial-tuner:testdrive")
AddEventHandler("varial-tuner:testdrive", function()
	if exports["isPed"]:GroupRank("tuner") >= 1 or #(vector3(-42.026374816895,-1094.5054931641,27.257934570312) - GetEntityCoords(PlayerPedId())) > 50.0 then
=======
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
RegisterNetEvent("varial-pdm:testdrive")
AddEventHandler("varial-pdm:testdrive", function()
	if exports["isPed"]:GroupRank("pdm") >= 1 or #(vector3(-42.026374816895,-1094.5054931641,27.257934570312) - GetEntityCoords(PlayerPedId())) > 50.0 then
:server-data/resources/[Files]/varial-pdm/cl_main.lua

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent('DoLongHudText', 'Could not locate vehicle!', 2)
		return
	end

	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-23.657140731812,-1094.6373291016,27.291625976562, 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,-47.8070,-1077.2463,26.7720,69.57,true,false)
		local vehplate = "STR"..math.random(10000,99999)
		SetVehicleNumberPlateText(veh, vehplate)
		local plate = GetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		TriggerEvent("keys:addNew",vehplate, plate)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)

		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		Citizen.Wait(100)
		exports['varial-interaction']:hideInteraction()
		myspawnedvehs[veh] = true
		end
	else
		TriggerEvent('DoLongHudText', 'A car is on the spawn point.', 2)
	end
end)

:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
RegisterNetEvent("varial-tuner:EnableBuy")
AddEventHandler("varial-tuner:EnableBuy", function()
	if #(vector3(-42.026374816895,-1094.5054931641,27.257934570312) - GetEntityCoords(PlayerPedId())) > 50.0 and exports["isPed"]:GroupRank("tuner_shop") >= 1 then
=======
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
RegisterNetEvent("varial-pdm:EnableBuy")
AddEventHandler("varial-pdm:EnableBuy", function()
	if #(vector3(-42.026374816895,-1094.5054931641,27.257934570312) - GetEntityCoords(PlayerPedId())) > 50.0 and exports["isPed"]:GroupRank("pdm") >= 1 then
:server-data/resources/[Files]/varial-pdm/cl_main.lua
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent('DoLongHudText', 'Could not locate vehicle!', 2)
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
	TriggerServerEvent("varial-tuner:BuyEnabledSV",vehplate)
end)

RegisterNetEvent("varial-tuner:BuyEnabledCL")
AddEventHandler("varial-tuner:BuyEnabledCL", function(addplate)
=======
	TriggerServerEvent("varial-pdm:BuyEnabledSV",vehplate)
end)

RegisterNetEvent("varial-pdm:BuyEnabledCL")
AddEventHandler("varial-pdm:BuyEnabledCL", function(addplate)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
	TriggerServerEvent("varial-pdm:BuyEnabledSV",vehplate)
end)

RegisterNetEvent("varial-pdm:BuyEnabledCL")
AddEventHandler("varial-pdm:BuyEnabledCL", function(addplate)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
	TriggerServerEvent("varial-pdm:BuyEnabledSV",vehplate)
end)

RegisterNetEvent("varial-pdm:BuyEnabledCL")
AddEventHandler("varial-pdm:BuyEnabledCL", function(addplate)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
	TriggerServerEvent("varial-pdm:BuyEnabledSV",vehplate)
end)

RegisterNetEvent("varial-pdm:BuyEnabledCL")
AddEventHandler("varial-pdm:BuyEnabledCL", function(addplate)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
	buyPlate[addplate] = true
	Citizen.Wait(60000)
	buyPlate[addplate] = nil
end)

:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
RegisterNetEvent("varial-tuner:tunerCommission")
AddEventHandler("varial-tuner:tunerCommission", function(newAmount)
	if exports["isPed"]:GroupRank("tuner_shop") >= 1 or #(vector3(-42.026374816895,-1094.5054931641,27.257934570312) - GetEntityCoords(PlayerPedId())) > 50.0 then
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("varial-tuner:CarTabletuner",carTable)
=======
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
RegisterNetEvent("varial-pdm:PDMCommission")
AddEventHandler("varial-pdm:PDMCommission", function(newAmount)
	if exports["isPed"]:GroupRank("pdm") >= 1 or #(vector3(-42.026374816895,-1094.5054931641,27.257934570312) - GetEntityCoords(PlayerPedId())) > 50.0 then
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("varial-pdm:CarTablePDM",carTable)
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
			end
		end
	end
end)

:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
RegisterNetEvent("varial-tuner:ReturntunerTTable")
AddEventHandler("varial-tuner:ReturntunerTTable", function(newTable)
=======
RegisterNetEvent("varial-pdm:ReturnPDMTTable")
AddEventHandler("varial-pdm:ReturnPDMTTable", function(newTable)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
RegisterNetEvent("varial-pdm:ReturnPDMTTable")
AddEventHandler("varial-pdm:ReturnPDMTTable", function(newTable)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
RegisterNetEvent("varial-pdm:ReturnPDMTTable")
AddEventHandler("varial-pdm:ReturnPDMTTable", function(newTable)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
RegisterNetEvent("varial-pdm:ReturnPDMTTable")
AddEventHandler("varial-pdm:ReturnPDMTTable", function(newTable)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
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
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end
			DisableControlAction(0,23)
			if IsControlJustReleased(0,47) and buyPlate[addplate] ~= nil then
				TriggerEvent('DoLongHudText', 'Attempting Purchase!', 1)
				AttemptBuy(i, false)
			end
		end
	end
end

function AttemptBuy(tableid)

	local veh = GetClosestVehicle(carspawns[tableid]["x"],carspawns[tableid]["y"],carspawns[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent('DoLongHudText', 'Could not locate vehicle!', 2)
		return
	end

	local model = carTable[tableid]["model"]
	local commission = carTable[tableid]["commission"]
	local baseprice = carTable[tableid]["baseprice"]
	local name = carTable[tableid]["name"]
	local price = baseprice + (baseprice * commission/ 100)

	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerEvent("keys:addNew",veh, plate)
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
	TriggerServerEvent('varial-tuner:ChechMoney',name, model, price)
=======
	TriggerServerEvent('varial-pdm:ChechMoney',name, model, price)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
	TriggerServerEvent('varial-pdm:ChechMoney',name, model, price)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
	TriggerServerEvent('varial-pdm:ChechMoney',name, model, price)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
	TriggerServerEvent('varial-pdm:ChechMoney',name, model, price)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
	commissionbuy = (baseprice * commission / 100)
	Citizen.Wait(100)
	exports['varial-interaction']:hideInteraction()
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
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 1.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			icon = "<center><i class='fas fa-car' style=' color: white;font-size: 25px;text-align:center; padding:5px;'></i></center>"
			if exports["isPed"]:GroupRank("tuner_shop") >= 1 then
				if buyPlate[addplate] ~= nil then
					exports['varial-interaction']:showInteraction("$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy.")
				else
					exports['varial-interaction']:showInteraction("$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change")
				end
			else
				if buyPlate[addplate] ~= nil then
					exports['varial-interaction']:showInteraction("$" .. math.ceil(price) .. " [G] to buy.")
				else
					exports['varial-interaction']:showInteraction("Buy Price: $" .. math.ceil(price) .. " ")
				end
			end
		elseif #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			exports['varial-interaction']:hideInteraction()
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
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
		TriggerServerEvent("varial-tuner:RequesttunerTTable")
=======
		TriggerServerEvent("varial-pdm:RequestPDMTTable")
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
		TriggerServerEvent("varial-pdm:RequestPDMTTable")
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
		TriggerServerEvent("varial-pdm:RequestPDMTTable")
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
		TriggerServerEvent("varial-pdm:RequestPDMTTable")
:server-data/resources/[Files]/varial-pdm/cl_main.lua
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

Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {191,"Enter"}}
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
			AddTextComponentString('Premium Deluxe Motorsport')
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

				if #(vector3(-23.657140731812,-1094.6373291016,27.291625976562) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(-23.657140731812,-1094.6373291016,27.291625976562,"["..Controlkey["generalUse"][2].."] Return Vehicle")
						if IsControlJustReleased(0,Controlkey["generalUse"][1]) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
					if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 100 then
						currentlocation = b
						if not vehicles_spawned then
--							print("Spawning Display Vehicles?")
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 35 then
							DrawPrices()
						end

						if exports["isPed"]:GroupRank("tuner_shop") >= 1 then
							OwnerMenu()
						end
						BuyMenu()
					else
						if vehicles_spawned then
--							print("Despawning Display ?")
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
	exports['varial-interaction']:hideInteraction()
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price, plate)
	Citizen.CreateThread(function()
		local ped = LocalPed()
		local pPrice = price
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
			personalvehicle = CreateVehicle(model,-47.8070, -1077.2463, 26.7720,true,false)
			SetEntityHeading(personalvehicle, 342.99212646484)
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
			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
			SetEntityVisible(ped,true)			
			local primarycolor = colors[1]
			local secondarycolor = colors[2]	
			local pearlescentcolor = extra_colors[1]
			local wheelcolor = extra_colors[2]
			local VehicleProps = exports['varial-base']:FetchVehProps(personalvehicle)
			local model = GetEntityModel(personalvehicle)
			local vehname = GetDisplayNameFromVehicleModel(model)
			SetVehicleNumberPlateText(personalvehicle, plate)
			TriggerEvent("keys:addNew",personalvehicle, plate)
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
			TriggerServerEvent('varial-tuner:BuyVehicle', plate, name, vehicle, price, VehicleProps)
=======
			TriggerServerEvent('varial-pdm:BuyVehicle', plate, name, vehicle, price, VehicleProps)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
			TriggerServerEvent('varial-pdm:BuyVehicle', plate, name, vehicle, price, VehicleProps)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
			TriggerServerEvent('varial-pdm:BuyVehicle', plate, name, vehicle, price, VehicleProps)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
			TriggerServerEvent('varial-pdm:BuyVehicle', plate, name, vehicle, price, VehicleProps)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
			DespawnSaleVehicles()
			SpawnSaleVehicles()
			Citizen.Wait(100)
			exports['varial-interaction']:hideInteraction()
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
RegisterNetEvent("varial-tuner:FailedPurchase")
AddEventHandler("varial-tuner:FailedPurchase", function()
=======
RegisterNetEvent("varial-pdm:FailedPurchase")
AddEventHandler("varial-pdm:FailedPurchase", function()
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
RegisterNetEvent("varial-pdm:FailedPurchase")
AddEventHandler("varial-pdm:FailedPurchase", function()
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
RegisterNetEvent("varial-pdm:FailedPurchase")
AddEventHandler("varial-pdm:FailedPurchase", function()
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
RegisterNetEvent("varial-pdm:FailedPurchase")
AddEventHandler("varial-pdm:FailedPurchase", function()
:server-data/resources/[Files]/varial-pdm/cl_main.lua
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
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
		DrawRect(x,y,menu.width,menu.height,255,55,55,220)
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
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(250,250,250, 255)
	end

	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,255,255,255)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,55,55,220)
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
		if btn == "Job Vehicles" then
			OpenMenu('jobvehicles')
		elseif btn == "Tuners" then
			OpenMenu('tuners')
		elseif btn == "Casino" then
			OpenMenu('casino')
		elseif btn == "Compacts" then
			OpenMenu('compacts')
		elseif btn == "Coupes" then
			OpenMenu('coupes')
		elseif btn == "Muscle" then
			OpenMenu('muscle')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "Sedans" then
			OpenMenu("sedans")
		elseif btn == "Sports" then
			OpenMenu('sports')
		elseif btn == "Sports Classics" then
			OpenMenu('sportsclassics')
		elseif btn == "Supers" then
			OpenMenu('supers')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
		end
	elseif this == "jobvehicles" or this == "tuners" or this == "casino" or this == "compacts" or this == "coupes" or this == "muscle" or this == "offroad" or this == "sedans" or this == "sports" or this == "sportsclassics" or this == "supers" or this == "suvs" or this == "vans" or this == "cycles" or this == "motorcycles" then
		if ownerMenu then
			updateCarTable(button.model,button.costs,button.name)
		else
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
			TriggerServerEvent('varial-tuner:ChechMoney',button.name, button.model, button.costs)
=======
			TriggerServerEvent('varial-pdm:ChechMoney',button.name, button.model, button.costs)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
			TriggerServerEvent('varial-pdm:ChechMoney',button.name, button.model, button.costs)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
			TriggerServerEvent('varial-pdm:ChechMoney',button.name, button.model, button.costs)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
			TriggerServerEvent('varial-pdm:ChechMoney',button.name, button.model, button.costs)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
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
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "tuners" or vehshop.currentmenu == "casino" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "supers" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "cycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1]) ) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then

			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				--local br = button.rank ~= nil and button.rank or 0
				if exports["isPed"]:GroupRank("tuner_shop") >= 1 and i >= vehshop.menu.from and i <= vehshop.menu.to then

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
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "tuners" or vehshop.currentmenu == "casino" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "supers" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "cycles" then
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

AddEventHandler('FinishMoneyCheckForVehtuner', function(name, vehicle, price, plate)
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price, plate)
	TriggerServerEvent("server:GroupPayment","tuner_shop",commissionbuy)
end)

local firstspawn = 0

ShowVehshopBlips(true)
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		--326 car blip 227 225
		ShowVehshopBlips(true)
		firstspawn = 1
	end
end)

AddEventHandler('tunervehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
			Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)

RegisterCommand('commission', function(source, args, raw)
	if exports["isPed"]:GroupRank("tuner_shop") >= 1 then
		local amount = args[1]
		if tonumber(amount) > 0 and tonumber(amount) <= 60 then
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
			TriggerEvent('varial-tuner:tunerCommission', amount)
=======
			TriggerEvent('varial-pdm:PDMCommission', amount)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
			TriggerEvent('varial-pdm:PDMCommission', amount)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
			TriggerEvent('varial-pdm:PDMCommission', amount)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
			TriggerEvent('varial-pdm:PDMCommission', amount)
:server-data/resources/[Files]/varial-pdm/cl_main.lua
		else
			TriggerEvent('DoLongHudText', 'Invalid amount "/commision [amount]', 2)
		end
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterCommand('testdrive', function(source, args, raw)
:server-data/resources/[Files]/varial-tuner/cl_main.lua
	if exports["isPed"]:GroupRank("tuner_shop") >= 1 then
		TriggerEvent('varial-tuner:testdrive')
=======
	if exports["isPed"]:GroupRank("pdm") >= 1 then
		TriggerEvent('varial-pdm:testdrive')
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterCommand('enableBuy', function(source, args, raw)
:server-data/resources/[Files]/varial-tuner/cl_main.lua
	if exports["isPed"]:GroupRank("tuner_shop") >= 1 then
		TriggerEvent('varial-tuner:EnableBuy')
=======
	if exports["isPed"]:GroupRank("pdm") >= 1 then
		TriggerEvent('varial-pdm:EnableBuy')
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-tuner/cl_main.lua
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
=======
:server-data/resources/[Files]/varial-pdm/cl_main.lua
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)
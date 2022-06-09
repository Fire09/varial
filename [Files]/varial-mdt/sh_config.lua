Config = {}

Config["MDTCommand"] = "mdt"

Config["PoliceJobs"] = {
    "police",
    "sheriff",
    "state"
}

Config["EMSJobs"] = {
    "ems"
}

Config["PoliceRosterLink"] = "https://docs.google.com/spreadsheets/d/1xU2snNwHx9WRzSC2yuiJ3_CT-IYDENM-nplGCvDnay8/edit?usp=sharing"

-- Config["EMSRosterLink"] = ""

Config["PublicRecords"] = {
     ['Coords'] = vector3(-551.054, -192.46, 38.22),
     ['AllowImageChange'] = false
}

Config["SQLWrapper"] = "oxmysql"

Config["CoreSettings"]  = {
    ["Core"] = "drpbase",
    ["DRPBase"] = {
        ["CoreName"] = "varial-base"
    }
}

Config['OffensesTitels'] = {
        [1] = ''
}

Config["Offenses"] = {
    [1] = {
        [1] = { title = 'Intimidation', class = 'Misdemeanor', id = 'A1', months = 10, fine = 500, color = 'orange' },
        [2] = { title = 'Assault', class = 'Misdemeanor', id = 'A2', months = 15, fine = 1200, color = 'orange' },
        [3] = { title = 'Assault with a Deadly Weapon', class = 'Felony', id = 'A3', months = 20, fine = 2000, color = 'red' },
        [4] = { title = 'Mutual Combat', class = 'Misdemeanor', id = 'A4', months = 10, fine = 750, color = 'orange' },
        [5] = { title = 'Battery', class = 'Misdemeanor', id = 'A5', months = 15, fine = 1000, color = 'orange' },
        [6] = { title = 'Aggravated Battery', class = 'Felony', id = 'A6', months = 25, fine = 2000, color = 'red' },
        [7] = { title = 'Attempted Murder', class = 'Felony', id = 'A7', months = 50, fine = 2500, color = 'red' },
        [8] = { title = 'Manslaughter', class = 'Felony', id = 'A8', months = 30, fine = 2500, color = 'red' },
        [9] = { title = 'Murder', class = 'Felony', id = 'A9', months = 60, fine = 5000, color = 'red' },
        [10] = { title = 'False Imprisonment', class = 'Felony', id = 'A10', months = 20, fine = 2000, color = 'red' },
        [11] = { title = 'Kidnapping', class = 'Felony', id = 'A11', months = 30, fine = 2500, color = 'red' },
        [12] = { title = 'Mayhem', class = 'Felony', id = 'A12', months = 20, fine = 3000, color = 'red' },
        [13] = { title = 'Vehicular Murder', class = 'Felony', id = 'A13', months = 60, fine = 5000, color = 'red' },
        [14] = { title = 'Assault on a Government Official, Class C (1-2)', class = 'Felony', id = 'A14', months = 25, fine = 2500, color = 'red' },
        [15] = { title = 'Assault on a Government Official, Class B (3-5)', class = 'Felony', id = 'A15', months = 45, fine = 5000, color = 'red' },
        [16] = { title = 'Assault on a Government Official, Class A (6+)', class = 'Felony', id = 'A16', months = 70, fine = 7500, color = 'red' },
        [17] = { title = 'Torture', class = 'Felony', id = 'A17', months = 45, fine = 4500, color = 'red' },
        [18] = { title = 'Trespassing', class = 'Misdemeanor', id = 'B1', months = 10, fine = 500, color = 'orange' },
        [19] = { title = 'Trespassing within a Restricted Zone', class = 'Felony', id = 'B2', months = 20, fine = 1000, color = 'orange' },
        [20] = { title = 'Burglary', class = 'Misdemeanor', id = 'B3', months = 15, fine = 1200, color = 'orange' },
        [21] = { title = 'Aggravated Burglary', class = 'Felony', id = 'B4', months = 25, fine = 2200, color = 'red' },
        [22] = { title = 'Possession of Burglary Tools.', class = 'Infraction', id = 'B5', months = 10, fine = 1500, color = 'blue' },
        [23] = { title = 'Intent to Distribute Burglary Tools', class = 'Felony', id = 'B6', months = 50, fine = 5000, color = 'red' },
        [24] = { title = 'Robbery', class = 'Felony', id = 'B7', months = 15, fine = 1200, color = 'red' },    
        [25] = { title = 'Armed Robbery', class = 'Felony', id = 'B8', months = 25, fine = 2500, color = 'red' }, 
        [26] = { title = 'Petty Larceny', class = 'Misdemeanor', id = 'B9', months = 5, fine = 500, color = 'orange' },
        [27] = { title = 'Larceny', class = 'Misdemeanor', id = 'B10', months = 15, fine = 1200, color = 'orange' },
        [28] = { title = 'Grand Larceny', class = 'Felony', id = 'B11', months = 20, fine = 2500, color = 'red' },
        [29] = { title = 'Grand Theft Auto', class = 'Felony', id = 'B12', months = 20, fine = 2500, color = 'red' },
        [30] = { title = 'Receiving Stolen Property', class = 'Misdemeanor', id = 'B13', months = 10, fine = 1200, color = 'orange' },
        [31] = { title = 'Extortion', class = 'Felony', id = 'B14', months = 30, fine = 2500, color = 'red' },
        [32] = { title = 'Forgery', class = 'Misdemeanor', id = 'B15', months = 15, fine = 1500, color = 'orange' },
        [33] = { title = 'Fraud', class = 'Felony', id = 'B16', months = 25, fine = 2500, color = 'red' },
        [34] = { title = 'Vandalism', class = 'Misdemeanor', id = 'B17', months = 5, fine = 1200, color = 'orange' },
        [35] = { title = 'Grand Theft Auto (Commercial Vehicle)', class = 'Felony', id = 'B18', months = 30, fine = 3000, color = 'red' },
        [36] = { title = 'Contraband', class = 'Misdemeanor', id = 'B19', months = 0, fine = 250, color = 'orange' },
        [37] = { title = 'Indecent Exposure', class = 'Infraction', id = 'C1', months = 0, fine = 750, color = 'blue' },
        [38] = { title = 'Sexual Assault', class = 'Misdemeanor', id = 'C2', months = 30, fine = 3000, color = 'orange' },
        [39] = { title = 'Stalking', class = 'Felony', id = 'C3', months = 60, fine = 5000, color = 'red' },
        [40] = { title = 'Bribery', class = 'Felony', id = 'D1', months = 40, fine = 5000, color = 'red' },
        [41] = { title = 'Failure to Pay a Fine', class = 'Misdemeanor', id = 'D2', months = 5, fine = 500, color = 'orange' },
        [42] = { title = 'Contempt of Court', class = 'Misdemeanor', id = 'D3', months = 240, fine = 20000, color = 'orange' },
        [43] = { title = 'Subpoena Violation', class = 'Misdemeanor', id = 'D4', months = 240, fine = 20000, color = 'orange' },
        [44] = { title = 'Dissuading a Witness or Victim', class = 'Felony', id = 'D5', months = 60, fine = 5000, color = 'red' },
        [45] = { title = 'False Information to a Government Employee', class = 'Misdemeanor', id = 'D6', months = 15, fine = 2500, color = 'orange' },
        [46] = { title = 'Filing a False Complaint', class = 'Misdemeanor', id = 'D7', months = 15, fine = 2500, color = 'orange' },
        [47] = { title = 'Perjury', class = 'Felony', id = 'D8', months = 60, fine = 7500, color = 'red' },
        [48] = { title = 'Failure to Identify to a Peace Officer', class = 'Misdemeanor', id = 'D9', months = 10, fine = 1200, color = 'orange' },
        [49] = { title = 'Impersonation of a Government Employee', class = 'Misdemeanor', id = 'D10', months = 30, fine = 5000, color = 'orange' },
        [50] = { title = 'Obstruction of a Government Employee', class = 'Misdemeanor', id = 'D11', months = 15, fine = 2500, color = 'orange' },
        [51] = { title = 'Resisting a Peace Officer', class = 'Misdemeanor', id = 'D12', months = 15, fine = 2000, color = 'orange' },
        [52] = { title = 'Escape from Custody', class = 'Felony', id = 'D13', months = 50, fine = 7500, color = 'red' },
        [53] = { title = 'Escape', class = 'Felony', id = 'D14', months = 50, fine = 7500, color = 'red' },
        [54] = { title = 'Misuse of a Government Hotline', class = 'Infraction', id = 'D16', months = 0, fine = 1000, color = 'blue' },
        [55] = { title = 'Tampering with Evidence', class = 'Felony', id = 'D17', months = 20, fine = 3000, color = 'red' },
        [56] = { title = 'Introduction of Contraband', class = 'Felony', id = 'D18', months = 40, fine = 5000, color = 'red' },
        [57] = { title = 'Violation of Parole or Probation', class = 'Felony', id = 'D19', months = 30, fine = 2500, color = 'red' },
        [58] = { title = 'Voter Fraud/Voter Pandering', class = 'Felony', id = 'D20', months = 40, fine = 3000, color = 'red' },
        [59] = { title = 'Corruption of Public Duty', class = 'Felony', id = 'D21', months = 200, fine = 20000, color = 'red' },
        [60] = { title = 'Corruption of Public Office', class = 'Felony', id = 'D22', months = 200, fine = 20000, color = 'red' },
        [61] = { title = 'Filing a False Claim/Fraud', class = 'Felony', id = 'D23', months = 30, fine = 2500, color = 'red' },
        [62] = { title = 'Disturbing the Peace', class = 'Misdemeanor', id = 'E1', months = 15, fine = 1200, color = 'orange' },
        [63] = { title = 'Unlawful Assembly', class = 'Misdemeanor', id = 'E2', months = 20, fine = 1500, color = 'orange' },
        [64] = { title = 'Incitement to Riot', class = 'Felony', id = 'E3', months = 30, fine = 5000, color = 'red' },
        [65] = { title = 'Vigilantism', class = 'Felony', id = 'E4', months = 30, fine = 6000, color = 'red' },
        [66] = { title = 'Terrorism', class = 'Felony', id = 'E5', months = 999, fine = 0, color = 'red' },
        [67] = { title = 'Aiding and Abetting', class = 'Misdemeanor', id = 'E6', months = 25, fine = 1000, color = 'orange' },
        [68] = { title = 'Terroristic Threats', class = 'Felony', id = 'E7', months = 50, fine = 5000, color = 'red' },
        [69] = { title = 'Communicating a Threat', class = 'Misdemeanor', id = 'E8', months = 15, fine = 1500, color = 'orange' },
        [70] = { title = 'Possession of a Controlled Substance', class = 'Misdemeanor', id = 'F1', months = 10, fine = 1200, color = 'orange' },
        [71] = { title = 'Possession of a Controlled Substance with Intent to Sell', class = 'Felony', id = 'F2', months = 30, fine = 5000, color = 'red' },
        [72] = { title = 'Possession of Drug Paraphernalia', class = 'Infraction', id = 'F3', months = 5, fine = 1200, color = 'blue' },
        [73] = { title = 'Maintaining a Place for Purpose of Distribution', class = 'Felony', id = 'F4', months = 15, fine = 2000, color = 'red' },
        [74] = { title = 'Manufacture of a Controlled Substance', class = 'Felony', id = 'F5', months = 30, fine = 5000, color = 'red' },
        [75] = { title = 'Sale of a Controlled Substance', class = 'Felony', id = 'F6', months = 30, fine = 5000, color = 'red' },
        [76] = { title = 'Possession of an Open Container', class = 'Infraction', id = 'F7', months = 0, fine = 500, color = 'blue' },
        [77] = { title = 'Public Intoxication', class = 'Misdemeanor', id = 'F8', months = 10, fine = 1500, color = 'orange' },
        [78] = { title = 'Under the Influence of a Controlled Substance', class = 'Misdemeanor', id = 'F9', months = 10, fine = 1200, color = 'orange' },
        [79] = { title = 'Possession of Marijuana (See Penal Code)', class = 'Modifier', id = 'F10', months = 0, fine = 0, color = 'yellow' },
        [80] = { title = 'Animal Abuse/Cruelty', class = 'Felony', id = 'G1', months = 20, fine = 2500, color = 'red' },
        [81] = { title = 'Animal Abuse/Cruelty (Police K9)', class = 'Felony', id = 'G1.1', months = 120, fine = 20000, color = 'red' },
        [82] = { title = 'Hunting/Fishing with a Commercial Vehicle', class = 'Infraction', id = 'G2', months = 0, fine = 1200, color = 'blue' },
        [83] = { title = 'Driving with a Suspended License', class = 'Misdemeanor', id = 'H1', months = 5, fine = 1200, color = 'orange' },
        [84] = { title = 'Evading a Peace Officer', class = 'Misdemeanor', id = 'H2', months = 15, fine = 1500, color = 'orange' },
        [85] = { title = 'Evading a Peace Officer - High Performance Vehicle', class = 'Felony', id = 'H3', months = 40, fine = 3000, color = 'red' },
        [86] = { title = 'Evading a Peace Officer - Oversized Vehicle', class = 'Felony', id = 'H4', months = 30, fine = 2500, color = 'red' },
        [87] = { title = 'Evading a Peace Officer - Naval Vessel', class = 'Felony', id = 'H5', months = 30, fine = 2500, color = 'red' },
        [88] = { title = 'Hit and Run', class = 'Felony', id = 'H6', months = 10, fine = 2000, color = 'red' },
        [89] = { title = 'Reckless Operation of an Offroad or Naval Vehicle', class = 'Misdemeanor', id = 'H7', months = 10, fine = 1000, color = 'orange' },
        [90] = { title = 'Felony Evasion', class = 'Felony', id = 'H8', months = 30, fine = 3000, color = 'red' },
        [91] = { title = 'Possession of a Prohibited Weapon', class = 'Misdemeanor', id = 'I1', months = 10, fine = 1500, color = 'orange' },
        [92] = { title = 'Possession of an Unlicensed Firearm', class = 'Misdemeanor', id = 'I2', months = 20, fine = 1500, color = 'orange' },
        [93] = { title = 'Possession of an Illegal Firearm', class = 'Felony', id = 'I3', months = 25, fine = 5000, color = 'red' },
        [94] = { title = 'Possession of an Automatic Weapon', class = 'Felony', id = 'I4', months = 40, fine = 7500, color = 'red' },
        [95] = { title = 'Unlicensed Distribution of a Weapon', class = 'Felony', id = 'I5', months = 50, fine = 15000, color = 'red' },
        [96] = { title = 'Possession of an Explosive Device', class = 'Felony', id = 'I6', months = 30, fine = 10000, color = 'red' },
        [97] = { title = 'Manufacture or Possession of an Improvised Device', class = 'Felony', id = 'I7', months = 30, fine = 10000, color = 'red' },
        [98] = { title = 'Possession of Weaponry with Intent to Sell', class = 'Felony', id = 'I8', months = 30, fine = 10000, color = 'red' },
        [99] = { title = 'Possession of Explosive Devices with Intent to Sell', class = 'Felony', id = 'I9', months = 50, fine = 15000, color = 'red' },
        [100] = { title = 'Brandishing a Firearm', class = 'Misdemeanor', id = 'I10', months = 10, fine = 1200, color = 'orange' },
        [101] = { title = 'Weapons Discharge Violation', class = 'Misdemeanor', id = 'I11', months = 10, fine = 1200, color = 'orange' },
        [102] = { title = 'Drive by Shooting', class = 'Felony', id = 'I12', months = 30, fine = 3000, color = 'red' },
        [103] = { title = 'CCW/PF Violation', class = 'Misdemeanor', id = 'I13', months = 5, fine = 0, color = 'orange' },
        [104] = { title = 'Possession of Police Issued Equipment', class = 'Felony', id = 'I14', months = 15, fine = 2500, color = 'red' },
        [105] = { title = 'Possession of Police Issued Handgun', class = 'Felony', id = 'I15', months = 40, fine = 7500, color = 'red' },
        [106] = { title = 'Possession of Police Issued Rifles', class = 'Felony', id = 'I16', months = 50, fine = 12000, color = 'red' },
        [107] = { title = 'Exception', class = 'Modifier', id = 'J0', months = 0, fine = 0, color = 'yellow' },
        [108] = { title = 'Attempt', class = 'Modifier', id = 'J1', months = 0, fine = 0, color = 'yellow' },
        [109] = { title = 'Conspiracy', class = 'Modifier', id = 'J2', months = 0, fine = 0, color = 'yellow' },
        [110] = { title = 'Soliciting', class = 'Modifier', id = 'J3', months = 0, fine = 0, color = 'yellow' },
        [111] = { title = 'Government Woker Clause', class = 'Modifier', id = 'J4', months = 0, fine = 0, color = 'yellow' },
        [112] = { title = 'Plea Bargaining/Police Compliance Clause', class = 'Modifier', id = 'J5', months = 0, fine = 0, color = 'yellow' },
        [113] = { title = 'Three-Strikes Vehicle Policy', class = 'Modifier', id = 'J6', months = 0, fine = 0, color = 'yellow' },
        [114] = { title = 'Criminal Accomplice Clause', class = 'Modifier', id = 'J7', months = 0, fine = 0, color = 'yellow' },
        [115] = { title = 'Accessory After the Fact', class = 'Modifier', id = 'J8', months = 0, fine = 0, color = 'yellow' },
        [116] = { title = 'Gang Crimes Clause', class = 'Modifier', id = 'J9', months = 0, fine = 0, color = 'yellow' },
        [117] = { title = 'Speeding (Excess 5-14)', class = 'Infraction', id = 'K1', months = 0, fine = 250, color = 'blue' },
        [118] = { title = 'Speeding (Excess 15-29)', class = 'Infraction', id = 'K2', months = 0, fine = 500, color = 'blue' },
        [119] = { title = 'Speeding (30+)', class = 'Infraction', id = 'K3', months = 0, fine = 1200, color = 'blue' },
        [120] = { title = 'Failure to Abide by a Traffic Control Device', class = 'Infraction', id = 'K4', months = 0, fine = 400, color = 'blue' },
        [121] = { title = 'Yield Violation', class = 'Infraction', id = 'K5', months = 0, fine = 1500, color = 'blue' },
        [122] = { title = 'Parking Violation', class = 'Infraction', id = 'K6', months = 0, fine = 500, color = 'blue' },
        [123] = { title = 'Reckless Driving', class = 'Infraction', id = 'K7', months = 0, fine = 2000, color = 'blue' },
        [124] = { title = 'Aggravated Reckless Driving', class = 'Misdemeanor', id = 'K8', months = 10, fine = 4000, color = 'orange' },
        [125] = { title = 'Vehicular Noise Violation', class = 'Infraction', id = 'K9', months = 0, fine = 1000, color = 'blue' },
        [126] = { title = 'Illegal Nitrious Oxide Possession', class = 'Misdemeanor', id = 'K10', months = 10, fine = 2500, color = 'orange' },
        [127] = { title = 'Illegal use of Hydraulics', class = 'Infraction', id = 'K11', months = 0, fine = 1200, color = 'blue' },
        [128] = { title = 'Driving While Impaired (DWI)', class = 'Misdemeanor', id = 'K12', months = 10, fine = 1200, color = 'orange' },
        [129] = { title = 'Driving under the Influence (DUI)', class = 'Felony', id = 'K13', months = 20, fine = 2500, color = 'red' },
        [130] = { title = 'Registration Violation', class = 'Infraction', id = 'K14', months = 0, fine = 500, color = 'blue' },
        [131] = { title = 'Unsafe Usage of a Bicycle', class = 'Infraction', id = 'K15', months = 0, fine = 1200, color = 'blue' },
        [132] = { title = 'Street Racing', class = 'Misdemeanor', id = 'K16', months = 20, fine = 2000, color = 'orange' },
        [133] = { title = 'Driving without a Valid License', class = 'Misdemeanor', id = 'K17', months = 20, fine = 1500, color = 'orange' },
        [134] = { title = 'Jaywalking', class = 'Infraction', id = 'K18', months = 0, fine = 500, color = 'blue' },
        [135] = { title = 'Tinted Windows', class = 'Infraction', id = 'K19', months = 0, fine = 500, color = 'blue' },
        [136] = { title = 'Unlawful Transport of a Person(s) in a Cargo Area', class = 'Infraction', id = 'K20', months = 0, fine = 1000, color = 'blue' },
        [137] = { title = 'Fire Hydrant Parking Restriction', class = 'Infraction', id = 'K21', months = 0, fine = 1200, color = 'blue' },
        [138] = { title = 'Operation of an ATV within City Limits', class = 'Infraction', id = 'K22', months = 0, fine = 1200, color = 'blue' },
        [139] = { title = 'Laundering of Money Instruments', class = 'Felony', id = 'M2', months = 0, fine = 0, color = 'red' },
        [140] = { title = 'Gambling License Violation', class = 'Felony', id = 'M3', months = 40, fine = 6000, color = 'red' },
        [141] = { title = 'Legal Practice Violation', class = 'Misdemeanor', id = 'M4', months = 20, fine = 3000, color = 'orange' },
        [142] = { title = 'Wire Tapping ', class = 'Felony', id = 'M5', months = 15, fine = 4000, color = 'red' },
        [143] = { title = 'Criminal Business Operations', class = 'Misdemeanor', id = 'M6', months = 0, fine = 500, color = 'orange' },
        [144] = { title = 'Corporate Hijacking', class = 'Misdemeanor', id = 'M7', months = 30, fine = 5000, color = 'orange' },
        [145] = { title = 'Embezzlement', class = 'Felony', id = 'M8', months = 0, fine = 0, color = 'red' },
        }
}

Config["StaffLogs"] = {
    ["NewBulletin"] = "%s Created New Bulletin.",
    ["DeleteBulletin"] = "%s Deleted Bulletin.",
    ["NewIncident"] = "%s Created New Incident.",
    ["EditIncident"] = "%s Edited Incident.",
    ["DeleteIncident"] = "%s Deleted Incident.",
    ["NewReport"] = "%s Created New Report.",
    ["EditReport"] = "%s Edited Report.",
    ["DeleteReport"] = "%s Deleted Report.",
    ["NewBolo"] = "%s Created New Bolo.",
    ["EditBolo"] = "%s Edited Bolo.",
    ["DeleteBolo"] = "%s Deleted Bolo.",
}

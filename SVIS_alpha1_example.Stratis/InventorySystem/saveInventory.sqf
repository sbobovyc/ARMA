/**
  * @file saveInventory.sqf
  * @author sbobovyc
  * @details
  * Uses global array SVIS_INVENTORY
  */
  
//TODO check for binoculars and NVG
//TODO save secondary and pistole attachments
waitUntil {!(isNull player)};
waitUntil {player==player};  
// map, gps, watch, helmet, glasses, etc
_assigned_tems = assignedItems player;
//hint str(_items);

SVIS_INVENTORY = [];
_headgear = 	headgear player;
_goggles =		goggles player;
_uniform = 		uniform player;
_uniform_items = 	uniformItems player;
_vest_items = 	vestItems player;
_vest = 		vest player;
_backpack =		backpack player;
_backpack_items =	backpackItems player;
_primary_weapon = primaryWeapon player;
_secondary_weapon = secondaryWeapon player;
_handgun = 		handgunWeapon player;
_primary_items =	primaryWeaponItems player;
_secondary_items =  secondaryWeaponItems player;

SVIS_INVENTORY set[0, _headgear];
SVIS_INVENTORY set[1, _goggles];
SVIS_INVENTORY set[2, _uniform];
SVIS_INVENTORY set[3, _uniform_items];
SVIS_INVENTORY set[4, _vest];
SVIS_INVENTORY set[5, _vest_items];
SVIS_INVENTORY set[6, _backpack];
SVIS_INVENTORY set[7, _backpack_items];
SVIS_INVENTORY set[8, _primary_weapon];
SVIS_INVENTORY set[9, _secondary_weapon];
SVIS_INVENTORY set[10, _handgun];
SVIS_INVENTORY set[11, _primary_items];
SVIS_INVENTORY set[12, _secondary_items];


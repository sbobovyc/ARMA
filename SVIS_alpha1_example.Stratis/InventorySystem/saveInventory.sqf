/**
  * @file saveInventory.sqf
  * @author sbobovyc
  * @details
  * Uses global array SVIS_INVENTORY
  */
  
//TODO check for binoculars and NVG
//TODO save secondary and pistol attachments
waitUntil {!(isNull player)};
waitUntil {player==player};  
// map, gps, watch, helmet, glasses, etc
_assigned_items = assignedItems player;
diag_log format["SVIS: items %1", items player];
diag_log format["SVIS: weapons %1", weapons player];
diag_log format["SVIS: cargo %1", itemCargo player];
diag_log format["SVIS: assigned items %1", _assigned_items];
_nvg_flag = "NVGoggles" in _assigned_items || "NVGoggles_OPFOR" in _assigned_items || "NVGoggles_INDEP" in _assigned_items;
_range_finder_flag = "Rangefinder" in _assigned_items;
_binoculars_flag = "Binocular" in _assigned_items;
_map_flag = "ItemMap" in _assigned_items;
_compass_flag = "ItemCompass" in _assigned_items;
_watch_flag = "ItemWatch" in _assigned_items;
_radio_flag = "ItemRadio" in _assigned_items;
_gps_flag = "ItemGPS" in _assigned_items;
diag_log format["SVIS: saveInventory, Are NVG in inventory? %1", _nvg_flag];
diag_log format["SVIS: saveInventory, Is Binocular in inventory? %1", _binoculars_flag];
diag_log format["SVIS: saveInventory, Is RangeFinder in inventory? %1", _range_finder_flag];

SVIS_INVENTORY = [];
_headgear			=	headgear player;
_goggles			=	goggles player;
_uniform			=	uniform player;
_uniform_items		= 	uniformItems player;
_vest				=	vest player;
_vest_items 		= 	vestItems player;
_backpack			=	backpack player;
_backpack_items		=	backpackItems player;
_primary_weapon		=	primaryWeapon player;
_secondary_weapon	=	secondaryWeapon player;
_handgun			=	handgunWeapon player;
_primary_items		=	primaryWeaponItems player;
_secondary_items	=	secondaryWeaponItems player;
_nvg				=	_nvg_flag;
_range_finder		=	_range_finder_flag;
_binocular			=	_binoculars_flag;
_map				=	_map_flag;
_compass			=	_compass_flag;
_watch				=	_watch_flag;
_radio				=	_radio_flag;
_gps				=	_gps_flag;

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
SVIS_INVENTORY set[13, _nvg];
SVIS_INVENTORY set[14, _range_finder];
SVIS_INVENTORY set[15, _binocular];
SVIS_INVENTORY set[16, _map];
SVIS_INVENTORY set[17, _compass];
SVIS_INVENTORY set[18, _watch];
SVIS_INVENTORY set[19, _radio];
SVIS_INVENTORY set[20, _gps];

diag_log SVIS_INVENTORY;
// Create script for adding weapons and items in inventory and put it in the clipboard
//TODO This needs to be moved into its own function
_script = "removeAllWeapons this; removeHeadgear this; removeGoggles this; removeUniform this; removeVest this; removeBackpack this;";
    
if(_headgear != "") then {
    _script = _script + format["this addHeadgear ""%1"";", _headgear]
};    
    
if(_goggles != "") then {
    _script = _script + format["this addGoggles ""%1"";", _goggles]
};
    
if(_uniform != "") then {
    _script = _script + format["this addUniform ""%1"";", _uniform]
};    
    
if(_vest != "") then {
    _script = _script + format["this addVest ""%1"";", _vest]
};
    
if(_backpack != "") then {
    _script = _script + format["this addBackpack ""%1"";", _backpack]
};

{
    if(_x != "") then {
        _script = _script + format["[this, ""%1"", 1] call BIS_fnc_addWeapon;", _x];
    };
} forEach [_primary_weapon, _secondary_weapon, _handgun];

diag_log _script;
copyToClipboard _script;
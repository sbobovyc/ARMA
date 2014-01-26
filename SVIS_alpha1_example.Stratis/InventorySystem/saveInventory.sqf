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
_script = "addToInventory = compile preprocessFileLineNumbers ""InventorySystem\addToInventory.sqf""; ";

_script = _script + format["headgear_ = ""%1"";
goggles_ = ""%2"";
uniform_ = ""%3"";
uniform_items_ = %4;
vest_ = ""%5"";
vest_items_ = %6;
backpack_ = ""%7"";
backpack_items_ = %8;
primary_weapon_ = ""%9"";
secondary_weapon_ = ""%10"";
handgun_ = ""%11"";
primary_items_ = %12;
secondary_items_ = %13;
nvg_ = %14;
range_finder_ = %15;
binocular_ = %16;
map_ = %17;
compass_ = %18;
watch_ = %19;
radio_ = %20;
gps_ = %21;",
_headgear,
_goggles,
_uniform,
_uniform_items,
_vest,
_vest_items,
_backpack,
_backpack_items,
_primary_weapon,
_secondary_weapon,
_handgun,
_primary_items,
_secondary_items,
_nvg,
_range_finder,
_binocular,
_map,
_compass,
_watch,
_radio,
_gps];

_script = _script + "
	removeAllWeapons this;
	removeHeadgear this;
	removeGoggles this;	
	removeUniform this;
	removeVest this;
	removeBackpack this;
		
	this addHeadgear headgear_;	
	this addGoggles goggles_; 	
	this addUniform uniform_;
	this addVest vest_;
    if(backpack_ != """") then {
        this addBackpack backpack_;	
    };
    
    {
        if(_x != """") then {
            [this, _x, 1] call BIS_fnc_addWeapon;	
        };
    } forEach [primary_weapon_, secondary_weapon_, handgun_];    
	
	if(range_finder_) then {
		this removeWeapon ""Binocular"";
		this addWeapon ""Rangefinder"";
	};
	
	if(binocular_) then {
		this removeWeapon ""Rangefinder"";
		this addWeapon ""Binocular"";
	};	
		
	if(nvg_) then {
		this assignItem ""NVGoggles"";
	} else {
		switch(side this) do {
			case(west): {
				this unassignItem ""NVGoggles"";	
				this removeItem ""NVGoggles"";			
			};
			case(east): {
				this unassignItem ""NVGoggles_OPFOR"";	
				this removeItem ""NVGoggles_OPFOR"";				
			};
			case(independent): {
				this unassignItem ""NVGoggles_INDEP"";	
				this removeItem ""NVGoggles_INDEP"";					
			};
			default {
				diag_log ""SVIS: faction not detected"";
			}
		
		};
	};
		
	if(map_) then {
		this assignItem ""ItemMap"";	
	} else {
		this unassignItem ""ItemMap"";	
	};

	if(compass_) then {
		this assignItem ""ItemCompass"";	
	} else {
		this unassignItem ""ItemCompass"";	
	};	
	
	if(watch_) then {
		this assignItem ""ItemWatch"";	
	} else {
		this unassignItem ""ItemWatch"";	
	};	
	
	if(radio_) then {
		this assignItem ""ItemRadio"";	
	} else {
		this unassignItem ""ItemRadio"";	
	};		

	if(gps_) then {
		this assignItem ""ItemGPS"";	
	} else {
		this unassignItem ""ItemGPS"";	
	};			
	
	{
		this removePrimaryWeaponItem _x;
	} forEach (primaryWeaponItems this);
	
	{
		this addPrimaryWeaponItem _x;
	} forEach primary_items_;
	
	{
		this removeItem _x;			
	} forEach (secondaryWeaponItems this);
	
	{
		this addSecondaryWeaponItem _x;
	} forEach secondary_items_;	
	
	[this, uniform_items_] call addToInventory;
	[this, vest_items_] call addToInventory;
	[this, backpack_items_] call addToInventory;

	this selectWeapon primary_weapon_;";
    

diag_log _script;
copyToClipboard _script;
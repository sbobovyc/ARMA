/**
  * @file loadInventory.sqf
  * @author sbobovyc
  * @details
  * Uses global array SVIS_INVENTORY
  * TODO: put assigned items in a single array
  */

  addToInventory = compile preprocessFileLineNumbers "InventorySystem\addToInventory.sqf";

waitUntil {!(isNull player)};
waitUntil {player==player};


_headgear =		SVIS_INVENTORY select 0;
_goggles =	 	SVIS_INVENTORY select 1;
_uniform = 		SVIS_INVENTORY select 2;
_uniform_items = 	SVIS_INVENTORY select 3;
_vest = 		SVIS_INVENTORY select 4;
_vest_items = 		SVIS_INVENTORY select 5;
_backpack = 		SVIS_INVENTORY select 6;
_backpack_items =	SVIS_INVENTORY select 7;
_primary_weapon =	SVIS_INVENTORY select 8;
_secondary_weapon =	SVIS_INVENTORY select 9;
_handgun = 		SVIS_INVENTORY select 10;
_primary_items = 	SVIS_INVENTORY select 11;
_secondary_items = 	SVIS_INVENTORY select 12;
_nvg =			SVIS_INVENTORY select 13;
_range_finder		= SVIS_INVENTORY select 14;
_binocular			= SVIS_INVENTORY select 15;
_map				=	SVIS_INVENTORY select 16;
_compass				=	SVIS_INVENTORY select 17;
_watch					=	SVIS_INVENTORY select 18;
_radio					=	SVIS_INVENTORY select 19;
_gps					=	SVIS_INVENTORY select 20;

diag_log format["SVIS: loadInventory, %1", SVIS_INVENTORY];
diag_log format["SVIS: loadInventory, %1", assignedItems player];
diag_log format["SVIS: loadInventory, are NVG in inventory? %1", _nvg];
diag_log format["SVIS: loadInventory, is Rangefinder in inventory? %1", _range_finder];
diag_log format["SVIS: loadInventory, is Binocular in inventory? %1", _binocular];

// handle the case that the user did not save an inventory
if( (count SVIS_INVENTORY) != 0) then
{
	// remove primary weapon and add the saved one
	removeAllWeapons player;
	removeHeadgear player;
	removeGoggles player;	
	removeUniform player;
	removeVest player;
	removeBackpack player;
		
	player addHeadgear _headgear;	
	player addGoggles _goggles; 
	player addUniform _uniform;
	player addVest _vest;
    if(_backpack != "") then {
        player addBackpack _backpack;	
    };
    	
    {
        if(_x != "") then {
            [player, _x, 1] call BIS_fnc_addWeapon;	//add weapon last, or mag won't be added	
        };
    } forEach [_primary_weapon, _secondary_weapon, _handgun];    
	
	if(_range_finder) then {
		player removeWeapon "Binocular";
		player addWeapon "Rangefinder";
	};
	
	if(_binocular) then {
		player removeWeapon "Rangefinder";
		player addWeapon "Binocular";
	};	
		
	if(_nvg) then {
		player assignItem "NVGoggles";
	} else {
		switch(side player) do {
			case(west): {
				player unassignItem "NVGoggles";	
				player removeItem "NVGoggles";			
			};
			case(east): {
				player unassignItem "NVGoggles_OPFOR";	
				player removeItem "NVGoggles_OPFOR";				
			};
			case(independent): {
				player unassignItem "NVGoggles_INDEP";	
				player removeItem "NVGoggles_INDEP";					
			};
			default {
				diag_log "SVIS: loadInventory, faction not detected";
			}
		
		};
	};
		
	if(_map) then {
		player assignItem "ItemMap";	
	} else {
		player unassignItem "ItemMap";	
	};

	if(_compass) then {
		player assignItem "ItemCompass";	
	} else {
		player unassignItem "ItemCompass";	
	};	
	
	if(_watch) then {
		player assignItem "ItemWatch";	
	} else {
		player unassignItem "ItemWatch";	
	};	
	
	if(_radio) then {
		player assignItem "ItemRadio";	
	} else {
		player unassignItem "ItemRadio";	
	};		

	if(_gps) then {
		player assignItem "ItemGPS";	
	} else {
		player unassignItem "ItemGPS";	
	};			
	
	{
		player removePrimaryWeaponItem _x;
	} forEach (primaryWeaponItems player);
	
	{
		player addPrimaryWeaponItem _x;
	} forEach _primary_items;
	
	{
		player removeItem _x;			//TODO this is not working
	} forEach (secondaryWeaponItems player);
	
	{
		player addSecondaryWeaponItem _x;
	} forEach _secondary_items;	
	
	[player, _uniform_items] call addToInventory;
	[player, _vest_items] call addToInventory;
	[player, _backpack_items] call addToInventory;

	player selectWeapon _primary_weapon;
};

/**
  * @file loadInventory.sqf
  * @author sbobovyc
  * @details
  * Uses global array SVIS_INVENTORY
  * TODO: put assigned items in a single array
  */

addToInventory = compile preprocessFileLineNumbers "InventorySystem\addToInventory.sqf";

_entity = nil;
_init = nil;

if(isNil("SVIS_INVENTORY")) exitWith{};

// if call originated from AddAction
if ((count _this) > 2) then {
    _entity = _this select 1; // get caller
    _init = false;
} else {
    _entity = _this select 0;
    _init = if((count _this) > 1) then {_this select 1} else {false};
};

diag_log format["SVIS: loadInventory, this is %1, %2", _this, count _this];
diag_log format["SVIS: loadInventory, _entity is %1", _entity];
diag_log format["SVIS: loadInventory, init is %1", _init];

if (!_init) then {
    waitUntil {!(isNull player)};
    waitUntil {player==player};
};



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
diag_log format["SVIS: loadInventory, %assigned items: 1", assignedItems _entity];
diag_log format["SVIS: loadInventory, are NVG in inventory? %1", _nvg];
diag_log format["SVIS: loadInventory, is Rangefinder in inventory? %1", _range_finder];
diag_log format["SVIS: loadInventory, is Binocular in inventory? %1", _binocular];

// handle the case that the user did not save an inventory
if( (count SVIS_INVENTORY) != 0) then
{
	// remove primary weapon and add the saved one
	removeAllWeapons _entity;
	removeHeadgear _entity;
	removeGoggles _entity;	
	removeUniform _entity;
	removeVest _entity;
	removeBackpack _entity;
		
	_entity addHeadgear _headgear;	
	_entity addGoggles _goggles; 
	_entity addUniform _uniform;
	_entity addVest _vest;
    if(_backpack != "") then {
        _entity addBackpack _backpack;	
    };
    	
    {
        if(_x != "") then {
            [_entity, _x, 1] call BIS_fnc_addWeapon;	//add weapon last, or mag won't be added	
        };
    } forEach [_primary_weapon, _secondary_weapon, _handgun];    
	
	if(_range_finder) then {
		_entity removeWeapon "Binocular";
		_entity addWeapon "Rangefinder";
	};
	
	if(_binocular) then {
		_entity removeWeapon "Rangefinder";
		_entity addWeapon "Binocular";
	};	
		
	if(_nvg) then {
		_entity assignItem "NVGoggles";
	} else {
		switch(side _entity) do {
			case(west): {
				_entity unassignItem "NVGoggles";	
				_entity removeItem "NVGoggles";			
			};
			case(east): {
				_entity unassignItem "NVGoggles_OPFOR";	
				_entity removeItem "NVGoggles_OPFOR";				
			};
			case(independent): {
				_entity unassignItem "NVGoggles_INDEP";	
				_entity removeItem "NVGoggles_INDEP";					
			};
			default {
				diag_log "SVIS: loadInventory, faction not detected";
			}
		
		};
	};
		
	if(_map) then {
		_entity assignItem "ItemMap";	
	} else {
		_entity unassignItem "ItemMap";	
	};

	if(_compass) then {
		_entity assignItem "ItemCompass";	
	} else {
		_entity unassignItem "ItemCompass";	
	};	
	
	if(_watch) then {
		_entity assignItem "ItemWatch";	
	} else {
		_entity unassignItem "ItemWatch";	
	};	
	
	if(_radio) then {
		_entity assignItem "ItemRadio";	
	} else {
		_entity unassignItem "ItemRadio";	
	};		

	if(_gps) then {
		_entity assignItem "ItemGPS";	
	} else {
		_entity unassignItem "ItemGPS";	
	};			
	
	{
		_entity removePrimaryWeaponItem _x;
	} forEach (primaryWeaponItems _entity);
	
	{
		_entity addPrimaryWeaponItem _x;
	} forEach _primary_items;
	
	{
		_entity removeItem _x;			//TODO this is not working
	} forEach (secondaryWeaponItems _entity);
	
	{
		_entity addSecondaryWeaponItem _x;
	} forEach _secondary_items;	
	
	[_entity, _uniform_items] call addToInventory;
	[_entity, _vest_items] call addToInventory;
	[_entity, _backpack_items] call addToInventory;

	_entity selectWeapon _primary_weapon;
};

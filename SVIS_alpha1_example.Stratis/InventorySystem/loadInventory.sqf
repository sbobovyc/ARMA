/**
  * @file loadInventory.sqf
  * @author sbobovyc
  * @details
  * Uses global array SVIS_INVENTORY
  */
  
addToInventory = 
{
	_items = _this select 0;
	{
		diag_log format["Adding: %1", _x];
		if(isClass(configFile/"CfgMagazines"/_x)) then
		{
			player addMagazine _x;
		} 
		else 
		{
			player addItem _x;
		};	
	} forEach _items;		
};

waitUntil {!(isNull player)};
waitUntil {player==player};

//diag_log "loading inventory";

_headgear = 	SVIS_INVENTORY select 0;
_goggles =	 	SVIS_INVENTORY select 1;
_uniform = 		SVIS_INVENTORY select 2;
_uniform_items = 	SVIS_INVENTORY select 3;
_vest = 		SVIS_INVENTORY select 4;
_vest_items = 	SVIS_INVENTORY select 5;
_backpack = 	SVIS_INVENTORY select 6;
_backpack_items = SVIS_INVENTORY select 7;
_primary_weapon = SVIS_INVENTORY select 8;
_secondary_weapon = SVIS_INVENTORY select 9;
_handgun = 		SVIS_INVENTORY select 10;
_primary_items = 	SVIS_INVENTORY select 11;
_secondary_items =  SVIS_INVENTORY select 12;

//diag_log SVIS_INVENTORY;
diag_log "Loading inventory";

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
	player addGoggles _goggles; //TODO possibly causes "Bad vehicle type"	
	player addUniform _uniform;
	player addVest _vest;
	player addBackpack _backpack;	
	[player, _primary_weapon, 1] call BIS_fnc_addWeapon;	//add weapon last, or mage won't be added
	[player, _secondary_weapon, 1] call BIS_fnc_addWeapon;	//add weapon last, or mage won't be added
	[player, _handgun, 1] call BIS_fnc_addWeapon;	//add weapon last, or mage won't be added	
	player addWeapon "Binocular"; //TODO check if this was saved

	{
		player removeItemFromPrimaryWeapon 	_x;
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
	
	[_uniform_items] call addToInventory;
	[_vest_items] call addToInventory;
	[_backpack_items] call addToInventory;

	player selectWeapon _primary_weapon;
};
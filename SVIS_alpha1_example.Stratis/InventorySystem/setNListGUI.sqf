/**
  Uses global variable SVIS_SELECTED_BUTTON.
*/

#include "InventoryDialogDefs.hpp"  

#define ENABLE_PLUS_MINUS ctrlEnable [ADD_ITEM_BUTTON, true]; ctrlEnable [REMOVE_ITEM_BUTTON, true];
#define ENABLE_PLUS ctrlEnable [ADD_ITEM_BUTTON, true];
#define ENABLE_MINUS ctrlEnable [REMOVE_ITEM_BUTTON, true];
#define DISABLE_PLUS_MINUS ctrlEnable [ADD_ITEM_BUTTON, false]; ctrlEnable [REMOVE_ITEM_BUTTON, false];

getItemMap = compile preprocessFileLineNumbers "InventorySystem\getItemMap.sqf";

_type = _this select 0;
_rtn = nil;
_class = nil;
SVIS_SELECTED_BUTTON = "";

// clear out listbox
lnbClear MULTIPURPOSE_NLISTBOX;

// enable + and - buttons
//ctrlEnable [ADD_ITEM_BUTTON, true];
//ctrlEnable [REMOVE_ITEM_BUTTON, true];

while {SVIS_EQP_MUTEX} do {}; // spin lock on mutex to wait for gear to be switched before updating the listbox
switch(_type) do {
	case "Headgear":
	{
		diag_log format["SVIS: setNListGUI, Headgear"];	
		lnbClear MULTIPURPOSE_NLISTBOX;		
		//TODO, maybe put NVG removal here
		lnbAddRow[MULTIPURPOSE_NLISTBOX,["", "Nothing to be done for headgear", ""]];
		DISABLE_PLUS_MINUS;
		_rtn = [];
	};
	case "Uniform": 
	{
		diag_log format["SVIS: setNListGUI, Uniform"];		
		if(uniform player != "") then {
			_rtn = [UniformItems player] call getItemMap;
			ENABLE_PLUS_MINUS;
		} else {
			DISABLE_PLUS_MINUS;
			_rtn = [];
		};		
		if( count (_rtn select 0) == 0) then { // if there is nothing in the item map, disable add and sub buttons
			DISABLE_PLUS_MINUS;
		} else {
			ENABLE_PLUS_MINUS;
		};
		SVIS_SELECTED_BUTTON = "Uniform";
	};
	case "Vest": 
	{
		diag_log format["SVIS: setNListGUI, Vest"];	
		if(vest player != "") then {
			_rtn = [VestItems player] call getItemMap;
			ENABLE_PLUS_MINUS;
		} else {
			DISABLE_PLUS_MINUS;
			_rtn = [];
		};			
		if( count (_rtn select 0) == 0) then { // if there is nothing in the item map, disable add and sub buttons
			DISABLE_PLUS_MINUS;
		} else {
			ENABLE_PLUS_MINUS;
		};
		SVIS_SELECTED_BUTTON = "Vest";
	};	
	case "Backpack": 
	{
		diag_log format["SVIS: setNListGUI, Backpack"];		
		if(backpack player != "") then {
			_rtn = [BackpackItems player] call getItemMap;
			ENABLE_PLUS_MINUS;
		} else {
			ctrlEnable [ADD_ITEM_BUTTON, false];	// disable add button
			ctrlEnable [REMOVE_ITEM_BUTTON, false];	// disable sub button
			_rtn = [];
		};
		if( count (_rtn select 0) == 0) then { // if there is nothing in the item map, disable add and sub buttons
			ctrlEnable [ADD_ITEM_BUTTON, false];	// disable add button
			ctrlEnable [REMOVE_ITEM_BUTTON, false];	// disable sub button		
		};
		SVIS_SELECTED_BUTTON = "Backpack";
	};	
	case "Weapon": 
	{
		ctrlEnable [ADD_ITEM_BUTTON, false];	// disable add button 
		diag_log format["SVIS: setNListGUI, Weapon"];	
		if(primaryWeapon player != "") then {
			_rtn = primaryWeaponItems player;			
		} else {
			ctrlEnable [REMOVE_ITEM_BUTTON, false];	// disable sub button
			_rtn = [];
		};			
		if(_rtn select 0 == "" && _rtn select 1 == "" && _rtn select 2 == "") then {
			ctrlEnable [REMOVE_ITEM_BUTTON, false];	// disable sub button		
		} else {
			ENABLE_MINUS;
		};
		SVIS_SELECTED_BUTTON = "Weapon";
	};		
	case "SecondaryWeapon":	
	{
		diag_log format["SVIS: setNListGUI, SecondaryWeapon"];	
		lnbClear MULTIPURPOSE_NLISTBOX;		
		lnbAddRow[MULTIPURPOSE_NLISTBOX,["", "Nothing to be done for secondary weapon", ""]];
		ctrlEnable [ADD_ITEM_BUTTON, false];	// disable add button
		ctrlEnable [REMOVE_ITEM_BUTTON, false];	// disable sub button	
		_rtn = [];
	};
	default
	{
		diag_log "SVIS: Error in setListGUI";	
		hint "SVIS: Error in setListGUI";	
	};
};

if(count _rtn != 0 && {(typeName (_rtn select 1)) == "ARRAY"} ) then {
	_item_list = _rtn select 0;
	_item_count = _rtn select 1;
	for "_i" from 0 to (count _item_list)-1 do {
		_str = nil;		
		_class_array = ["cfgWeapons", "cfgMagazines", "cfgLights", "cfgGlasses"];
		{
			scopeName "classSearch";
			_class = (configFile >> _x >> (_item_list select _i));
			if(isClass _class) then {breakOut "classSearch"};			
		} forEach _class_array;	
		if(isClass _class) then {		
			_str = format["%1 : %2", getText(_class >> "displayName"), _item_count select _i];
			_count_str = format["%1", _item_count select _i];	
			lnbAddRow[MULTIPURPOSE_NLISTBOX,["", getText(_class >> "displayName"), _count_str]];
			lnbSetPicture[MULTIPURPOSE_NLISTBOX, [_i, 0], getText(_class >> "picture")];
		} else {
			_str = format["%1 : %2", _item_list select _i, _item_count select _i];
			lnbAddRow[MULTIPURPOSE_NLISTBOX,["", _item_list select _i, _item_count select _i]];
			lnbSetPicture[MULTIPURPOSE_NLISTBOX, [_i, 0], getText(_class >> "picture")];
		};		
	};
} else {
	_item_list = [];
	_class = nil;
	{
		if (_x != "") then {
			_item_list = _item_list + [_x];
		};
	} forEach _rtn;
	
	for "_i" from 0 to (count _item_list)-1 do {
		_class_array = ["cfgWeapons", "cfgMagazines", "cfgLights", "cfgGlasses"];
		{
			scopeName "classSearch";
			_class = (configFile >> _x >> (_item_list select _i));
			if(isClass _class) then {breakOut "classSearch"};			
		} forEach _class_array;				
		lnbAddRow[MULTIPURPOSE_NLISTBOX,["", getText(_class >> "displayName"), ""]];
		lnbSetPicture[MULTIPURPOSE_NLISTBOX, [_i, 0], getText(_class >> "picture")];
	};
};

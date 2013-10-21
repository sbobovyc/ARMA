/**
  1. Set camera
  2. Fill list
  Uses global variable SVIS_SELECTED_BUTTON.
*/

#include "InventoryDialogDefs.hpp"  

getItemMap = compile preprocessFileLineNumbers "InventorySystem\getItemMap.sqf";

_type = _this select 0;
_rtn = nil;
SVIS_SELECTED_BUTTON = "";

// clear out listbox
lbClear MULTIPURPOSE_LISTBOX;

// enable + and - buttons
ctrlEnable [ADD_ITEM_BUTTON, true];
ctrlEnable [REMOVE_ITEM_BUTTON, true];

while {SVIS_EQP_MUTEX} do {}; // spin lock on mutex to wait for gear to be switched before updating the listbox
switch(_type) do
{
	case "Headgear":
	{

		
	};
	case "Uniform": 
	{
		diag_log format["SVIS: setListGUI, Uniform"];
		_rtn = [UniformItems player] call getItemMap;
		SVIS_SELECTED_BUTTON = "Uniform";
	};
	case "Vest": 
	{
		diag_log format["SVIS: setListGUI, Vest"];	
		_rtn = [VestItems player] call getItemMap;
		SVIS_SELECTED_BUTTON = "Vest";
	};	
	case "Backpack": 
	{
		diag_log format["SVIS: setListGUI, Backpack"];		
		_rtn = [BackpackItems player] call getItemMap;
		SVIS_SELECTED_BUTTON = "Backpack";
	};	
	case "Weapon": 
	{
		_rtn = primaryWeaponItems player;
	};		
	case "SecondaryWeapon":	
	{

	};
	default
	{
		diag_log "SVIS: Error in setListGUI";	
		hint "SVIS: Error in setListGUI";	
	};
};

if((typeName (_rtn select 1)) == "ARRAY") then {
	_item_list = _rtn select 0;
	_item_count = _rtn select 1;
	for "_i" from 0 to (count _item_list)-1 do
	{
		_str = nil;
		_class = [(_item_list select _i)] call BIS_fnc_classMagazine;
		if(isClass _class) then {		
			_str = format["%1 : %2", getText(_class >> "displayName"), _item_count select _i];
		} else {
			_str = format["%1 : %2", _item_list select _i, _item_count select _i];
		};
		lbAdd[MULTIPURPOSE_LISTBOX,_str];
	};
} else {
	_item_list = _rtn;
	for "_i" from 0 to (count _item_list)-1 do
	{
		_str = format["%1", _item_list select _i];
		lbAdd[MULTIPURPOSE_LISTBOX,_str];
	};	
};
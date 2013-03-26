/*
 * @file switchEquipment.sqf
 * @author sbobovyc
 * @param type "Headgear", "Uniform", "Vest", "Backpack", "Weapon"
 * @param index is an int, point to an item array, comes from a gui element like a slider
*/

#include "InventoryDialogDefs.hpp"
#include "InventoryItems.hpp"

#define LOCK_EQP SVIS_EQP_MUTEX = true
#define UNLOCK_EQP SVIS_EQP_MUTEX = false

_type = _this select 0;
_index = _this select 1;

getItemArray = compile preprocessFileLineNumbers "InventorySystem\getItemArray.sqf";
addToInventory = compile preprocessFileLineNumbers "InventorySystem\addToIventory.sqf";
setGUI = compile preprocessFileLineNumbers "InventorySystem\setGUI.sqf";

if(!SVIS_EQP_MUTEX) then {
LOCK_EQP;
switch(_type) do
{
	case "Headgear":
	{
		_headgear_array = SVIS_HEADGEAR_ARRAY;
		removeHeadgear player;	
		_selected_headgear = _headgear_array select _index; 
		player addHeadgear (_selected_headgear);	
		// update gui
		["SetHeadgear"] call setGUI;

		diag_log format["SVIS: switchEquipment, headgear %1", _selected_headgear];
		
	};
	case "Uniform": 
	{
		_uniform_array = SVIS_UNIFORM_ARRAY;
		// save inventory
		saveInventory = compile preprocessFileLineNumbers "InventorySystem\saveInventory.sqf";
		nul = [] call saveInventory;
		removeUniform player;
		_selected_uniform = _uniform_array select _index; 
		player addUniform (_selected_uniform);
		[SVIS_INVENTORY select 3] call addToInventory;
		// update gui
		["SetUniform"] call setGUI;

		diag_log format["SVIS: switchEquipment, uniform %1", _selected_uniform];
	};
	case "Vest": 
	{
		_vest_array = SVIS_VEST_ARRAY;
		// save inventory
		saveInventory = compile preprocessFileLineNumbers "InventorySystem\saveInventory.sqf";
		nul = [] call saveInventory;
		removeVest player;
		_selected_vest = _vest_array select _index; 
		player addVest (_selected_vest);
		[SVIS_INVENTORY select 5] call addToInventory;
		// update gui
		["SetVest"] call setGUI;

		diag_log format["SVIS: switchEquipment, vest %1", _selected_vest];
	};	
	case "Backpack": 
	{
		_backpack_array = SVIS_BACKPACK_ARRAY;
		// save inventory
		saveInventory = compile preprocessFileLineNumbers "InventorySystem\saveInventory.sqf";
		nul = [] call saveInventory;
		removeBackpack player;	//BUG player craps out backpacks if you switch too quickly
		_selected_backpack = _backpack_array select _index; 
		player addBackpack (_selected_backpack);
		[SVIS_INVENTORY select 7] call addToInventory;
		// update gui
		["SetBackpack"] call setGUI;

		diag_log format["SVIS: switchEquipment, backpack %1", _selected_backpack];
	};	
	case "Weapon": 
	{
		_weapon_array = SVIS_WEAPON_ARRAY;
		//TODO check if player has binoculars, and if not don't add them
		//BUG some magazines still get left behind
		_mags = getArray(configFile >> "CfgWeapons" >> primaryWeapon player >> "magazines");
		_wpn_cnt = [player, primaryWeapon player] call BIS_fnc_invRemove;
		diag_log format["SVIS: switchEquipment, removed weapon count %1", _wpn_cnt];

		// remove weapon magazines so that inventory does not get cluttered
		{
			_cnt = [player, _x, 100] call BIS_fnc_invRemove;
			diag_log format["SVIS: switchEquipment, removed mag %1, count %2", _x, _cnt];
		} forEach _mags;

		// add selected weapon and some mags
		_selected_weapon = _weapon_array select _index; 
		[player, _selected_weapon, 6] call BIS_fnc_addWeapon;
		// make the player select the primary weapon, as of alpha pistole gets selected
		player selectWeapon _selected_weapon;
		// switch to idle rifle down animation in case we didn't have a rifle before
		if(_wpn_cnt == 0) then {
			player switchMove "AidlPercMstpSlowWrflDnon_G01";
		};
		// update gui
		["SetPrimaryWeapon"] call setGUI;
		 
		diag_log format["SVIS: switchEquipment, weapon %1", _selected_weapon];
	};			
	default
	{
		diag_log "SVIS: Error in equipment switch";	
		hint "SVIS: Error in equipment switch";	
	};
};
UNLOCK_EQP;
};	

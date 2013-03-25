/*
 * @file switchEquipment.sqf
 * @author sbobovyc
 * @param type "Headgear", "Uniform", "Vest", "Backpack", "Weapon"
 * @param index is an int, point to an item array, comes from a gui element like a slider
*/

#include "InventoryDialogDefs.hpp"
#include "InventoryItems.hpp"


_type = _this select 0;
_index = _this select 1;

getItemArray = compile preprocessFileLineNumbers "InventorySystem\getItemArray.sqf";

switch(_type) do
{
	case "Headgear":
	{
		_headgear_array = IIS_HEADGEAR_ARRAY;
		removeHeadgear player;	
		_selected_headgear = _headgear_array select _index; 
		player addHeadgear (_selected_headgear);	
		_headgear_name = getText(configFile >> "CfgWeapons" >> _selected_headgear >> "displayName");		
		
		// set button text
		ctrlSetText[HEADGEAR_BUTTON, _headgear_name];				
		
	};
	case "Uniform": 
	{
		_uniform_array = IIS_UNIFORM_ARRAY;
		// save inventory
		saveInventory = compile preprocessFileLineNumbers "InventorySystem\saveInventory.sqf";
		nul = [] call saveInventory;
		removeUniform player;
		_selected_uniform = _uniform_array select _index; 
		player addUniform (_selected_uniform);
		addToInventory = compile preprocessFileLineNumbers "InventorySystem\addToIventory.sqf";
		[SVIS_INVENTORY select 3] call addToInventory;
		
		_uniform_name = getText(configFile >> "CfgWeapons" >> _selected_uniform >> "displayName");		
		diag_log format["SVIS: switchEquipment, uniform %1", _selected_uniform];
		
		// set button text
		ctrlSetText[UNIFORM_BUTTON, _uniform_name];
	};
	case "Vest": 
	{
		_vest_array = IIS_VEST_ARRAY;
		// save inventory
		saveInventory = compile preprocessFileLineNumbers "InventorySystem\saveInventory.sqf";
		nul = [] call saveInventory;
		removeVest player;
		_selected_vest = _vest_array select _index; 
		player addVest (_selected_vest);
		addToInventory = compile preprocessFileLineNumbers "InventorySystem\addToIventory.sqf";
		[SVIS_INVENTORY select 5] call addToInventory;

		_vest_name = getText(configFile >> "CfgWeapons" >> _selected_vest >> "displayName");		
		diag_log format["SVIS: switchEquipment, vest %1", _selected_vest];
		
		// set button text
		ctrlSetText[VEST_BUTTON, _vest_name];
	};	
	case "Backpack": 
	{
		_backpack_array = IIS_BACKPACK_ARRAY;
		// save inventory
		saveInventory = compile preprocessFileLineNumbers "InventorySystem\saveInventory.sqf";
		nul = [] call saveInventory;
		removeBackpack player;	//BUG player craps out backpacks if you switch too quickly
		_selected_backpack = _backpack_array select _index; 
		player addBackpack (_selected_backpack);
		addToInventory = compile preprocessFileLineNumbers "InventorySystem\addToIventory.sqf";
		[SVIS_INVENTORY select 7] call addToInventory;
		
		_backpack_name = getText(configFile >> "CfgVehicles" >> _selected_backpack >> "displayName");		
		
		// set button text
		ctrlSetText[BACKPACK_BUTTON, _backpack_name];
	};	
	case "Weapon": 
	{
		_weapon_array = IIS_WEAPON_ARRAY;
		//TODO check if player has binoculars, and if not don't add them
		//BUG some magazines still get left behind
		_mags = getArray(configFile >> "CfgWeapons" >> primaryWeapon player >> "magazines");
		_cnt = [player, primaryWeapon player] call BIS_fnc_invRemove;
		diag_log format["SVIS: switchEquipment, removed weapon count %1", _cnt];

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
		 
		_weapon_name = getText(configFile >> "CfgWeapons" >> _selected_weapon >> "displayName");		
		diag_log format["SVIS: switchEquipment, weapon %1", _selected_weapon];
		
		// set button text
		ctrlSetText[WEAPON_BUTTON, _weapon_name];
	};			
	default
	{
		diag_log "SVIS: Error in equipment switch";	
		hint "SVIS: Error in equipment switch";	
	};
};

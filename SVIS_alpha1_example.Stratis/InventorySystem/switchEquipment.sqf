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
		//diag_log _headgear_name;
		
		// set button text
		ctrlSetText[HEADGEAR_BUTTON, _headgear_name];				
		
	};
	case "Uniform": 
	{
		_uniform_array = IIS_UNIFORM_ARRAY;
		//TODO save whatever gear was in previous uniform and put it in the new one
		removeUniform player;
		_selected_uniform = _uniform_array select _index; 
		player addUniform (_selected_uniform);
		
		_uniform_name = getText(configFile >> "CfgWeapons" >> _selected_uniform >> "displayName");		
		//diag_log _uniform_name;
		
		// set button text
		ctrlSetText[UNIFORM_BUTTON, _uniform_name];
	};
	case "Vest": 
	{
		_vest_array = IIS_VEST_ARRAY;
		//TODO save whatever gear was in previous uniform and put it in the new one
		//TODO current main weapon ammo gets taken out of vest on vest switch
		removeVest player;
		_selected_vest = _vest_array select _index; 
		player addVest (_selected_vest);
		
		_vest_name = getText(configFile >> "CfgWeapons" >> _selected_vest >> "displayName");		
		//diag_log _vest_name;
		
		// set button text
		ctrlSetText[VEST_BUTTON, _vest_name];
	};	
	case "Backpack": 
	{
		_backpack_array = IIS_BACKPACK_ARRAY;
		//TODO save whatever gear was in previous uniform and put it in the new one
		removeBackpack player;
		_selected_backpack = _backpack_array select _index; 
		player addBackpack (_selected_backpack);
		
		_backpack_name = getText(configFile >> "CfgVehicles" >> _selected_backpack >> "displayName");		
		//diag_log _backpack_name;
		
		// set button text
		ctrlSetText[BACKPACK_BUTTON, _backpack_name];
	};	
	case "Weapon": 
	{
		_weapon_array = IIS_WEAPON_ARRAY;
		//TODO save whatever gear was in previous uniform and put it in the new one
		//TODO check if player has binoculars, and if not don't add them
		removeAllWeapons player;
		_selected_weapon = _weapon_array select _index; 
		[player, _selected_weapon, 6] call BIS_fnc_addWeapon;
		player addWeapon "Binocular";
		 
		_weapon_name = getText(configFile >> "CfgWeapons" >> _selected_weapon >> "displayName");		
		//diag_log _weapon_name;
		
		// set button text
		ctrlSetText[WEAPON_BUTTON, _weapon_name];
	};			
	default
	{
		diag_log "Error in equipment switch";	
		hint "Error in equipment switch";	
	};
};

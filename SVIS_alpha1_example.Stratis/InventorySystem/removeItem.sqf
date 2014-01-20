/**
 * @file removeItem.sqf
 * @author sbobovyc
 * @details
 * This should be called when an item like the uniform is removed.
 */
 
 #include "InventoryDialogDefs.hpp"
 setGUI = compile preprocessFileLineNumbers "InventorySystem\setGUI.sqf";
 setNListGUI = compile preprocessFileLineNumbers "InventorySystem\setNListGUI.sqf";
 
 _gui_action = _this select 0;
 
 diag_log _gui_action;
 switch(_gui_action) do
{
	case "Headgear":
	{
		removeHeadgear player; 
		[0,"SetHeadgear"] call setGUI;
		["Headgear"] call setNListGUI;
	};
	case "Uniform":
	{
		removeUniform player; 
		[0,"SetUniform"] call setGUI;
		["Uniform"] call setNListGUI;
	};
	case "Vest":
	{
		removeVest player; 
		[0,"SetVest"] call setGUI;
		["Vest"] call setNListGUI;
	};	
	case "Backpack":
	{
		removeBackpack player; 
		[0,"SetBackpack"] call setGUI;
		["Backpack"] call setNListGUI;
	};	
	case "Weapon":
	{
		//TODO this should be made into a function and used here and switchEquipment
		_mags = getArray(configFile >> "CfgWeapons" >> primaryWeapon player >> "magazines");
		_wpn_cnt = [player, primaryWeapon player] call BIS_fnc_invRemove;
		diag_log format["SVIS: removeItem, removed weapon count %1", _wpn_cnt];

		// remove weapon magazines so that inventory does not get cluttered
		{
			_cnt = [player, _x, 100] call BIS_fnc_invRemove;
			diag_log format["SVIS: removeItem, removed mag %1, count %2", _x, _cnt];
		} forEach _mags;

		[0,"SetPrimaryWeapon"] call setGUI;
		["Weapon"] call setNListGUI;
	};		
	case "SecondaryWeapon":
	{
		//TODO this should be made into a function and used here and switchEquipment
		_mags = getArray(configFile >> "CfgWeapons" >> secondaryWeapon player >> "magazines");
		_wpn_cnt = [player, secondaryWeapon player] call BIS_fnc_invRemove;
		diag_log format["SVIS: removeItem, removed weapon count %1", _wpn_cnt];

		// remove weapon magazines so that inventory does not get cluttered
		{
			_cnt = [player, _x, 100] call BIS_fnc_invRemove;
			diag_log format["SVIS: removeItem, removed mag %1, count %2", _x, _cnt];
		} forEach _mags;

		[0,"SetSecondaryWeapon"] call setGUI;
		["SecondaryWeapon"] call setNListGUI;
	};	
	default
	{
		diag_log "SVIS: Error in removeItem";	
		hint "SVIS: Error in removeItem";	
	};
};

((findDisplay -1) displayCtrl UNIFORM_LOAD) progressSetPosition loadUniform player;
((findDisplay -1) displayCtrl VEST_LOAD) progressSetPosition loadVest player;
((findDisplay -1) displayCtrl BACKPACK_LOAD) progressSetPosition loadBackpack player;
((findDisplay -1) displayCtrl TOTAL_LOAD) progressSetPosition load player;
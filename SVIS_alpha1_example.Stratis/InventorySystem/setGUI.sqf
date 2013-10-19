/**
 * @file setGUI.sqf
 * @author sbobovyc
 * @details
 * Each slider and button text setting is separated for performance.
 * The display has to be passed in so that progress bars can be updated dynamically.
 */
#include "InventoryItems.hpp"  
#include "InventoryDialogDefs.hpp"

#define INIT		"Init"
#define SET_SH		"SetHeadgear"
#define SET_SU		"SetUniform"
#define SET_SV		"SetVest"
#define SET_SB		"SetBackpack"
#define SET_SPW		"SetPrimaryWeapon"
#define SET_SSW		"SetSecondaryWeapon"

_display = 0;
_gui_action = "Init";

if(count _this > 0) then
{
	_display = _this select 0;
	_gui_action = _this select 1;
};

_set_slider = false;
if(count _this > 2) then 
{
	_set_slider = _this select 2;
};

// set the total load progress bar if display is a valid display object
if(typeName _display == "DISPLAY")  then
{
	(_display displayCtrl TOTAL_LOAD) progressSetPosition load player;
};

switch(_gui_action) do
{
	case INIT:
	{
		// set slider ranges
		sliderSetRange [HEADGEAR_SLIDER, 0, (count SVIS_HEADGEAR_ARRAY) - 1]; 
		sliderSetSpeed [HEADGEAR_SLIDER, 1.0, 1.0];
		sliderSetPosition [HEADGEAR_SLIDER, 0];

		sliderSetRange [UNIFORM_SLIDER, 0, (count SVIS_UNIFORM_ARRAY) - 1]; 
		sliderSetSpeed [UNIFORM_SLIDER, 1.0, 1.0];
		sliderSetPosition [UNIFORM_SLIDER, 0];

		sliderSetRange [VEST_SLIDER, 0, (count SVIS_VEST_ARRAY) - 1]; 
		sliderSetSpeed [VEST_SLIDER, 1.0, 1.0];
		sliderSetPosition [VEST_SLIDER, 0];	

		sliderSetRange [BACKPACK_SLIDER, 0, (count SVIS_BACKPACK_ARRAY) - 1]; 
		sliderSetSpeed [BACKPACK_SLIDER, 1.0, 1.0];
		sliderSetPosition [BACKPACK_SLIDER, 0];	

		sliderSetRange [WEAPON_SLIDER, 0, (count SVIS_WEAPON_ARRAY) - 1]; 
		sliderSetSpeed [WEAPON_SLIDER, 1.0, 1.0];
	};
	case SET_SH:
	{
		_headgear = headgear player;
		if(_headgear != "") then {
			_pos = SVIS_HEADGEAR_ARRAY find _headgear;
			if(_pos != -1 && _set_slider) then {
				sliderSetPosition [HEADGEAR_SLIDER, _pos];
			};
			_headgear_name = getText(configFile >> "CfgWeapons" >> _headgear >> "displayName");
			ctrlSetText[HEADGEAR_BUTTON, _headgear_name];
		};
	};
	case SET_SU:
	{
		_uniform = uniform player;
		if(_uniform != "") then {
			_pos = SVIS_UNIFORM_ARRAY find _uniform;
			if(_pos != -1 && _set_slider) then {
				sliderSetPosition [UNIFORM_SLIDER, _pos];
			};
			_uniform_name = getText(configFile >> "CfgWeapons" >> _uniform >> "displayName");
			ctrlSetText[UNIFORM_BUTTON, _uniform_name];
		};
	};
	case SET_SV:
	{
		_vest = vest player;
		if(_vest != "") then {
			_pos = SVIS_VEST_ARRAY find _vest;
			if(_pos != -1 && _set_slider) then {
				sliderSetPosition[VEST_SLIDER, _pos];
			};
			_vest_name = getText(configFile >> "CfgWeapons" >> _vest >> "displayName");
			ctrlSetText[VEST_BUTTON, _vest_name];
		};
	};
	case SET_SB:
	{
		_backpack = backpack player;
		if(_backpack != "") then {
			_pos = SVIS_BACKPACK_ARRAY find _backpack;
			if(_pos != -1 && _set_slider) then {
				sliderSetPosition[BACKPACK_SLIDER, _pos];
			};
			_backpack_name = getText(configFile >> "CfgVehicles" >> _backpack >> "displayName");
			ctrlSetText[BACKPACK_BUTTON, _backpack_name];
		};
	};
	case SET_SPW:
	{
		_primary_weapon = primaryWeapon player;
		if(_primary_weapon != "") then {
			_pos = SVIS_WEAPON_ARRAY find _primary_weapon;
			if(_pos != -1 && _set_slider) then {
				sliderSetPosition [WEAPON_SLIDER, _pos];
			};	
			_weapon_name = getText(configFile >> "CfgWeapons" >> _primary_weapon >> "displayName");
			ctrlSetText[WEAPON_BUTTON, _weapon_name];
		};
	};
	case SET_SSW:
	{
		_secondary_weapon = secondaryWeapon player;
		if(_secondary_weapon != "") then {
			_pos = SVIS_SECONDARY_WEAPON_ARRAY find _secondary_weapon;
			if(_pos != -1 && _set_slider) then {
				sliderSetPosition [SECONDARY_WEAPON_SLIDER, _pos];
			};	
			_weapon_name = getText(configFile >> "CfgWeapons" >> _secondary_weapon >> "displayName");
			ctrlSetText[SECONDARY_WEAPON_BUTTON, _weapon_name];
		};
	};
};

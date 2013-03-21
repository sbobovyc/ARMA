/**
 * @file getBackpackArray.sqf
 * @author TAW_Tonic
 * @author sbobovyc
 * 
 */
#include "blacklist.hpp"

_cfgweapons = configFile >> "CfgVehicles";
_item_array = [];        
_blacklist = BACKPACK_BLACKLIST;

// check whether BACKPACK_BLACKLIST was actually defined
if(isNil {_blacklist}) then {
	nul = ["Mission maker, you failed to supply a backpack blacklist."] call BIS_fnc_errorMSG;
};

for "_i" from 0 to (count _cfgWeapons)-1 do
{
//diag_log str(_i);
_cur_wep = _cfgweapons select _i;

	if(isClass _cur_wep) then
	{
		_classname = configName _cur_wep;
		_wep_type = getText(_cur_wep >> "vehicleClass");
		_scope = getNumber(_cur_wep >> "scope");
		_picture = getText(_cur_wep >> "picture");

		if(_scope >= 2 && _wep_type == "Backpacks" && _picture != "" && !(_classname in _item_array)) then
		{
			if !(_classname in _blacklist) then {
				//diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
			_item_array set[count _item_array, _classname];
			};
		};
	};
};
//diag_log format["Backpack Count %1", count _item_array];
_item_array


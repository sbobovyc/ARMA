// https://forums.bistudio.com/topic/181264-sector-module-scripting/

_ownerSide = _this select 0;
_module = _this select 1;
_position = position _module;

diag_log format["LLLLLLL %1", _ownerSide];
diag_log format["LLLLLLL %1", _module];
diag_log format["LLLLLLL %1", _position];

[_logic,"BIS_fnc_moduleSector_sector"] call bis_fnc_objectvar;
_name = _logic getvariable ["Name",""];
diag_log format["LLLLLLL %1", _name];

if(_ownerSide == west) then { 
    _marker_name = _name + "_spawn";
    _marker = createMarker [_marker_name, _position];
    [west, _marker_name] call BIS_fnc_addRespawnPosition;  
    _position call createVirtualAmmobox;     
}

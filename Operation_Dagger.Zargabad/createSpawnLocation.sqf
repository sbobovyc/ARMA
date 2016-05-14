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

_marker_name = _name + "_spawn";
_box_name = _name + "_box";
if(_ownerSide == west) then {     
    // if marker already exists, don't do anything
    //TODO use position instead of checking for existance
    if(isNil _marker_name) then {
        _marker = createMarker [_marker_name, _position];
        [west, _marker_name] call BIS_fnc_addRespawnPosition;  
        if(isNil _box_name) then {
            [_position, _box_name] call createVirtualAmmobox;
        };
    }
};
if(_ownerSide == east) then {
    deleteMarker _marker_name;
};

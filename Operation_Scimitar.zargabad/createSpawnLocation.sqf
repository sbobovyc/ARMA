#include "opconstants.hpp"
// https://forums.bistudio.com/topic/181264-sector-module-scripting/

_ownerSide = _this select 0;
_module = _this select 1;
_position = position _module;

diag_log format[LOG_STR + "%1", _ownerSide];
diag_log format[LOG_STR + "%1", _module];
diag_log format[LOG_STR + "%1", _position];

[_logic,"BIS_fnc_moduleSector_sector"] call bis_fnc_objectvar;
_name = _logic getvariable ["Name",""];
diag_log format[LOG_STR + "%1", _name];

_marker_name = _name + "_spawn";
_box_name = _name + "_box";
_create_ammobox = true;
_create_flag = false; //TODO

deleteMarker _marker_name;
_marker = createMarker [_marker_name, _position];
[_ownerSide, _marker_name] call BIS_fnc_addRespawnPosition;
if(_create_ammobox) then {

    if(not isNil "AMMO_BOX_ARRAY") then {
    {
            _distance = ((getPos _x) distance2D _position);
            diag_log format[LOG_STR + "Distance to box %1 is %2", _x, _distance];
            if(_distance < 10) then {
                diag_log format[LOG_STR + "Deleting box near %1", _marker_name];
                AMMO_BOX_ARRAY = AMMO_BOX_ARRAY - [_x];
                deleteVehicle _x;
            };
        } forEach AMMO_BOX_ARRAY;
    };

    if(isNil _box_name) then {
        // to make sure ammobox and spawn position are not exactly at the same location, create ammo box 5 meters south of spawn
        _ammobox_position = _module getPos [5, 180];
        diag_log format[LOG_STR + "Creating ammo box at %1", _ammobox_position];
        [_ammobox_position, _box_name] call createVirtualAmmobox;
    };
};

/*
if(_ownerSide == west) then {
    // if marker already exists, don't do anything
    //TODO use position instead of checking for existence
    if(isNil _marker_name) then {
        _marker = createMarker [_marker_name, _position];
        [west, _marker_name] call BIS_fnc_addRespawnPosition;
        if(_create_ammobox) then {
            if(isNil _box_name) then {
                // to make sure ammobox and spawn position are not exactly at the same location, create ammo box 5 meters south of spawn
                _ammobox_position = _module getPos [5, 180];
                diag_log format[LOG_STR + "Creating ammo box at %1", _ammobox_position];
                [_ammobox_position, _box_name] call createVirtualAmmobox;
            };
        };
    }
};
if(_ownerSide == east) then {
    deleteMarker _marker_name;
    if(_create_ammobox) then {
        if(not isNil "AMMO_BOX_ARRAY") then {
        {
                _distance = ((getPos _x) distance2D _position);
                diag_log format[LOG_STR + "Distance to box %1 is %2", _x, _distance];
                if(_distance < 10) then {
                    diag_log format[LOG_STR + "Deleting box near %1", _marker_name];
                    AMMO_BOX_ARRAY = AMMO_BOX_ARRAY - [_x];
                    deleteVehicle _x;
                };
            } forEach AMMO_BOX_ARRAY;
        };
    };
};
*/

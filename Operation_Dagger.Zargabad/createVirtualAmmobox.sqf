#include "opdagger.hpp"
// https://forums.bistudio.com/topic/188425-how-to-copy-virtual-inventory-from-a-vehicle-to-another/

if (isServer || isDedicated) then {
    _position = _this select 0;
    _box_name = _this select 1;
    diag_log format[LOG_STR + "position %1", _position];
    diag_log format[LOG_STR + "name %1", _box_name];
    _ammobox = "CUP_VABox" createVehicle _position;    
    _ammobox allowDamage false; // do not allow box to be damaged
    _ammobox enableSimulation false; // do not allow box to be moved
    _ammobox setVehicleVarName _box_name;
    publicVariable _box_name;
    AMMO_BOX_ARRAY pushBack _ammobox;
    
    ["AmmoboxInit", [_ammobox, true]] call BIS_fnc_arsenal;;

    [_ammobox,(_ammobox call BIS_fnc_getVirtualWeaponcargo),true] call BIS_fnc_removeVirtualWeaponCargo;
    [_ammobox, operation_dagger_arsenal call BIS_fnc_getVirtualWeaponcargo, (true)] call BIS_fnc_addVirtualWeaponCargo;

    [_ammobox,(_ammobox call BIS_fnc_getVirtualMagazineCargo),true] call BIS_fnc_removeVirtualMagazineCargo;
    [_ammobox, operation_dagger_arsenal call BIS_fnc_getVirtualMagazineCargo, (true)] call BIS_fnc_addVirtualMagazineCargo;

    [_ammobox,(_ammobox call BIS_fnc_getVirtualBackpackCargo),true] call BIS_fnc_removeVirtualBackpackCargo;
    [_ammobox, operation_dagger_arsenal call BIS_fnc_getVirtualBackpackCargo, (true)] call BIS_fnc_addVirtualBackpackCargo;

    [_ammobox,(_ammobox call BIS_fnc_getVirtualItemCargo),true] call BIS_fnc_removeVirtualItemCargo;
    [_ammobox, operation_dagger_arsenal call BIS_fnc_getVirtualItemCargo, (true)] call BIS_fnc_addVirtualItemCargo;

    /*
    fnc_copyVehicleArsenal = {
        Params["_vehToCopy", "_destVehs"];
        Private["_BackPackCargo", "_ItemCargo", "_MagazineCargo", "_WeaponCargo"];
        _BackPackCargo = _vehToCopy call BIS_fnc_getVirtualBackpackCargo;
        _ItemCargo = _vehToCopy call BIS_fnc_getVirtualItemCargo;
        _MagazineCargo = _vehToCopy call BIS_fnc_getVirtualMagazineCargo;
        _WeaponCargo = _vehToCopy call BIS_fnc_getVirtualWeaponcargo;
        {
            [_x, _BackPackCargo] call BIS_fnc_addVirtualBackpackCargo;
            [_x, _ItemCargo] call BIS_fnc_addVirtualItemCargo;
            [_x, _MagazineCargo] call BIS_fnc_addVirtualMagazineCargo;
            [_x, _WeaponCargo] call BIS_fnc_addVirtualWeaponCargo;
            //["AmmoboxServer", [_x, true]] call BIS_fnc_arsenal;
        } forEach _destVehs;
    };

    [operation_dagger_arsenal, [_ammobox]] call fnc_copyVehicleArsenal;
    */

    [[_ammobox], "fnc_AddSaveAction", true, true] call BIS_fnc_MP;
    [[_ammobox], "fnc_AddLoadAction", true, true] call BIS_fnc_MP;
    
    diag_log format[LOG_STR + "Items in spawned box: %1", _ammobox call BIS_fnc_getVirtualItemCargo];
};    
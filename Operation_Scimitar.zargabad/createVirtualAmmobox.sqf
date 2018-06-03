#include "opconstants.hpp"
// https://forums.bistudio.com/topic/188425-how-to-copy-virtual-inventory-from-a-vehicle-to-another/

fnc_AddSaveAction = {
    diag_log format[LOG_STR + "Adding save action"];
    _ammobox = (_this select 0);
    _ammobox addAction ["<t color=""#FE2E2E"">"+ "Save inventory", {[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory}];
};

fnc_AddLoadAction = {
    diag_log format[LOG_STR + "Adding load action"];
    _ammobox = (_this select 0);
    _ammobox addAction ["<t color=""#CCFF66"">"+ "Load inventory", {[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory}];
};

if (isServer || isDedicated) then {
    _position = _this select 0;
    _box_name = _this select 1;
    diag_log format[LOG_STR + "position %1", _position];
    diag_log format[LOG_STR + "name %1", _box_name];
    _ammobox = "AmmoCrates_NoInteractive_Medium" createVehicle _position;    //TODO replace crate type with a variable to make it more generic
    _ammobox allowDamage false; // do not allow box to be damaged
    _ammobox enableSimulation false; // do not allow box to be moved
    _ammobox setVehicleVarName _box_name;
    publicVariable _box_name;
    AMMO_BOX_ARRAY pushBack _ammobox;

    ["AmmoboxInit", [_ammobox, true]] call BIS_fnc_arsenal;;

    [_ammobox,(_ammobox call BIS_fnc_getVirtualWeaponcargo),true] call BIS_fnc_removeVirtualWeaponCargo;
    [_ammobox, bluforVirtualArsenal call BIS_fnc_getVirtualWeaponcargo, (true)] call BIS_fnc_addVirtualWeaponCargo;

    [_ammobox,(_ammobox call BIS_fnc_getVirtualMagazineCargo),true] call BIS_fnc_removeVirtualMagazineCargo;
    [_ammobox, bluforVirtualArsenal call BIS_fnc_getVirtualMagazineCargo, (true)] call BIS_fnc_addVirtualMagazineCargo;

    [_ammobox,(_ammobox call BIS_fnc_getVirtualBackpackCargo),true] call BIS_fnc_removeVirtualBackpackCargo;
    [_ammobox, bluforVirtualArsenal call BIS_fnc_getVirtualBackpackCargo, (true)] call BIS_fnc_addVirtualBackpackCargo;

    [_ammobox,(_ammobox call BIS_fnc_getVirtualItemCargo),true] call BIS_fnc_removeVirtualItemCargo;
    [_ammobox, bluforVirtualArsenal call BIS_fnc_getVirtualItemCargo, (true)] call BIS_fnc_addVirtualItemCargo;

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

    [bluforVirtualArsenal, [_ammobox]] call fnc_copyVehicleArsenal;
    */

    // https://community.bistudio.com/wiki/remoteExec
    //TODO this does not work on dedicated server
    [_ammobox] remoteExec ["fnc_AddSaveAction", 0, true];
    [_ammobox] remoteExec ["fnc_AddLoadAction", 0, true];


    diag_log format[LOG_STR + "Items in spawned box: %1", _ammobox call BIS_fnc_getVirtualItemCargo];
};

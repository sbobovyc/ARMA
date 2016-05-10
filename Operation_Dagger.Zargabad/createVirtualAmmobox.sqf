// https://forums.bistudio.com/topic/188425-how-to-copy-virtual-inventory-from-a-vehicle-to-another/
_position = _this;
diag_log format["$$$$$ position %1", _position];
_ammobox = "CUP_VABox" createVehicle _position;

["AmmoboxInit",[_ammobox,false,{true}]] spawn BIS_fnc_arsenal;//applies arsenal to object "ammobox" and includes all items.
//BUG This should have created an empty arsenal, but it has to be manually cleared
[_ammobox,(weaponCargo _ammobox),true] call BIS_fnc_removeVirtualWeaponCargo;
[_ammobox,(magazineCargo _ammobox),true] call BIS_fnc_removeVirtualMagazineCargo;
[_ammobox,(backpackCargo _ammobox),true] call BIS_fnc_removeVirtualBackpackCargo;
[_ammobox,(itemCargo _ammobox),true] call BIS_fnc_removeVirtualItemCargo;


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
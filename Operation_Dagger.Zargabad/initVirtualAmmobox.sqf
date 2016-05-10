_box = _this select 0;
diag_log format["Initing virtual box %1", _box];
[_box,[true],true] spawn BIS_fnc_removeVirtualBackpackCargo; 
//[_box,[true],true] spawn BIS_fnc_removeVirtualItemCargo; 
//[_box,[true],true] spawn BIS_fnc_removeVirtualMagazineCargo; 
//[_box,[true],true] spawn BIS_fnc_removeVirtualWeaponCargo;
private _avar = missionNamespace getVariable "inventory_var";
if (not isNil "_avar") then {
    [player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;
};
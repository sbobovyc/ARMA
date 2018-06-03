#include "opconstants.hpp"

diag_log format[LOG_STR + " onPlayerRespawn"];

private _avar = missionNamespace getVariable "inventory_var";

//TODO _avar is always null, even if inventory has been saved
//if (not isNil {missionNamespace getVariable "inventory_var"}) then {
    [player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;
//} else {
    //diag_log format[LOG_STR + " in else"];
//};
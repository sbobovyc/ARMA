#include "opdagger.hpp"

createVirtualAmmobox = compileFinal preprocessFileLineNumbers "createVirtualAmmobox.sqf";
createSpawnLocation = compileFinal preprocessFileLineNumbers "createSpawnLocation.sqf";

fnc_AddSaveAction = {
    diag_log "$$$$$$ Adding save action";
    _ammobox = (_this select 0);
    _ammobox addAction ["<t color=""#FE2E2E"">"+ "Save inventory", {[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory}];
};

fnc_AddLoadAction = {    
    diag_log "$$$$$$ Adding load action";
    _ammobox = (_this select 0);
    _ammobox addAction ["<t color=""#CCFF66"">"+ "Load inventory", {[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory}];
};

0 fadeRadio 0; //mute in-game radio commands

diag_log LOG_STR + "init finished" 
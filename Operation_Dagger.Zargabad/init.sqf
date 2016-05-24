#include "opdagger.hpp"

createVirtualAmmobox = compileFinal preprocessFileLineNumbers "createVirtualAmmobox.sqf";
createSpawnLocation = compileFinal preprocessFileLineNumbers "createSpawnLocation.sqf";
createSpawnLocation = compileFinal preprocessFileLineNumbers "createSpawnLocation.sqf";

AMMO_BOX_ARRAY = [];

if(isDedicated) then {
    blufor_ai_spawn setVariable["Faction", "ISC_IA_B", true];
    opfor_ai_spawn setVariable["Faction", "ISC_IS_O", true];    
    /*
    groupFilter = compile preprocessFileLineNumbers "groupFilter.sqf";
    WestGroupFilter = [west] call groupFilter;
    blufor_ai_spawn setVariable ["BlacklistedGroups",WestGroupFilter,true];

    EastGroupFilter = [east] call groupFilter;
    opfor_ai_spawn setVariable ["BlacklistedGroups",EastGroupFilter,true];    
    */
};

/*
//This is for documentation only. This is what goes in the spawn ai module init. For some reason this does not work on a dedicated server.
groupFilter = compile preprocessFileLineNumbers "groupFilter.sqf"; GroupFilter = [west] call groupFilter; diag_log GroupFilter;  this setVariable ["BlacklistedGroups",GroupFilter,true]; diag_log "Finished blufor ai spawn init";
*/

fnc_AddSaveAction = {
    diag_log LOG_STR + "Adding save action";
    _ammobox = (_this select 0);
    _ammobox addAction ["<t color=""#FE2E2E"">"+ "Save inventory", {[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory}];
};

fnc_AddLoadAction = {    
    diag_log LOG_STR + "Adding load action";
    _ammobox = (_this select 0);    
    _ammobox addAction ["<t color=""#CCFF66"">"+ "Load inventory", {[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory}];
};

fnc_FixVehicleDecals = {
    _vehicle = (_this select 0);
    if((typeOf _vehicle) == "rhs_btr60_msv") then {
        _vehicle setObjectTextureGlobal [4, ""];
        _vehicle setObjectTextureGlobal [9, ""];
        _vehicle setObjectTextureGlobal [10, ""];
        _vehicle setObjectTextureGlobal [11, ""];
        _vehicle setObjectTextureGlobal [12, ""];
    };
    if((typeOf _vehicle) == "rhs_bmp1_vv") then {
        _vehicle setObjectTextureGlobal [6, ""];
        _vehicle setObjectTextureGlobal [7, ""];
        _vehicle setObjectTextureGlobal [8, ""];
        _vehicle setObjectTextureGlobal [9, ""];
        _vehicle setObjectTextureGlobal [12, ""];
        _vehicle setObjectTextureGlobal [13, ""];
    };
};

0 fadeRadio 0; //mute in-game radio commands

diag_log LOG_STR + "init finished";
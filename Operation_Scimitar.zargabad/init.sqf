#include "opconstants.hpp"

createVirtualAmmobox = compileFinal preprocessFileLineNumbers "createVirtualAmmobox.sqf";
createSpawnLocation = compileFinal preprocessFileLineNumbers "createSpawnLocation.sqf";
AMMO_BOX_ARRAY = [];

// sector spawn ai https://www.youtube.com/watch?time_continue=119&v=bnIN8SWkfL0
/*
Q: When i try this a message pops up saying "x no valid area is linked to the to the sector" please help﻿
A: Sounds like you need to synchronize a game logic module called "Area" to each of your Sectors. Don't forget to do the game logic for each "Side" that you want to be able to capture each sector module too.﻿
*/
if(isServer || isDedicated) then {
    opfor_ai_spawn setVariable["Faction", "CFP_O_IS", true];
    blufor_ai_spawn_1 setVariable["Faction", "CFP_B_IQPOLICE", true];
};


["AmmoboxInit",[bluforVirtualArsenal,false]] spawn BIS_fnc_arsenal;
 _weaponList = [
 "Binocular",
 "CUP_LRTV",
 "CUP_hgun_SA61",
 "CUP_hgun_Glock17",
 "CUP_arifle_FNFAL_railed",
 "CUP_arifle_AKS",
 "CUP_arifle_AK74_GL",
 "CUP_arifle_M16A4_Base",
 "CUP_arifle_M4A1",
 "CUP_launch_M136",
 "CUP_launch_RPG7V",
 "CUP_launch_RPG18",
 "CUP_launch_Metis",
 "CUP_lmg_M240",
 "CUP_lmg_m249_pip1",
 "CUP_lmg_PKM",
 "CUP_srifle_SVD"];

[bluforVirtualArsenal,_weaponList,true] call BIS_fnc_addVirtualWeaponCargo;

[bluforVirtualArsenal,["CUP_B_AlicePack_Khaki", "CUP_B_RPGPack_Khaki"],true] call BIS_fnc_addVirtualBackpackCargo;

_items = [
"ItemMap",
"ItemGPS",
"ToolKit",
"MineDetector",
"CUP_PipeBomb_M",
"SP_ChestRig1_Green",
"V_TacVest_camo",
"CUP_optic_PGO7V",
"CUP_optic_Kobra",
"CUP_optic_PSO_1",
"CUP_optic_CompM4",
"CUP_optic_CompM2_Black",
"CUP_optic_RCO",
"CFP_H_O_RUARMY_6B27",
"CUP_H_RUS_6B27"
];
[bluforVirtualArsenal,_items,true] call BIS_fnc_addVirtualItemCargo;

_magazines = ["CUP_1Rnd_HE_GP25_M", "CUP_PG7V_M", "CUP_HandGrenade_RGD5"];
[bluforVirtualArsenal,_magazines,true] call BIS_fnc_addVirtualMagazineCargo;


0 fadeRadio 0; //mute in-game radio commands

diag_log LOG_STR + "init finished";


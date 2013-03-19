SVIS - Stan's Visual Inventory System
Author: sbobovyc
Testers: Santiago, TOFASFORALEX, and Daniel
Official site: https://github.com/sbobovyc/ARMA

Check out the video for how to use the UI:
http://youtu.be/1KzGu5kkRKc

The graphical portion consists of:
gui.hpp
InventoryDialog.hpp

InventoryDialogDefs.hpp

InventoryItems.hpp


The logic behind the gui:
createInventoryDialog.sqf

pointCamera.sqf

switchEquipment.sqf

getBackpackArray.sqf

getItemArray.sqf

getWeaponArray.sqf



The load and save functionality is provided by:
loadInventory.sqf

saveInventory.sqf




Quick start:

A sample multiplayer mission is included to show how to use the load/save loadout feature + SVIS.
Launch the mission and come up to the large supply crate and select SVIS. Choose a loadout and click "Save & Close". 
Your gear is now saved and if you die you will respawn with the saved loadout. You can also pick up equipment from normal ammo boxes and 
save your loadout at the SVIS supply crate.
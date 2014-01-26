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


End user customization provided by:
blacklist.hpp



Quick start:

A sample multiplayer mission is included to show how to use the load/save loadout feature + SVIS.
Launch the mission and come up to the large supply crate and select SVIS. Choose a loadout and click "Save & Close". 
Your gear is now saved and if you die you will respawn with the saved loadout. You can also pick up equipment from normal ammo boxes and 
save your loadout at the SVIS supply crate.


Known bugs:

* if player activates SVIS while bent over, he will be bent over in the SVIS menu (FIXED)
* pressing ESC in SVIS will exit the GUI but not the camera mode, trapping the player (FIXED)
* player drops backpacks on the ground if their are switched too quickly (FIXED)
* underware does not have any inventory slots, so uniform gear does not get saved properly (put it in the blacklist)
* rebreather does not have any inventory slots, so uniform gear does not get saved properly (put it in the blacklist)
* some magazines get left behind when player switches between weapons quickly (FIXED)
* some entries in the inventory list get left behind when player switches between weapons quickly
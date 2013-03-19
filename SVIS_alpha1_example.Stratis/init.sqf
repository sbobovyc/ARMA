// stop the annoying "Saving File" that occurs in MP editing mode every time you abort
enableSaving [false, false]; // Saving disabled without autosave.

player addMPEventHandler ["MPRespawn", {nul = [] execVM "InventorySystem\LoadInventory.sqf";}]; 
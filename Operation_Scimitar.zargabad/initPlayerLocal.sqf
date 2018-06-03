#include "opconstants.hpp"

diag_log format[LOG_STR + " initPlayerLocal"];
player setUnitTrait ["Engineer",true];

//TODO this is not working
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player addWeapon "ItemMap";
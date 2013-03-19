/*
    @file Version: v0.2
    @file name: fillCrate.sqf
    @file Author: TAW_Tonic
    @file edit: 3/8/2013
    @file Description: Automatically fill ammo box with everything in the game depending on paramenters
    @params: [box,type,bool (optional),seconds(optional default: 5min)] execVM "fillCrate.sqf
    @examples:
    nul = [this,0,true] execVM "fillCrate.sqf"; //Fill ammo crate with everything - resupply enabled
    nul = [this,1,true] execVM "fillCrate.sqf"; //Fill ammo crate with weapons & magazines - resupply enabled
    nul = [this,2] execVM "fillCrate.sqf"; //Fill ammo crate with items - resupply disabled
    nul = [this,3,true,(60 * 2)] execVM "fillCrate.sqf"; //Fill ammo crate with backpacks - resupply enabled - resupply every 2 minutes
    
    type:
    0 = Everything in one ammo box
    1 = Weapons / Magazines in one ammo box
    2 = Items / attachments in one ammo box
    3 = Backpacks only in the ammo box
*/
private["_box","_type","_boxn","_bType","_bType","_bPos","_boxn","_cfgweapons","_weapons","_magazines","_cur_wep","_classname","_wep_type","_scope","_picture","_items","_backpacks"];
_box = _this select 0;
_type = _this select 1;
_resupply = if(count _this > 2) then {_this select 2;} else {false;};
_resupply_time = if(count _this > 3) then {_this select 3;} else {60 * 5};

_bType = typeOf _box;
_bPos = getPos _box;

//Hide the global ammo box & create a local one *temp fix for locality issues).
if(!local _box) then
{
    _box hideObject true;
    _boxn = _bType createVehicleLocal [0,0,0];
    _boxn setPosATL [_bPos select 0,_bPos select 1,0];

}
    else
{
    _boxn = _box;
};

//TODO make this an option
_box allowDammage false;

clearWeaponCargo _boxn;
clearMagazineCargo _boxn;
clearItemCargo _boxn;
clearBackpackCargo _boxn;

switch (_type) do
{
    //Master ammo crate (EVERYTHING).
    case 0:
    {    
        _cfgweapons = configFile >> "CfgWeapons";
        _weapons = [];
        
        for "_i" from 0 to (count _cfgWeapons)-1 do
        {
            _cur_wep = _cfgweapons select _i;
            
            if(isClass _cur_wep) then
            {
                _classname = configName _cur_wep;
                _wep_type = getNumber(_cur_wep >> "type");
                _scope = getNumber(_cur_wep >> "scope");
                _picture = getText(_cur_wep >> "picture");
                if(_scope >= 2 && _wep_type in [1,2,4,4096] && _picture != "" && !(_classname in _weapons) && _classname != "NVGoggles") then
                {
                    //diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
                    _weapons set[count _weapons, _classname];
                };
            };
        };
        
        _cfgweapons = configFile >> "CfgMagazines";
        _magazines = [];
        
        for "_i" from 0 to (count _cfgWeapons)-1 do
        {
            _cur_wep = _cfgweapons select _i;
            
            if(isClass _cur_wep) then
            {
                _classname = configName _cur_wep;
                //_wep_type = getNumber(_cur_wep >> "type");
                _scope = getNumber(_cur_wep >> "scope");
                _picture = getText(_cur_wep >> "picture");
                if(_scope >= 2 && _picture != "" && !(_classname in _magazines)) then
                {
                    _magazines set[count _magazines, _classname];
                };
            };
        };
        
        { _boxn addWeaponCargo [_x,50]; } foreach _weapons;
        { _boxn addMagazineCargo [_x,50]; }foreach _magazines;
    
        _cfgweapons = configFile >> "CfgWeapons";
        _items = [];
        
        for "_i" from 0 to (count _cfgWeapons)-1 do
        {
            _cur_wep = _cfgweapons select _i;
            
            if(isClass _cur_wep) then
            {
                _classname = configName _cur_wep;
                _wep_type = getNumber(_cur_wep >> "type");
                _scope = getNumber(_cur_wep >> "scope");
                _picture = getText(_cur_wep >> "picture");
                //diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
                if(_scope >= 2 && _wep_type in [131072,4096] && _picture != "" && !(_classname in _items) && _classname != "Binocular") then
                {
                    //diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
                    _items set[count _items, _classname];
                };
            };
        };
        
        { _boxn addItemCargo [_x,50]; } foreach _items;
        
            _cfgweapons = configFile >> "CfgVehicles";
        _backpacks = [];
        
        for "_i" from 0 to (count _cfgWeapons)-1 do
        {
            _cur_wep = _cfgweapons select _i;
            
            if(isClass _cur_wep) then
            {
                _classname = configName _cur_wep;
                _wep_type = getText(_cur_wep >> "vehicleClass");
                _scope = getNumber(_cur_wep >> "scope");
                _picture = getText(_cur_wep >> "picture");
                if(_scope >= 2 && _wep_type == "Backpacks" && _picture != "" && !(_classname in _backpacks)) then
                {
                    //diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
                    _backpacks set[count _backpacks, _classname];
                };
            };
        };
        
        { _boxn addBackPackCargo [_x,5]; } foreach _backpacks;
    };
    //Fill box with Guns & Ammo only
    case 1:
    {
        _cfgweapons = configFile >> "CfgWeapons";
        _weapons = [];
        
        for "_i" from 0 to (count _cfgWeapons)-1 do
        {
            _cur_wep = _cfgweapons select _i;
            
            if(isClass _cur_wep) then
            {
                _classname = configName _cur_wep;
                _wep_type = getNumber(_cur_wep >> "type");
                _scope = getNumber(_cur_wep >> "scope");
                _picture = getText(_cur_wep >> "picture");
                if(_scope >= 2 && _wep_type in [1,2,4,4096] && _picture != "" && !(_classname in _weapons) && _classname != "NVGoggles") then
                {
                    //diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
                    _weapons set[count _weapons, _classname];
                };
            };
        };
        
        _cfgweapons = configFile >> "CfgMagazines";
        _magazines = [];
        
        for "_i" from 0 to (count _cfgWeapons)-1 do
        {
            _cur_wep = _cfgweapons select _i;
            
            if(isClass _cur_wep) then
            {
                _classname = configName _cur_wep;
                //_wep_type = getNumber(_cur_wep >> "type");
                _scope = getNumber(_cur_wep >> "scope");
                _picture = getText(_cur_wep >> "picture");
                if(_scope >= 2 && _picture != "" && !(_classname in _magazines)) then
                {
                    _magazines set[count _magazines, _classname];
                };
            };
        };
        
        { _boxn addWeaponCargo [_x,50]; } foreach _weapons;
        { _boxn addMagazineCargo [_x,50]; }foreach _magazines;
    };
    
    //Items only
    case 2:
    {    
        _cfgweapons = configFile >> "CfgWeapons";
        _items = [];
        
        for "_i" from 0 to (count _cfgWeapons)-1 do
        {
            _cur_wep = _cfgweapons select _i;
            
            if(isClass _cur_wep) then
            {
                _classname = configName _cur_wep;
                _wep_type = getNumber(_cur_wep >> "type");
                _scope = getNumber(_cur_wep >> "scope");
                _picture = getText(_cur_wep >> "picture");
                //diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
                if(_scope >= 2 && _wep_type in [131072,4096] && _picture != "" && !(_classname in _items) && _classname != "Binocular") then
                {
                    //diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
                    _items set[count _items, _classname];
                };
            };
        };
        
        { _boxn addItemCargo [_x,50]; } foreach _items;
    };
    
    case 3:
    {

        _cfgweapons = configFile >> "CfgVehicles";
        _backpacks = [];
        
        for "_i" from 0 to (count _cfgWeapons)-1 do
        {
            _cur_wep = _cfgweapons select _i;
            
            if(isClass _cur_wep) then
            {
                _classname = configName _cur_wep;
                _wep_type = getText(_cur_wep >> "vehicleClass");
                _scope = getNumber(_cur_wep >> "scope");
                _picture = getText(_cur_wep >> "picture");
                if(_scope >= 2 && _wep_type == "Backpacks" && _picture != "" && !(_classname in _backpacks)) then
                {
                    //diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
                    _backpacks set[count _backpacks, _classname];
                };
            };
        };
        
        { _boxn addBackPackCargo [_x,5]; } foreach _backpacks;
    };
};

if(_resupply) then
{
    sleep _resupply_time;
    [_boxn,_type,_resupply,_resupply_time] execVM "fillCrate.sqf";
};  
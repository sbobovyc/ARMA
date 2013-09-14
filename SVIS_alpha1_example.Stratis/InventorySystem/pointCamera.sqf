/**
  * @file pointCamera.sqf
  * @author sbobovyc
  * @param view_option "Headgear", "Uniform"
  * @details
  * Uses global SVIS_CAM and SVIS_MUTEX.
  * SVIS_MUTEX = false; // initialize mutex
  * nul = [] execVM "InventorySystem\pointCamera.sqf";
  */
  
#define ZOOM_TIME_NOW 0
#define ZOOM_TIME_SHORT 1.5
#define ZOOM_TIME_LONG 2.5
#define LOCK_CAM SVIS_MUTEX = true
#define UNLOCK_CAM SVIS_MUTEX = false
#define NVG_CHECK if(daytime >= 21.0 || daytime <= 4.0) then {camUseNVG true;} else {camUseNVG false;}


commitGlobalCamFace =
{
	_speed = _this select 0;
	_pos = _this select 1;
	SVIS_CAM camSetTarget [_pos select 0, _pos select 1, (_pos select 2)+1.3];
	SVIS_CAM cameraEffect ["internal", "BACK"];
	SVIS_CAM camCommit _speed;	
	
};

commitGlobalCamBody =
{
	_speed = _this select 0;
	_pos = _this select 1;
	SVIS_CAM camSetTarget [_pos select 0, _pos select 1, (_pos select 2)+1.0];
	SVIS_CAM cameraEffect ["internal", "BACK"];
	SVIS_CAM camCommit _speed;	
	
};

defaultGlobalCam =
{
	_pos = _this select 0;
	//TODO camera does not point in correct direction unless player faces north
	SVIS_CAM camSetPos [_pos select 0, (_pos select 1)+2.3, (_pos select 2)+1];
	[ZOOM_TIME_SHORT, _pos] call commitGlobalCamBody;		
};


_view_option = "Init";
if(count _this > 0) then 
{
	_view_option = _this select 0;
};

if(isNil("SVIS_MUTEX")) then {
	SVIS_MUTEX = false; 
};

if(!SVIS_MUTEX || _view_option == "Init" || _view_option == "Destroy") then {
	_pos = getPos player;
		
	switch(_view_option) do
	{

		case "Init":
		{
			diag_log "SVIS: pointCamera, in init";			
			LOCK_CAM;
			NVG_CHECK;
			// show some nice effects
			showCinemaBorder false;
			cutText ["", "BLACK IN"];
			//SVIS_CAM = "camera" camCreate [_pos select 0, (_pos select 1)+2.3, (_pos select 2)+1];
			SVIS_CAM = "camera" createVehicleLocal [_pos select 0, (_pos select 1)+2.3, (_pos select 2)+1];			 
			[_pos] call defaultGlobalCam;
			UNLOCK_CAM;
			diag_log "SVIS: pointCamera, done init";			
			
		};	
		case "Default":
		{
			[_pos] call defaultGlobalCam;
			waitUntil {camCommitted SVIS_CAM;};			
			
		};	
		case "Headgear":
		{
			LOCK_CAM;
			NVG_CHECK;
			diag_log "SVIS: pointCamera, in headgear";
			SVIS_CAM camSetPos [(_pos select 0) - 0.5, (_pos select 1)+1.0, (_pos select 2)+2.0];
			[ZOOM_TIME_SHORT, _pos] call commitGlobalCamFace;	
			waitUntil {camCommitted SVIS_CAM;};	
			/*
			SVIS_CAM camSetPos [(_pos select 0) + 1.5, (_pos select 1)+1.0, (_pos select 2)+2.0];
			[ZOOM_TIME_LONG, _pos] call commitGlobalCamFace;		
			waitUntil {camCommitted SVIS_CAM;};		
			
			[_pos] call defaultGlobalCam;		
			waitUntil {camCommitted SVIS_CAM;};					
			*/
			diag_log "SVIS: pointCamera, done headgear";	
			UNLOCK_CAM;				
		};	
		case "Uniform":
		{
			LOCK_CAM;
			NVG_CHECK;			
			/*
			diag_log "SVIS: pointCamera, in uniform";
			SVIS_CAM camSetPos [(_pos select 0) - 0.3, (_pos select 1)+1.2, (_pos select 2)+1.5];
			[ZOOM_TIME_SHORT, _pos] call commitGlobalCamBody;	
			waitUntil {camCommitted SVIS_CAM;};	

			SVIS_CAM camSetPos [(_pos select 0) + 1.5, (_pos select 1)+1.2, (_pos select 2)+1.5];
			[ZOOM_TIME_LONG, _pos] call commitGlobalCamBody;		
			waitUntil {camCommitted SVIS_CAM;};		
			*/
			[_pos] call defaultGlobalCam;		
			waitUntil {camCommitted SVIS_CAM;};				
			diag_log "SVIS: pointCamera, done uniform";
			UNLOCK_CAM;			
		};
		case "Vest":
		{
			LOCK_CAM;
			NVG_CHECK;			
			diag_log "SVIS: pointCamera, in uniform";
			SVIS_CAM camSetPos [(_pos select 0) - 0.3, (_pos select 1)+1.2, (_pos select 2)+1.5];
			[ZOOM_TIME_SHORT, _pos] call commitGlobalCamBody;	
			waitUntil {camCommitted SVIS_CAM;};	
			
			/*
			SVIS_CAM camSetPos [(_pos select 0) + 1.5, (_pos select 1)+1.2, (_pos select 2)+1.5];
			[ZOOM_TIME_LONG, _pos] call commitGlobalCamBody;		
			waitUntil {camCommitted SVIS_CAM;};		
			
			[_pos] call defaultGlobalCam;		
			waitUntil {camCommitted SVIS_CAM;};				
			*/
			diag_log "SVIS: pointCamera, done uniform";
			UNLOCK_CAM;			
		};		
		case "Backpack":
		{
			LOCK_CAM;
			NVG_CHECK;			
			diag_log "SVIS: pointCamera, in backpack";
			SVIS_CAM camSetPos [(_pos select 0) - 0.5, (_pos select 1)-1.0, (_pos select 2)+2.0];
			[ZOOM_TIME_LONG, _pos] call commitGlobalCamFace;	
			waitUntil {camCommitted SVIS_CAM;};	
				
			diag_log "SVIS: pointCamera, done backpack";	
			UNLOCK_CAM;				
		};		
		case "Weapon":
		{
			LOCK_CAM;
			NVG_CHECK;			
			diag_log "SVIS: pointCamera, in weapon";
			SVIS_CAM camSetPos [(_pos select 0) + 0.5, (_pos select 1)+1.0, (_pos select 2)+1.5];
			[ZOOM_TIME_LONG, _pos] call commitGlobalCamBody;	
			waitUntil {camCommitted SVIS_CAM;};	
				
			diag_log "SVIS: pointCamera, done weapon";	
			UNLOCK_CAM;				
		};				
		case "Destroy":
		{
			// clean up
			// give control back to player
			player cameraEffect ["terminate","back"];
			cutText ["", "BLACK IN"];
			camDestroy SVIS_CAM;
			SVIS_CAM = nil;	
			SVIS_MUTEX = nil;		
		};
		default
		{
			diag_log "Wrong state in pointCamera";
			hint "Wrong state in pointCamera";
		};
	};
};


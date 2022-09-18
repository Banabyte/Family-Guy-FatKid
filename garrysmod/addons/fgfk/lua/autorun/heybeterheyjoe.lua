//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "Joe Swanson (Pinball FX3)", "models/hellinspector/fgjoepinball/joe_pm.mdl" );

list.Set( "PlayerOptionsModel", "Joe Swanson (Pinball FX3)", "models/hellinspector/fgjoepinball/joe_pm.mdl" );


local Category = "Joe Swanson (Pinball FX3)"

local NPC = {   
        Name = "Joe Swanson Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/fgjoepinball/joe_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Joe Swanson Enemy"
}

list.Set( "NPC", "npc_JoeSwansonenemy", NPC ) 

local NPC = {   
        Name = "Joe Swanson Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/fgjoepinball/joe_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Joe Swanson Friend"
}

list.Set( "NPC", "npc_JoeSwansonFriend", NPC ) 



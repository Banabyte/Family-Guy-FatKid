//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "Peter (Hooker)", "models/hellinspector/hookerpeter/hookerpeter_pm.mdl" );

list.Set( "PlayerOptionsModel", "Peter (Hooker)", "models/hellinspector/hookerpeter/hookerpeter_pm.mdl" );


local Category = "Peter (Hooker)"

local NPC = {   
        Name = "Peter (Hooker) Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/hookerpeter/hookerpeter_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Peter (Hooker) Enemy"
}

list.Set( "NPC", "npc_PeterHookerenemy", NPC ) 

local NPC = {   
        Name = "Peter (Hooker) Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/hookerpeter/hookerpeter_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Peter (Hooker) Friend"
}

list.Set( "NPC", "npc_PeterHookerFriend", NPC ) 



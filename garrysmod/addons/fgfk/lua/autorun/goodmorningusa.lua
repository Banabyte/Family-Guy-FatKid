//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "Stan Smith", "models/hellinspector/stansmith/stan_pm.mdl" );

list.Set( "PlayerOptionsModel", "Stan Smith", "models/hellinspector/stansmith/stan_pm.mdl" );


local Category = "Stan Smith"

local NPC = {   
        Name = "Stan Smith Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/stansmith/stan_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Stan Smith Enemy"
}

list.Set( "NPC", "npc_StanSmithenemy", NPC ) 

local NPC = {   
        Name = "Stan Smith Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/stansmith/stan_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Stan Smith Friend"
}

list.Set( "NPC", "npc_StanSmithFriend", NPC ) 



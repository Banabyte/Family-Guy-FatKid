//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "Adam West (Family Guy)", "models/hellinspector/familyguybttm/adamwest_pm.mdl" );

list.Set( "PlayerOptionsModel", "Adam West (Family Guy)", "models/hellinspector/familyguybttm/adamwest_pm.mdl" );


local Category = "Adam West (Family Guy)"

local NPC = {   
        Name = "Adam West Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/familyguybttm/adamwest_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Adam West Enemy"
}

list.Set( "NPC", "npc_AdamWestenemy", NPC ) 

local NPC = {   
        Name = "Adam West Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/familyguybttm/adamwest_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Adam West Friend"
}

list.Set( "NPC", "npc_AdamWestFriend", NPC ) 



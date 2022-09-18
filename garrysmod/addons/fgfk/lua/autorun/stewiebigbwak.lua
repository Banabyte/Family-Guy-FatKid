//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "Stewie (Big)", "models/hellinspector/bigstewie/bigstewie_pm.mdl" );

list.Set( "PlayerOptionsModel", "Stewie (Big)", "models/hellinspector/bigstewie/bigstewie_pm.mdl" );


local Category = "Big Stewie"

local NPC = {   
        Name = "Big Stewie Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/bigstewie/bigstewie_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Big Stewie Enemy"
}

list.Set( "NPC", "npc_BigStewieenemy", NPC ) 

local NPC = {   
        Name = "Big Stewie Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/bigstewie/bigstewie_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Big Stewie Friend"
}

list.Set( "NPC", "npc_BigStewieFriend", NPC ) 



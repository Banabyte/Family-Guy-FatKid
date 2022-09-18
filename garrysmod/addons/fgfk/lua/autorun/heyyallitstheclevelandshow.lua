player_manager.AddValidModel( "Cleveland Brown", "models/hellinspector/cleveland/cleveland_player.mdl" );

list.Set( "PlayerOptionsModel", "Cleveland Brown", "models/hellinspector/cleveland/cleveland_player.mdl" );


local Category = "Cleveland"

local NPC = {   
        Name = "Cleveland Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/cleveland/cleveland_player.mdl",                 
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Cleveland Enemy"
}

list.Set( "NPC", "npc_clevelandenemy", NPC ) 

local NPC = {   
        Name = "Cleveland Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/cleveland/cleveland_player.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Cleveland Friend"
}

list.Set( "NPC", "npc_clevelandFriend", NPC ) 



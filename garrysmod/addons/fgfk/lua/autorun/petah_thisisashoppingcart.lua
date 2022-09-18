//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "Lois Griffin (Family Guy)", "models/hellinspector/lois_family_guy/lois_pm.mdl" );

list.Set( "PlayerOptionsModel", "Lois Griffin (Family Guy)", "models/hellinspector/lois_family_guy/lois_pm.mdl" );


local Category = "Lois Griffin (Family Guy)"

local NPC = {   
        Name = "Lois Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/lois_family_guy/lois_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Lois Enemy"
}

list.Set( "NPC", "npc_Loisenemy", NPC ) 

local NPC = {   
        Name = "Lois Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/lois_family_guy/lois_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Lois Friend"
}

list.Set( "NPC", "npc_LoisFriend", NPC ) 



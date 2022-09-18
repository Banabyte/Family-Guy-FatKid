//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "Stewie Griffin (BTTM)", "models/hellinspector/familyguybttm/stewie_pm.mdl" );

list.Set( "PlayerOptionsModel", "Stewie Griffin (BTTM)", "models/hellinspector/familyguybttm/stewie_pm.mdl" );


local Category = "Stewie Griffin (BTTM)"

local NPC = {   
        Name = "Stewie (BTTM) Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/familyguybttm/stewie_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Stewie BTTM Enemy"
}

list.Set( "NPC", "npc_StewieBTTMenemy", NPC ) 

local NPC = {   
        Name = "Stewie (BTTM) Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/familyguybttm/stewie_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "StewieBTTMFriend"
}

list.Set( "NPC", "npc_StewieBTTMFriend", NPC ) 



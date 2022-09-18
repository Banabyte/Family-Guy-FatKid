//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "Peter Griffin (BTTM)", "models/hellinspector/familyguy_bttm/peter_pm.mdl" );

list.Set( "PlayerOptionsModel", "Peter Griffin (BTTM)", "models/hellinspector/familyguy_bttm/peter_pm.mdl" );


local Category = "Peter Griffin (BTTM)"

local NPC = {   
        Name = "Peter (BTTM) Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/familyguy_bttm/peter_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Peter (BTTM) Enemy"
}

list.Set( "NPC", "npc_PeterBTTMenemy", NPC ) 

local NPC = {   
        Name = "Peter (BTTM) Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/familyguy_bttm/peter_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Peter (BTTM) Friend"
}

list.Set( "NPC", "npc_PeterBTTMFriend", NPC ) 



//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "Glenn Quagmire (Family Guy: BTTM)", "models/hellinspector/familyguybacktothemultiverse/quagmire_pm.mdl" );

list.Set( "PlayerOptionsModel", "Glenn Quagmire (Family Guy: BTTM)", "models/hellinspector/familyguybacktothemultiverse/quagmire_pm.mdl" );


local Category = "Glenn Quagmire (Family Guy: BTTM)"

local NPC = {   
        Name = "Glenn Quagmire Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/familyguybacktothemultiverse/quagmire_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Glenn Quagmire Enemy"
}

list.Set( "NPC", "npc_GlennQuagmireenemy", NPC ) 

local NPC = {   
        Name = "Glenn Quagmire Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/familyguybacktothemultiverse/quagmire_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Glenn Quagmire Friend"
}

list.Set( "NPC", "npc_GlennQuagmireFriend", NPC ) 



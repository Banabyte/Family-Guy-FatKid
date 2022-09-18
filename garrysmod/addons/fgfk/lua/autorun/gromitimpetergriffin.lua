//Replace all the "XXX" with your character name.

//         Put your model folder here vvv
player_manager.AddValidModel( "W&G FG Pack: Wallace (Peter)", "models/hellinspector/familyguywandg/wallace_peter_pm.mdl" );

list.Set( "PlayerOptionsModel", "W&G FG Pack: Wallace (Peter)", "models/hellinspector/familyguywandg/wallace_peter_pm.mdl" );

player_manager.AddValidModel( "W&G FG Pack: Lady Tottington (Lois)", "models/hellinspector/familyguywandg/tottington_lois_pm.mdl" );

list.Set( "PlayerOptionsModel", "W&G FG Pack: Lady Tottington (Lois)", "models/hellinspector/familyguywandg/tottington_lois_pm.mdl" );

player_manager.AddValidModel( "W&G FG Pack: Victor (Quagmire)", "models/hellinspector/familyguywandg/victor_quagmire_pm.mdl" );

list.Set( "PlayerOptionsModel", "W&G FG Pack: Victor (Quagmire)", "models/hellinspector/familyguywandg/victor_quagmire_pm.mdl" );

player_manager.AddValidModel( "W&G FG Pack: Gromit (Brian)", "models/hellinspector/familyguywandg/gromit_brian_pm.mdl" );

list.Set( "PlayerOptionsModel", "W&G FG Pack: Gromit (Brian)", "models/hellinspector/familyguywandg/gromit_brian_pm.mdl" );

player_manager.AddValidModel( "W&G FG Pack: Hutch (Stewie)", "models/hellinspector/familyguywandg/hutch_stewie_pm.mdl" );

list.Set( "PlayerOptionsModel", "W&G FG Pack: Hutch (Stewie)", "models/hellinspector/familyguywandg/hutch_stewie_pm.mdl" );


local Category = "W&G FG Pack"

local NPC = {   
        Name = "Wallace (Peter) Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/familyguywandg/wallace_peter_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Wallace Peter Enemy"
}

list.Set( "NPC", "npc_WallacePeterenemy", NPC ) 

local NPC = {   
        Name = "Lady Tottington (Lois) Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/familyguywandg/tottington_lois_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Lady Tottington Lois Enemy"
}

list.Set( "NPC", "npc_LadyTottingtonLoisenemy", NPC ) 

local NPC = {   
        Name = "Victor (Quagmire) Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/familyguywandg/victor_quagmire_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Victor Quagmire Enemy"
}

list.Set( "NPC", "npc_VictorQuagmireenemy", NPC ) 

local NPC = {   
        Name = "Gromit (Brian) Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/familyguywandg/gromit_brian_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Gromit Brian Enemy"
}

list.Set( "NPC", "npc_GromitBrianenemy", NPC ) 

local NPC = {   
        Name = "Hutch (Stewie) Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/familyguywandg/hutch_stewie_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Hutch Stewie Enemy"
}

list.Set( "NPC", "npc_HutchStewieenemy", NPC ) 

//Friends

local NPC = {   
        Name = "Wallace (Peter) Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/familyguywandg/wallace_peter_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Wallace Peter Friend"
}

list.Set( "NPC", "npc_WallacePeterFriend", NPC ) 

local NPC = {   
        Name = "Lady Tottington (Lois) Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/familyguywandg/tottington_lois_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Lady Tottington Lois Friend"
}

list.Set( "NPC", "npc_LadyTottingtonLoisFriend", NPC ) 

local NPC = {   
        Name = "Victor (Quagmire) Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/familyguywandg/victor_quagmire_pm.mdl",                
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Victor Quagmire Friend"
}

list.Set( "NPC", "npc_VictorQuagmireFriend", NPC ) 

local NPC = {   
        Name = "Gromit (Brian) Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/familyguywandg/gromit_brian_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Gromit Brian Friend"
}

list.Set( "NPC", "npc_GromitBrianFriend", NPC ) 

local NPC = {   
        Name = "Hutch (Stewie) Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/familyguywandg/hutch_stewie_pm.mdl",              
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "Hutch Stewie Friend"
}

list.Set( "NPC", "npc_HutchStewieFriend", NPC ) 


--He lets me see the boobies on the internet site!--


player_manager.AddValidModel( "Family Guy - Chris Griffin", 					"models/player/familyguy/chris/chrisg_pm.mdl" )
player_manager.AddValidHands( "Family Guy - Chris Griffin",                   "models/player/familyguy/chris/chrisg_hands.mdl", 0, "000000" )

local Category = "Family Guy"

local NPC = {
	Name = "Chris Griffin - Friendly", 
	Class = "npc_citizen",
	KeyValues = { citizentype = 4 },
	Model = "models/player/familyguy/chris/chrisg_npc.mdl",
	Health = "100",
	Category = Category	
}

list.Set( "NPC", "npc_famguychris_g", NPC )

local NPC = {
	Name = "Chris Griffin - Hostile", 
	Class = "npc_combine_s",
	KeyValues = { SquadName = "familyguy", Numgrenades = 5 },
	Model = "models/player/familyguy/chris/chrisg_npc.mdl",
	Health = "100",
	Category = Category,
	Weapons = { "weapon_smg1", "weapons_ar2", "weapon_Shotgun" }
}

list.Set( "NPC", "npc_famguychris_h", NPC )

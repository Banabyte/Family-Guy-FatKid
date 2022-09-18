CreateConVar("sv_SyntTarget_enabled", 1, { FCVAR_ARCHIVE, FCVAR_REPLICATED,FCVAR_CLIENTCMD_CAN_EXECUTE,FCVAR_SERVER_CAN_EXECUTE }, "Allow players to enable target health bars",0,1)
CreateConVar("sv_SyntTarget_rule_primary_max", 3, { FCVAR_ARCHIVE, FCVAR_REPLICATED,FCVAR_CLIENTCMD_CAN_EXECUTE,FCVAR_SERVER_CAN_EXECUTE }, "Highest primary rule the players can set",0,3)
CreateConVar("sv_SyntTarget_rule_secondary_max", 2, { FCVAR_ARCHIVE, FCVAR_REPLICATED,FCVAR_CLIENTCMD_CAN_EXECUTE,FCVAR_SERVER_CAN_EXECUTE }, "Highest secondary rule the players can set",0,2)
CreateConVar("sv_SyntTarget_rule_crosshair", 1, { FCVAR_ARCHIVE, FCVAR_REPLICATED,FCVAR_CLIENTCMD_CAN_EXECUTE,FCVAR_SERVER_CAN_EXECUTE }, "Allow user to enable crosshair bypass",0,1)


SYNT_TARGET = {}
SYNT_TARGET.entities = {}

SYNT_TARGET.NpcFactions = {
	npc_antlion = "ants", npc_antlionguard = "ants", npc_antlionguardian = "ants", npc_antlion_worker = "ants",
	
	npc_barnacle = "zombies", npc_fastzombie = "zombies", npc_fastzombie_torso = "zombies", npc_headcrab = "zombies", 
	npc_headcrab_fast = "zombies", npc_headcrab_black = "zombies", npc_fastzombie = "zombies", npc_zombie = "zombies", 
	npc_zombie_torso = "zombies", npc_zombine = "zombies", npc_poisonzombie = "zombies",

	npc_breen = "combine", npc_clawscanner = "combine", npc_combine_s = "combine", npc_cscanner = "combine", npc_strider = "combine",  
	npc_hunter = "combine", npc_metropolice = "combine", npc_manhack = "combine", npc_stalker = "combine", npc_helicopter = "combine",
	npc_combinegunship = "combine", npc_combinedropship = "combine",
	
	npc_alyx = "humans", npc_barney = "humans", npc_citizen = "humans", npc_dog = "humans", npc_eli = "humans",
	npc_fisherman = "humans", npc_gman = "humans", npc_kleiner = "humans", npc_magnusson = "humans",
	npc_monk = "humans", npc_mossman = "humans", npc_odessa = "humans", npc_vortigaunt = "humans",

	npc_crow = "neutral", npc_pigeon = "neutral", npc_seagull = "neutral"
}

local function GetTargetFaction(npc)
	return SYNT_TARGET.NpcFactions[npc] or "unknown"
end

-- Called once if script get reloaded and have to re-fill existing entities
for k, ent in pairs(ents.GetAll()) do 
	if ent:IsNPC() == true or ent:IsPlayer() == true or ent:IsNextBot() == true then 
		table.insert(SYNT_TARGET.entities, ent)
	end
end

hook.Add("OnEntityCreated", "SyntTargetEntityStorage", function(ent)
	if ent:IsNPC() == false and ent:IsPlayer() == false and ent:IsNextBot() == false then return end

	table.insert(SYNT_TARGET.entities, ent)
end)

-- function tablelength(T)
-- 	local count = 0
-- 	for _ in pairs(T) do count = count + 1 end
-- 	return count
-- end

hook.Add("Think", "SyntHudTarget", function()
	local MaxPrimary = GetConVar("sv_SyntTarget_Rule_Primary_Max"):GetInt()
	local MaxSecondary = GetConVar("sv_SyntTarget_Rule_Secondary_Max"):GetInt()

	-- for k, ply in pairs(player.GetAll()) do
	-- 	ply:SetNWInt("synt_table_stats", tablelength(SYNT_TARGET.entities))
	-- end

	for k, target in pairs(SYNT_TARGET.entities) do
		if IsValid(target) then
			target:SetNWBool("SYNT_TARGET.Valid",true)
			target:SetNWInt("SYNT_TARGET.HP",target:Health())

			if target.MaxHealth == nil or target:Health() > target.MaxHealth then
				if target:Health() > target:GetMaxHealth() then
					target.MaxHealth = target:Health()
				else
					target.MaxHealth = target:GetMaxHealth()
				end
			end

			target.SyntTarget_PreviousMaxHP = target.SyntTarget_PreviousMaxHP or target:GetMaxHealth()
			
			if target.SyntTarget_PreviousMaxHP ~= target:GetMaxHealth() then
				target.MaxHealth = target:GetMaxHealth()
				target.SyntTarget_PreviousMaxHP = target:GetMaxHealth()
			end

			target:SetNWInt("SYNT_TARGET.MAX_HP",target.MaxHealth)
			target:SetNWInt("SYNT_TARGET.ID",target:EntIndex())

			if target:GetNWInt("SYNT_TARGET.Faction") == 0 then
				if target:IsNPC() then
					target:SetNWString("SYNT_TARGET.Faction", GetTargetFaction(target:GetClass()))
				elseif target:IsPlayer() then
					target:SetNWString("SYNT_TARGET.Faction", "players")
				else
					target:SetNWString("SYNT_TARGET.Faction", "unknown")
				end
			end

			if target:IsNPC() then
				for k, ply in pairs(player.GetAll()) do
					target:SetNWInt("SYNT_TARGET.Relation_"..ply:UniqueID(), target:Disposition(ply))
				end
			end
			
			if target.Armor then
				if (isfunction(target.Armor) and tonumber(target:Armor()) and target:Armor()>0) then
					target:SetNWInt("SYNT_TARGET.AP",target:Armor())
				elseif (tonumber(target.Armor) or 0) > 0 then
					target:SetNWInt("SYNT_TARGET.AP",target.Armor)
				end
			end
		else
			SYNT_TARGET.entities[k] = nil
		end
	end
end)
CreateConVar("sv_SyntTarget_enabled", 1, { FCVAR_REPLICATED,FCVAR_CLIENTCMD_CAN_EXECUTE }, "Allow players to enable target health bars",0,1)
CreateConVar("sv_SyntTarget_rule_primary_max", 3, { FCVAR_REPLICATED,FCVAR_CLIENTCMD_CAN_EXECUTE }, "Highest primary rule the players can set",0,3)
CreateConVar("sv_SyntTarget_rule_secondary_max", 2, { FCVAR_REPLICATED,FCVAR_CLIENTCMD_CAN_EXECUTE }, "Highest secondary rule the players can set",0,2)
CreateConVar("sv_SyntTarget_rule_crosshair", 2, { FCVAR_REPLICATED,FCVAR_CLIENTCMD_CAN_EXECUTE }, "Highest secondary rule the players can set",0,2)

CreateClientConVar("SyntTarget_enabled",1,true,false, "Enable target health",0,1)
CreateClientConVar("SyntTarget_rule_primary",1,true,false, "Target primary rue",0,3) -- 0 = One at time | 1 = Multiple | 2 = Everyone on sight | 3 = Everyone
CreateClientConVar("SyntTarget_rule_secondary",2,true,false, "Target secondary rule for primary rule 2 and 3",0,2) -- 0 = Recently damaged | 1 = Damaged | 2 = Always
CreateClientConVar("SyntTarget_rule_crosshair",0,true,false, "Force target to show on crosshair for secondary 0 and 1",0,1) -- 0 = Recently damaged | 1 = Damaged | 2 = Always
CreateClientConVar("SyntTarget_fade_time", 2, true, false, "Time before the health bar disappear when not aiming at the target",0)
CreateClientConVar("SyntTarget_max_distance", 1000, true, false, "For mode 2: maximum distance to show targat",0)

CreateClientConVar("SyntTarget_custom_shakemult", 1, true, false, "Modify the shake intensity multiplier", 0, 3)
CreateClientConVar("SyntTarget_custom_width", 0, true, false, "Modify the health bar width")
CreateClientConVar("SyntTarget_custom_height", 0, true, false, "Modify the health bar height")
CreateClientConVar("SyntTarget_custom_borders", 0, true, false, "Modify the health bar borders thickness",0)
CreateClientConVar("SyntTarget_custom_elevation", 0, true, false, "Modify the health bar elevation")

CreateClientConVar("SyntTarget_color_option", 0, true, false, "Change colors rule",0,2)
CreateClientConVar("SyntTarget_friendly_players", 0, true, false, "Display health color rule for players", 0, 1)
CreateClientConVar("SyntTarget_friendly_humans", 1, true, false, "Display health color rule for humans", 0, 1)
CreateClientConVar("SyntTarget_friendly_combine", 0, true, false, "Display health color rule for combine", 0, 1)
CreateClientConVar("SyntTarget_friendly_zombies", 0, true, false, "Display health color rule for zombies", 0, 1)
CreateClientConVar("SyntTarget_friendly_ants", 0, true, false, "Display health color rule for antlions", 0, 1)
CreateClientConVar("SyntTarget_friendly_neutral", 1, true, false, "Display health color rule for neutral and animals", 0, 1)


local Targeting = {}
local TargetClasses = {"npc_*", "monster_*"}

-- local NewTargetFade = 0 -- For debug purpose
-- local TargetExtendFade = 0 -- For debug purpose
-- local TargetRemoveFade = 0 -- For debug purpose

-- function tablelength(T) -- For debug purpose
-- 	local count = 0
-- 	for _ in pairs(T) do count = count + 1 end
-- 	return count
-- end


function AddTargetList(ent)
	local RulePrimary = GetConVar("SyntTarget_rule_primary"):GetInt()
	local RuleSecondary = GetConVar("SyntTarget_rule_secondary"):GetInt()
	local SvPrimary = GetConVar("sv_SyntTarget_rule_primary_Max"):GetInt()
	local SvSecondary = GetConVar("sv_SyntTarget_rule_secondary_Max"):GetInt()

	local FadeTime = GetConVar("SyntTarget_fade_time"):GetInt()
	local Index = ent:EntIndex()
	local PlayerPos = LocalPlayer():EyePos()

	if RulePrimary > SvPrimary then
		RulePrimary = SvPrimary
	end

	if RuleSecondary > SvSecondary then
		RuleSecondary = SvSecondary
	end

	if RulePrimary == 0 then
		Index = 0
	end
	
	if not IsValid(Targeting[Index]) or (RulePrimary == 0 and ent:EntIndex() ~= Targeting[Index].Index) then 

		Targeting[Index] = ent
		Targeting[Index].Index = ent:EntIndex()

		Targeting[Index].FadeDelay = CurTime() + FadeTime
		Targeting[Index].Fade = 255
		Targeting[Index].HideDelay = 0
		Targeting[Index].Hidden = 255

		Targeting[Index].LostHealth = 0
		Targeting[Index].HealthDamageValue = 0
		Targeting[Index].HealthDamageDelay = 0
		Targeting[Index].LastDamage = 0
		Targeting[Index].LastHP = 0
		Targeting[Index].LastDamageFreeze = 0
		Targeting[Index].LastDamageFade = 0
		Targeting[Index].LastDamageAnim = 0

		Targeting[Index].TargetShrink = 0
		Targeting[Index].HPNew = 0
		Targeting[Index].ShakeTime = 0
		Targeting[Index].ShakeH = 0
		Targeting[Index].ShakeW = 0

		-- NewTargetFade = 255 -- For debug purpose
	else
		Targeting[Index].FadeDelay = CurTime() + FadeTime
		Targeting[Index].Fade = 255

		-- TargetExtendFade = 255 -- For debug purpose
	end
end

local TargetColors = {
	humans = 	{r=100,	g=167,	b=98},
	combine = 	{r=64,	g=161,	b=214},
	zombies = 	{r=229,	g=45,	b=47},
	ants = 		{r=111,	g=210,	b=6},
	neutral = 	{r=180,	g=180,	b=180},
	unknown = 	{r=229,	g=45,	b=47}
}

local RelationsColors = {}
	RelationsColors[0] = 	{r=229,	g=45,	b=47}
	RelationsColors[1] = 	{r=229,	g=45,	b=47}
	RelationsColors[2] = 	{r=180,	g=180,	b=180}
	RelationsColors[3] = 	{r=100,	g=167,	b=98}
	RelationsColors[4] = 	{r=180,	g=180,	b=180}

hook.Add("HUDPaint","SyntTarget",function()
	local Enabled = GetConVar("SyntTarget_enabled"):GetBool()
	local SvEnabled = GetConVar("sv_SyntTarget_enabled"):GetBool()
	local RulePrimary = GetConVar("SyntTarget_rule_primary"):GetInt()
	local RuleSecondary = GetConVar("SyntTarget_rule_secondary"):GetInt()
	local SvPrimary =GetConVar("sv_SyntTarget_rule_primary_max"):GetInt()
	local SvSecondary = GetConVar("sv_SyntTarget_rule_secondary_max"):GetInt()
	local ForceCrosshair = GetConVar("SyntTarget_rule_crosshair"):GetBool() 
	local SvForceCrosshair = GetConVar("sv_SyntTarget_Rule_crosshair"):GetBool()

	if RulePrimary > SvPrimary then
		RulePrimary = SvPrimary
	end

	if RuleSecondary > SvSecondary then
		RuleSecondary = SvSecondary
	end

	if Enabled == true and SvEnabled == true then
		local PlayerPos = LocalPlayer():EyePos()

		local CurrentTimer = CurTime()
		local ScrRatio = ScrH()/1080

		local CustomWidth = GetConVar("SyntTarget_custom_width"):GetInt()
		local CustomHeight = GetConVar("SyntTarget_custom_height"):GetInt()
		local CustomElevation = GetConVar("SyntTarget_custom_elevation"):GetInt()
		local CustomBorders = GetConVar("SyntTarget_custom_borders"):GetInt()
		local MaxTargetDistance = GetConVar("SyntTarget_max_distance"):GetInt()

		local HpBarLength = 160*ScrRatio+CustomWidth
		local HpBarHeight = 14*ScrRatio+CustomHeight

		local trace = LocalPlayer():GetEyeTrace()
		
		-- Target indexing

		--  Mode 0 or 1: Check if pointing at NPC
		if trace.Hit == true and trace.HitNonWorld == true then
			if trace.Entity:GetNWBool("SYNT_TARGET.Valid") == true and trace.Entity:Health() > 0 then
				AddTargetList(trace.Entity)
			end
		end
		
		if RulePrimary >= 2 then
			-- Mode 2: Check if NPC is valid and in line of sight
			for k, class in ipairs(TargetClasses) do
				for k, v in pairs (ents.FindByClass(class)) do
					if (RulePrimary < 3 and v:GetPos():Distance(PlayerPos) < MaxTargetDistance and v:IsLineOfSightClear(PlayerPos))
					or (RulePrimary >= 3 and v:GetPos():Distance(PlayerPos) < MaxTargetDistance) then
						if v:GetNWBool("SYNT_TARGET.Valid") == true 
						and v:GetNWInt("SYNT_TARGET.HP") > 0 then
							AddTargetList(v)
						end
					end
				end
			end

			for k, v in pairs (player.GetAll()) do

				if (RulePrimary < 3 and v:GetPos():Distance(PlayerPos) < MaxTargetDistance and v:IsLineOfSightClear(PlayerPos))
				or (RulePrimary >= 3 and v:GetPos():Distance(PlayerPos) < MaxTargetDistance) then
					if v:GetNWBool("SYNT_TARGET.Valid") == true 
					and v ~= LocalPlayer() 
					and v:GetNWInt("SYNT_TARGET.HP") > 0 then
						AddTargetList(v)
					end
				end
			end

		end

		-- Target health drawing
		for k, target in pairs(Targeting) do

			-- Remove target from index if faded out or not longer valid
			if not IsValid(target) or target.Fade < 10 then 
				Targeting[k] = nil 
				-- TargetRemoveFade = 255 -- For debug purpose
			else
				local TargetHP = math.max(target:GetNWInt("SYNT_TARGET.HP"), 0)
				local TargetMaxHP = target:GetNWInt("SYNT_TARGET.MAX_HP")
				local TargetID = target:GetNWInt("SYNT_TARGET.ID")
				local TargetDistance = LocalPlayer():GetPos():Distance(target:GetPos())
				local FadeTime = GetConVar("SyntTarget_fade_time"):GetInt()



				-- Hide undamaged targets
					if RulePrimary >= 2 then
						if (RuleSecondary == 0 and CurTime() > target.HideDelay)
						or (RuleSecondary == 1 and TargetHP >= TargetMaxHP and CurTime() > target.HideDelay) then
							target.Hidden = math.Clamp(target.Hidden+RealFrameTime()*500, 0, 255)
						else
							target.Hidden = 0
						end
					else
						target.Hidden = 0
					end

					if ForceCrosshair == true and SvForceCrosshair == true then
						if trace.Hit == true and trace.HitNonWorld == true and trace.Entity == target then
							target.HideDelay = CurTime() + FadeTime
							target.Hidden = 0
						end
					end

					-- if (RuleSecondary == 1 and TargetHP < TargetMaxHP) then
					-- 	target.Hidden = 255
					-- end

				-- Fade out the bar
					if TargetHP <= 0 
					or CurTime() > target.FadeDelay
					or target:IsLineOfSightClear(PlayerPos) == false 
					or RulePrimary == 0 and k ~= 0 
					or RulePrimary ~= 0 and k == 0 then
						target.Fade = math.Clamp(target.Fade-RealFrameTime()*500, 0, 255)
					else
						target.Fade = 255
					end

				-- Getting position from player's screen
					local drawpos = target:GetPos()
					drawpos.z = drawpos.z + target:OBBMaxs().z + 10 + CustomElevation

					local data2D = drawpos:ToScreen()

				-- Shrink bar when NPC die
					if TargetHP <= 0 then 
						target.TargetShrink = math.min(target.TargetShrink+RealFrameTime()*50, HpBarHeight)
					else
						target.TargetShrink = 0
					end

				-- Lost Health transition
					local LostHpVelocity = math.max((target.LostHealth-TargetHP)*2,1)
					
					if (TargetHP and target.LostHealth) then
						if (target.LostHealth > TargetHP) then
							target.LostHealth = target.LostHealth-RealFrameTime()*LostHpVelocity
							if (target.LostHealth < TargetHP) then
								target.LostHealth = TargetHP  
							end
						elseif (target.LostHealth < TargetHP) then
							target.LostHealth = TargetHP
						end
					end

					if target.LostHealth > TargetHP then
						target.Hidden = 0
						target.HideDelay = CurTime() + FadeTime
					end

				-- Last inflicted damage overlap

					if target.LostHpFreeze == 0 then
						target.LastDamageFade = math.Clamp(target.LastDamageFade-RealFrameTime()*500,0,255)
					end

					if target.HealthDamageDelay < CurTime() then
						target.LostHpFreeze = 0
					end
					
				
					if target.HealthDamageValue > TargetHP then
						target.LostHpFreeze = 1
						target.LastDamage = target.HealthDamageValue
						target.HealthDamageValue = TargetHP
						target.HealthDamageDelay = CurTime()+0.4
						target.LastDamageFade = 255
						target.LastDamageAnim = 0
					end

					if target.HealthDamageValue <= TargetHP then
						target.HealthDamageValue = TargetHP
					end

					local LastDamageAnimSpeed = math.max((2.5-target.LastDamageAnim)*4,1)

					if target.LastDamageFade > 0 and TargetHP > 0 then
						target.LastDamageAnim = target.LastDamageAnim + RealFrameTime()*LastDamageAnimSpeed
					end

				-- Bar shaking
					local ShakeMult = GetConVar("SyntTarget_custom_shakemult"):GetInt()

					if (TargetHP < target.HPNew) then
						if CurTime() > target.ShakeTime then
							target.ShakeTime = CurTime()+(math.max(((target.HPNew-TargetHP)/200)*ShakeMult,0.02))
						else
							target.ShakeTime = target.ShakeTime+(math.max(((target.HPNew-TargetHP)/200)*ShakeMult,0.02))
						end
					end

					target.ShakeTime = math.min(target.ShakeTime, CurTime()+1)

					target.HPNew = TargetHP

					target.ShakeH = math.Rand(-400*ScrRatio,400*ScrRatio) * math.min(CurTime() - target.ShakeTime,0)
					target.ShakeW = math.Rand(-400*ScrRatio,400*ScrRatio) * math.min(CurTime() - target.ShakeTime,0)

				-- Setting bar coordinate
					local TargetBarX = data2D.x - (HpBarLength/2) + target.ShakeW
					local TargetBarY = data2D.y - math.Clamp(TargetDistance/15, 0, 30) + target.ShakeH


				-- Calculating lenghts 
					local HpLength = TargetHP/TargetMaxHP*HpBarLength
					local LostHpStart = TargetBarX+TargetHP/TargetMaxHP*HpBarLength
					local LostHpLength = (target.LostHealth-TargetHP)/TargetMaxHP*HpBarLength
					local LastDamageLength = (target.LastDamage-TargetHP)/TargetMaxHP*HpBarLength
					local LastDamageAnim = math.sin(target.LastDamageAnim)*10

				-- Setting bar color
					local TargetR = 229
					local TargetG = 45
					local TargetB = 47

					local TargetFaction = target:GetNWString("SYNT_TARGET.Faction")
					local TargetRules = {
						players = 	GetConVar("SyntTarget_friendly_players"):GetBool(),
						humans = 	GetConVar("SyntTarget_friendly_humans"):GetBool(),
						combine = 	GetConVar("SyntTarget_friendly_combine"):GetBool(),
						zombies = 	GetConVar("SyntTarget_friendly_zombies"):GetBool(),
						ants = 		GetConVar("SyntTarget_friendly_ants"):GetBool(),
						neutral = 	GetConVar("SyntTarget_friendly_neutral"):GetBool()
					}

					if GetConVar("SyntTarget_color_option"):GetInt() == 0 then
						if TargetRules[TargetFaction] == true then
							TargetR = 100
							TargetG = 167
							TargetB = 98
						end
					elseif GetConVar("SyntTarget_color_option"):GetInt() == 1 then
						if TargetFaction == "players" then
							if TargetRules[TargetFaction] == true then
								TargetR = 100
								TargetG = 167
								TargetB = 98
							end
						else
							TargetR = TargetColors[TargetFaction].r
							TargetG = TargetColors[TargetFaction].g
							TargetB = TargetColors[TargetFaction].b
						end
					else
						local relation = target:GetNWInt("SYNT_TARGET.Relation_"..LocalPlayer():UniqueID())

						TargetR = RelationsColors[relation].r
						TargetG = RelationsColors[relation].g
						TargetB = RelationsColors[relation].b
					end

				-- HpBackground drawing
					surface.SetDrawColor( 30, 30, 30, math.max(target.Fade-target.Hidden-30,0))
						surface.DrawRect(TargetBarX-CustomBorders,TargetBarY-CustomBorders-CustomHeight,HpBarLength+(CustomBorders*2),HpBarHeight+(CustomBorders*2)-target.TargetShrink)

				-- HpBar drawing
					surface.SetDrawColor( TargetR, TargetG, TargetB, target.Fade-target.Hidden)
						surface.DrawRect(TargetBarX,TargetBarY-CustomHeight,HpLength,HpBarHeight-target.TargetShrink) 

				-- LostHealth drawing
					surface.SetDrawColor( 222, 166, 50, target.Fade-target.Hidden)
						 surface.DrawRect(LostHpStart-1,TargetBarY-CustomHeight,LostHpLength,HpBarHeight-target.TargetShrink)
				
				-- Last damage
					surface.SetDrawColor( 222, 166, 50, math.min(target.Fade-target.Hidden,target.LastDamageFade))
						surface.DrawRect(LostHpStart-1,TargetBarY-CustomHeight,LastDamageLength,HpBarHeight-target.TargetShrink)				

				-- Last damage animation
					surface.SetDrawColor( 222, 166, 50, math.min(target.Fade-target.Hidden,(target.LastDamageFade)/4))
						surface.DrawRect(LostHpStart-1,TargetBarY-CustomHeight-(LastDamageAnim*2),LastDamageLength+(LastDamageAnim*2),HpBarHeight-target.TargetShrink+(LastDamageAnim*4))				

					-- draw.SimpleText(TargetHP..'/'..TargetMaxHP, "Font Bars", TargetBarX, TargetBarY+10, Color(TargetR, TargetG, TargetB, target.Fade-target.Hidden), 0, 0)
			end

		end

		-- For debug purpose

		-- NewTargetFade = math.Clamp(NewTargetFade-RealFrameTime()*250, 0, 255)
		-- TargetExtendFade = math.Clamp(TargetExtendFade-RealFrameTime()*250, 0, 255)
		-- TargetRemoveFade = math.Clamp(TargetRemoveFade-RealFrameTime()*250, 0, 255)

		-- draw.SimpleText("New target", "Font Ammo", 20, ScrH()-170, Color(255, 255, 255, NewTargetFade), 0, 0)
		-- draw.SimpleText("Target extend", "Font Ammo", 20, ScrH()-140, Color(255, 255, 255, TargetExtendFade), 0, 0)
		-- draw.SimpleText("Target removed", "Font Ammo", 20, ScrH()-110, Color(255, 255, 255, TargetRemoveFade), 0, 0)
		-- draw.SimpleText("Targets indexed by client/sv: "..tablelength(Targeting).."/"..LocalPlayer():GetNWInt("synt_table_stats"), "Font Ammo", 20, ScrH()-80, Color(255, 255, 255, AmmoAlpha), 0, 0)
	-- END of target health drawing
	end
end)

-- Menu panel
	hook.Add("PopulateToolMenu", "SynthetikTargetMenu", function()

		spawnmenu.AddToolMenuOption("Options", "Synthetik Hud", "Synthetik Target settings", "Synthetik Target settings", "", "", SyntTargetMenuPanel)
		spawnmenu.AddToolMenuOption("Options", "Synthetik Hud", "Synthetik Target colors", "Synthetik Target colors", "", "", SyntTargetColorsPanel)
		-- spawnmenu.AddToolMenuOption("Options", "Synthetik Hud", "Synthetik Target admin settings", "Synthetik Target admin settings", "", "", SyntTargetAdminPanel)

	end)

	function SyntTargetMenuPanel (dform)
		dform:CheckBox("Enable target bars", "SyntTarget_enabled")
		dform:NumSlider("Fade delay", "SyntTarget_fade_time", 0, 10, 0):SetHeight(16)

		local cbox = dform:ComboBox("Primary rule", "SyntTarget_rule_primary")
		cbox:AddChoice("0 - Only one at time on crosshair", "0")
		cbox:AddChoice("1 - Multiple at time on crosshair", "1")
		cbox:AddChoice("2 - Everyone on sight", "2")
		cbox:AddChoice("3 - Everyone, even behind walls", "3")

		local cbox = dform:ComboBox("Secondary rule", "SyntTarget_rule_secondary")
		cbox:AddChoice("0 - Only recently damaged", "0")
		cbox:AddChoice("1 - Only damaged", "1")
		cbox:AddChoice("2 - Everyone", "2")

		dform:ControlHelp("The secondary rule is complementary of the primary rule 2 and 3.")
		dform:CheckBox("Aiming on target bypass the secondary rule", "SyntTarget_rule_crosshair")
		
		dform:NumSlider("Minimum distance", "SyntTarget_max_distance", 0, 10000, 0):SetHeight(16)
		dform:ControlHelp("For primary mode 2 and 3.")

		dform:NumSlider("Shake intensity multiplier", "SyntTarget_custom_shakemult", 0, 3, 2):SetHeight(16)
		dform:NumSlider("Custom width", "SyntTarget_custom_width", -120, 200, 0):SetHeight(16)
		dform:NumSlider("Custom height", "SyntTarget_custom_height", -10, 20, 0):SetHeight(16)
		dform:NumSlider("Custom borders", "SyntTarget_custom_borders", 0, 4, 0):SetHeight(16)
		dform:NumSlider("Custom elevation", "SyntTarget_custom_elevation", -10, 50, 0):SetHeight(16)
		dform:ControlHelp("Those four option above are relative to the default state, set them to 0 to reset to default.")
	end

	function SyntTargetColorsPanel(dform)
		local cbox = dform:ComboBox("Bars colors rule", "SyntTarget_color_option")
		cbox:AddChoice("0 - Friendly/enemy", "0")
		cbox:AddChoice("1 - factions colors", "1")
		cbox:AddChoice("2 - Automatic detection", "2")

		dform:CheckBox("Color Players as friendly", "SyntTarget_friendly_players")
		dform:CheckBox("Color Resistance as friendly", "SyntTarget_friendly_humans")
		dform:CheckBox("Color Combine as friendly", "SyntTarget_friendly_combine")
		dform:CheckBox("Color Zombies as friendly", "SyntTarget_friendly_zombies")
		dform:CheckBox("Color Antlions as friendly", "SyntTarget_friendly_ants")
		dform:CheckBox("Color neutrals as friendly", "SyntTarget_friendly_neutral")
	end

	-- Sv CVARS doesn't work for now
	
	-- function SyntTargetAdminPanel (dform)
	-- 	dform:CheckBox("Allow players to enable target healths", "sv_SyntTarget_enabled")
	-- 	local cbox = dform:ComboBox("Max primary rule allowed", "sv_SyntTarget_Rule_Primary_Max")
	-- 	cbox:AddChoice("0 - Only one at time on crosshair", "0")
	-- 	cbox:AddChoice("1 - Multiple at time on crosshair", "1")
	-- 	cbox:AddChoice("2 - Everyone on sight", "2")
	-- 	cbox:AddChoice("3 - Everyone, even behind walls", "3")
	-- 	local cbox2 = dform:ComboBox("Max secondary rule allowed", "sv_SyntTarget_Rule_Secondary_Max")
	-- 	cbox2:AddChoice("0 - Only recently damaged", "0")
	-- 	cbox2:AddChoice("1 - Only damaged", "1")
	-- 	cbox2:AddChoice("2 - Everyone", "2")
	-- end
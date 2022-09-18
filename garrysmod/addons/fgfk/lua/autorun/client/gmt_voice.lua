surface.CreateFont( "GTowerHudCSubText", { font = "default", size = 18, weight = 700, } )
local PlayerVoicePanels = {}
local PANEL = {}
PANEL.Margin = 2
PANEL.Padding = 6
PANEL.WaveyColor = Color(255, 255, 255, 255)
PANEL.Font = "GTowerHudCSubText"
local utf8pattern = "[%z\1-\127\194-\244][\128-\191]*"

local function WaveyText(text, font, x, y, colour, xalign, yalign, amplitude, wavelength, frequency)
    font = font or "DermaDefault"
    x = x or 0
    y = y or 0
    xalign = xalign or TEXT_ALIGN_LEFT
    yalign = yalign or TEXT_ALIGN_TOP
    amplitude = amplitude or 20
    wavelength = wavelength or 40
    frequency = frequency or 1
    local w, h = 0, 0
    surface.SetFont(font)

    if (xalign == TEXT_ALIGN_CENTER) then
        w, h = surface.GetTextSize(text)
        x = x - w / 2
    elseif (xalign == TEXT_ALIGN_RIGHT) then
        w, h = surface.GetTextSize(text)
        x = x - w
    end

    if (yalign == TEXT_ALIGN_CENTER) then
        w, h = surface.GetTextSize(text)
        y = y - h / 2
    elseif (yalign == TEXT_ALIGN_BOTTOM) then
        w, h = surface.GetTextSize(text)
        y = y - h
    end

    surface.SetTextPos(math.ceil(x), math.ceil(y))
    local angfreq = 2 * math.pi * frequency
    local k = 2 * math.pi / wavelength
    local alpha = colour and (colour.a or 255) or 255
    local charoffset = 0
    shiftamt = shiftamt or 10 --math.max(math.ceil(360 / nchars), 10)
    local charidx = 1

    for char in text:gmatch(utf8pattern) do
        -- y(x,t) = A * sin(wt - kx + phi)
        local yoffset = amplitude * math.sin(angfreq * RealTime() - k * charidx)
        surface.SetTextPos(math.ceil(x + charoffset), math.ceil(y + yoffset))
        surface.SetTextColor(colour.r, colour.g, colour.b, alpha)
        surface.DrawText(char)
        charoffset = charoffset + surface.GetTextSize(char)
        charidx = charidx + 1
    end

    return w, h
end

local function Rainbow(speed, offset, saturation, value)
    return HSVToColor((RealTime() * (speed or 50) % 360) + (offset or 0), saturation or 1, value or 1)
end

function PANEL:Init()
    self.Avatar = vgui.Create("AvatarImage", self)
    self.Avatar:SetSize(32, 32)
    self.Avatar:SetPos(self.Padding / 2, self.Padding / 2)
    self.Color = color_transparent
    self:SetSize(250, 32 + self.Padding)
    self:DockPadding(0, 0, 0, 0)
    self:Dock(BOTTOM)
end

function PANEL:Setup(ply)
    self.ply = ply
    self.Avatar:SetPlayer(ply)
    self.Color = Color(255, 0, 0)
    self:InvalidateLayout()
end

function PANEL:Paint(w, h)
    if (not IsValid(self.ply)) then return end
    local nick = self.ply:Name()
    surface.SetFont(self.Font)
    local tw = surface.GetTextSize(nick)
    local halfheight = h / 2
    local volume = self.ply:VoiceVolume()
    local freq = 2 * volume
    local rainbow = Rainbow(20 + volume * 30)
    rainbow.r = rainbow.r * volume
    rainbow.g = rainbow.g * volume
    rainbow.b = rainbow.b * volume
    rainbow.a = 200
    w = 32 + 8 * 2 + tw
    local color = self.ply:GetPlayerColor() * 255
    color = Color(math.Clamp(color.r, 30, 180), math.Clamp(color.g, 30, 180), math.Clamp(color.b, 30, 180), 50)
    draw.RoundedBox(4, 0, 0, w, h, color)
    draw.RoundedBox(4, 0, 0, w, h, rainbow)
    local x = 32 + 10
    WaveyText(nick, self.Font, x, halfheight, self.WaveyColor, nil, TEXT_ALIGN_CENTER, volume * 10, 10, freq)
end

function PANEL:Think()
    if (self.fadeAnim) then
        self.fadeAnim:Run()
    end
end

function PANEL:FadeOut(anim, delta, data)
    if (anim.Finished) then
        if (IsValid(PlayerVoicePanels[self.ply])) then
            PlayerVoicePanels[self.ply]:Remove()
            PlayerVoicePanels[self.ply] = nil

            return
        end

        return
    end

    self:SetAlpha(255 - (255 * delta))
end

derma.DefineControl("GMTVoiceNotify", "", PANEL, "DPanel")

hook.Add("PlayerStartVoice", "GMT_StartVoice", function(ply)
    if (not IsValid(VoicePanelList)) then return end
    -- There'd be an exta one if voice_loopback is on, so remove it.
    gamemode.Call("PlayerEndVoice", ply)

    if (IsValid(PlayerVoicePanels[ply])) then
        if (PlayerVoicePanels[ply].fadeAnim) then
            PlayerVoicePanels[ply].fadeAnim:Stop()
            PlayerVoicePanels[ply].fadeAnim = nil
        end

        PlayerVoicePanels[ply]:SetAlpha(255)

        return
    end

    if (not IsValid(ply)) then return end
    local pnl = VoicePanelList:Add("GMTVoiceNotify")
    pnl:Setup(ply)
    PlayerVoicePanels[ply] = pnl
end)

local function VoiceClean()
    for k, v in pairs(PlayerVoicePanels) do
        if (not IsValid(k)) then
            gamemode.Call("PlayerEndVoice", k)
        end
    end
end

timer.Create("VoiceClean", 10, 0, VoiceClean)

hook.Add("PlayerEndVoice", "GMT_EndVoice", function(ply)
    if (IsValid(PlayerVoicePanels[ply])) then
        if (PlayerVoicePanels[ply].fadeAnim) then return end
        PlayerVoicePanels[ply].fadeAnim = Derma_Anim("FadeOut", PlayerVoicePanels[ply], PlayerVoicePanels[ply].FadeOut)
        PlayerVoicePanels[ply].fadeAnim:Start(2)
    end
end)

local function CreateVoiceVGUI()
    if IsValid(g_VoicePanelList) then
        g_VoicePanelList:Remove()
    end

    VoicePanelList = vgui.Create("DPanel")
    VoicePanelList:ParentToHUD()
    VoicePanelList:SetPos(ScrW() - 300, 100)
    VoicePanelList:SetSize(250, ScrH() - 200)
    VoicePanelList:SetPaintBackground(false)
end

hook.Add("InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI)

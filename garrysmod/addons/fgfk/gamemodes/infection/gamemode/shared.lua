 
GM.Name = "Infection"
GM.Author = "zeropoint"
GM.Email = "wegj1@hotmail.com"
GM.Website = "https://github.com/Banabyte/Family-Guy-FatKid"
GM.variant = LoadInfectionGamemode or "fgfk"
--Start by loading base gamemode
LoadFolder(GM.FolderName .. "/gamemode/game")
LoadEntityFolder(GM.FolderName .. "/gamemode/entities")

--Load selected game variant (if it doesn't exist, nothing happens)
if GM.variant ~= "base" then
    LoadFolder(GM.variant .. "/gamemode/game")
    LoadEntityFolder(GM.variant .. "/gamemode/entities")
    --Look for map-configs for the loaded game variant
    local _, maps = file.Find(GM.variant .. "/gamemode/maps/*", "LUA")
    --In case multiple folders match, sort so that the most specific names load last
    table.sort(maps, function(a, b) return string.len(a) < string.len(b) end)

    for k, v in next, maps do
        if string.find(game.GetMap():lower(), v) then
            LoadFolder(GM.variant .. "/gamemode/maps/" .. v)
        end
    end
end

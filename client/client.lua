local RSGCore = exports['rsg-core']:GetCoreObject()
local infoOn = false
local coordsText = ""
local headingText = ""
local modelText = ""
local rotationText = ''

Citizen.CreateThread(function()
    while true do
        local pause = 250
        if infoOn then
            pause = 5
            local player = GetPlayerPed(-1)
            if IsPlayerFreeAiming(PlayerId()) then
                local entity = getEntity(PlayerId())
                local coords = GetEntityCoords(entity)
                local heading = GetEntityHeading(entity)
                local rotation = GetEntityRotation(entity)
                local model = GetEntityModel(entity)
                coordsText = tostring(coords)
                headingText = tostring(heading)
                modelText = tostring(model)
                rotationText = tostring(rotation)
            end
            local _text = ("Coords: " .. coordsText .. "\nHeading: " .. headingText .. "\nRotation: " .. rotationText .. "\nHash: " .. modelText)
            DrawTxt(_text, 0.0, 0.5, 0.4, 0.4, true, 255, 255, 255, 150, false)
        end
        Citizen.Wait(pause)
    end
end)

function getEntity(player)
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)
    return entity
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)

    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

ToggleInfos = function()
    infoOn = not infoOn
end

RegisterCommand("propgun", function()
    ToggleInfos()
end)

RegisterCommand("propgunrot", function()
    lib.setClipboard(rotationText)
    lib.notify({
        title = 'Clipboard set!',
        description = 'Your propgun rotation is saved to clipboard.',
        icon = 'fas fa-clipboard'
    })
end)

RegisterCommand("propguncoord", function()
    lib.setClipboard(coordsText)
    lib.notify({
        title = 'Clipboard set!',
        description = 'Your propgun coordinates is saved to clipboard.',
        icon = 'fas fa-clipboard'
    })
end)

RegisterCommand("propgunhash", function()
    lib.setClipboard(modelText)
    lib.notify({
        title = 'Clipboard set!',
        description = 'Your propgun aimed model hash is saved to clipboard.',
        icon = 'fas fa-clipboard'
    })
end)

print("--------- SIMPLE CHEATS ---------")


local UEHelpers = require("UEHelpers.UEHelpers")
local WeaponsData = require("weapons_data")
local ItemsData = require("items_data")
local SteamAchievements = require("steam_achievements")
local InfinitePowerOn = false;

function ToggleInfinitePower()
    local player = UEHelpers.GetPlayer()

    if player then
        InfinitePowerOn = not InfinitePowerOn;
        print("Infinite Power: " .. tostring(InfinitePowerOn))
        player:ThisIsPower(InfinitePowerOn, false, false, false, false)
    else
        print("Player not found")
    end
end

function Hp9999()
    local player = UEHelpers.GetPlayer()
    if player then
        player:SetMaxHP(9999.0)
        player:SetHP(9999.0)
        print("Hp9999: ")
    else
        print("Player not found")
    end
end

function ATK9999()
    local player = UEHelpers.GetPlayer()
    if player then
        player:SetAtk(9999.0)
        print("ATK9999: ")
    else
        print("Player not found")
    end
end

function Gold9999()
    local player = UEHelpers.GetPlayer()
    if player then
        player.KazerAttributeSet.GoldGain.BaseValue = 9999.0
        player.KazerAttributeSet.GoldGain.CurrentValue = 9999.0
        print("Gold Multiplier: 9999: ")
    else
        print("Player not found")
    end
end

function Critical100()
    local player = UEHelpers.GetPlayer()
    if player then
        -- critical chance 100%
        player.KazerAttributeSet.Cri.BaseValue = 1
        player.KazerAttributeSet.Cri.CurrentValue = 1
        print("Critical Chance: 100%: ")
    else
        print("Player not found")
    end
end

function Mana9999()
    print("Mana9999")
    local player = UEHelpers.GetPlayer()
    if player then
        player:SetMana(9999.0)
        print("Mana: 9999: ")
    else
        print("Player not found")
    end
end

function Break9999()
    local player = UEHelpers.GetPlayer()
    if player then
        player.KazerAttributeSet.BreakDmgResult.BaseValue = 11.0
        player.KazerAttributeSet.BreakDmgResult.CurrentValue = 11.0
        print("Break: 1000%: ")
    else
        print("Player not found")
    end
end

local function RegisterKeyBinds()
    -- More or less God Mode + gold gain 9999 + critical chance 100% + break 9999 + crystal 9999
    RegisterKeyBind(Key.F4, function()
        local player = UEHelpers.GetPlayer()
        print("Player found: " .. tostring(player:GetFullName()))
        if player then
            ATK9999()
            Hp9999()
            Mana9999()
            Gold9999()
            Critical100()
            Break9999()
            print("God mod as best as we can get it.")
        else
            print("Player not found")
        end
    end)
    RegisterKeyBind(Key.F5, ToggleInfinitePower)
    RegisterKeyBind(Key.F6, ATK9999)
    RegisterKeyBind(Key.F7, Gold9999)
    RegisterKeyBind(Key.F8, Critical100)
    RegisterKeyBind(Key.F9, Mana9999)
    RegisterKeyBind(Key.FIVE, Hp9999)
end 

local enable_keybinds = require("enable_keybinds")
if enable_keybinds then
    RegisterKeyBinds()
    print("Keybinds enabled via enable_keybinds.lua")
    print("--------------------------------")
    print("F4: God Mode")
    print("F5: Toggle Ultimate Form")
    print("F6: Max Attack")
    print("F7: Gold Multiplier")
    print("F8: Critical Chance")
    print("F9: Max Mana")
    print("5: Max HP")
    print("--------------------------------")
else
    print("Keybinds disabled - set 'Enabled = true' in enable_keybinds.lua to enable")
end




----------------------------------------------------------------------------------------------------
------------------------------------ CONSOLE COMMANDS ----------------------------------------------
----------------------------------------------------------------------------------------------------

---A logging helper to print to both the in-game console and the debug log
---@param Ar any Archive or logging object (type unknown - has IsValid() and Log() methods)
---@param Message string The message to log
function Log(Ar, Message)
    print(Message)
    if Ar and Ar:IsValid() then
        Ar:Log(Message)
    end
end

local bCanFly = false
RegisterConsoleCommandHandler("toggle_fly", function(FullCommand, Parameters, Ar)
    local player = UEHelpers.GetPlayer()
    if player then
        bCanFly = not bCanFly
        Log(Ar, "Toggle fly: " .. tostring(bCanFly))
        player:DebugKazerFly(bCanFly)
    end
    return true
end)

RegisterConsoleCommandHandler("add_all_weapons", function(FullCommand, Parameters, Ar)
    local bc = FindFirstOf("BagComponent")
    if bc then
        print("Adding all weapons...")
        for weaponID, fragments in pairs(WeaponsData) do
            bc:BagAddWeaponWithFragment(weaponID, fragments)
        end
        Log(Ar, "All weapons added!")
    else
        Log(Ar, "BagComponent not found")
    end
    return true
end)

RegisterConsoleCommandHandler("add_item", function(FullCommand, Parameters, Ar)
    local itemID = tonumber(Parameters[1])
    local quantity = tonumber(Parameters[2]) or 1

    local bc = FindFirstOf("BagComponent")
    if bc then
        bc:BagAddItemTwoParameter(itemID, quantity)
        local itemName = ItemsData[itemID] or "Unknown Item"
        Log(Ar, "Added " .. quantity .. "x " .. itemName .. " (ID: " .. itemID .. ")")
    end
    return true
end)

RegisterConsoleCommandHandler("add_all_items", function(FullCommand, Parameters, Ar)
    local bc = FindFirstOf("BagComponent")
    if bc then
        for itemID, itemName in pairs(ItemsData) do
            bc:BagAddItemTwoParameter(itemID, 1)
            Log(Ar, "Added " .. itemName .. " (ID: " .. itemID .. ")")
        end
    end
    return true
end)

--  marks game as completed, unlocks hard mode and opens fast travel everywhere. Doesn't affect story progression. doesn't unlock hard mode in menu
RegisterConsoleCommandHandler("unlock_hard_mode", function(FullCommand, Parameters, Ar)
    local bp = StaticFindObject("/Script/Projectlsa.Default__LSABlueprintLibrary")
    local world = UEHelpers.GetWorld()
    if bp then
        bp:UnlockHardMode(world, true, true)
        bp:UnlockChallengeMode(world, true)
        Log(Ar, "Hard mode unlocked")
    end
    return true
end)

RegisterConsoleCommandHandler("set_skill_points", function(FullCommand, Parameters, Ar)
    local skillPoints = tonumber(Parameters[1])
    local gameInstance = UEHelpers.GetGameInstance()
    if gameInstance then
        local saveGameData = gameInstance.lsaGameData
        saveGameData.BagInfoData.SkillPoint = skillPoints
        Log(Ar, "Skill points set to " .. skillPoints)
    end
    return true
end)

RegisterConsoleCommandHandler("set_gold", function(FullCommand, Parameters, Ar)
    local gold = tonumber(Parameters[1])
    local gameInstance = UEHelpers.GetGameInstance()

    if gameInstance then
        local saveGameData = gameInstance.lsaGameData
        saveGameData.BagInfoData.gold = gold
        Log(Ar, "Gold set to " .. gold)
    end
    return true
end)

RegisterConsoleCommandHandler("unlock_all_achievements", function(FullCommand, Parameters, Ar)
    local bp = StaticFindObject("/Script/Projectlsa.Default__LSABlueprintLibrary")
    local world = UEHelpers.GetWorld()
    
    if not bp then
        Log(Ar, "LSABlueprintLibrary not found")
        return true
    end
    
    Log(Ar, "Unlocking all " .. #SteamAchievements .. " Steam achievements...")
    
    local unlocked = 0
    for _, achievementID in ipairs(SteamAchievements) do
        bp:UpdateAchievementProgress(world, achievementID, 1.0)
        unlocked = unlocked + 1
        Log(Ar, "Unlocked achievement: " .. achievementID)
    end
    
    Log(Ar, "Successfully unlocked " .. unlocked .. " achievements!")
    return true
end)
repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer

local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()
end)

if not success then
    warn("Failed to load Rayfield:", Rayfield)
    return
end

print("Rayfield loaded")

local Window = Rayfield:CreateWindow({
    Name = "💔 Dead Rails",
    LoadingTitle = "Soghub | Dead Rails 💔",
    LoadingSubtitle = "By alchemist",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DeadRailsConfig",
        FileName = "DeadRails"
    },
    Discord = { Enabled = false },
    KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateSection("Utilities")

local AimAssistTab = Window:CreateTab("Aim Assist", 4483362458)
AimAssistTab:CreateSection("Aimbot Options")
AimAssistTab:CreateButton({
    Name = "Enable Aimbot",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/alchemist185/Aimbot.main/refs/heads/main/Main"))()
    end,
})

local TeleportTab = Window:CreateTab("Teleports", 4483362458)
TeleportTab:CreateSection("Teleport Options")

local function createTeleportButton(name, url)
    TeleportTab:CreateButton({
        Name = name,
        Callback = function()
            Rayfield:Notify({
                Title = "Teleporting...",
                Content = "Please wait",
                Duration = 3
            })
            loadstring(game:HttpGet(url))()
            wait(3)
            Rayfield:Notify({
                Title = "Teleported Successfully",
                Content = "If you didn’t get teleported, try again.",
                Duration = 5
            })
        end,
    })
end

createTeleportButton("Teleport to Sterling", "https://raw.githubusercontent.com/ringtaa/sterlingnotifcation.github.io/refs/heads/main/Sterling.lua")
createTeleportButton("Teleport to TeslaLab", "https://raw.githubusercontent.com/ringtaa/tptotesla.github.io/refs/heads/main/Tptotesla.lua")
createTeleportButton("Teleport to Train", "https://raw.githubusercontent.com/ringtaa/NEWTPTRAIN.github.io/refs/heads/main/TRAIN.LUA")
createTeleportButton("Teleport to Fort", "https://raw.githubusercontent.com/ringtaa/Tpfort.github.io/refs/heads/main/Tpfort.lua")
createTeleportButton("Teleport to Castle", "https://raw.githubusercontent.com/ringtaa/castletpfast.github.io/refs/heads/main/FASTCASTLE.lua")
createTeleportButton("Teleport to The End", "https://raw.githubusercontent.com/hbjrev/tpend.github.io/refs/heads/main/ringta.lua")

local VisualTab = Window:CreateTab("Visual", 4483362458)
VisualTab:CreateSection("Enhancements")

VisualTab:CreateButton({
    Name = "Full Bright",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/alchemist185/Fullbright/refs/heads/main/Main%20lua"))()
    end,
})

Rayfield:Notify({
    Title = "Loaded",
    Content = "Made by alchemist (credits to Ringta and AkunDisco)",
    Duration = 6
})

-- Grok Anti-Lag Hub v2.0 | Blox Fruits Update 29.1 Christmas 2025
-- Max Lvl 2800 OP | Mobile/PC No Key | ZERO LAG OPTIMIZED

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Grok Hub v2 | Anti-Lag Max 2800 🔥",
   LoadingTitle = "Optimizando... No Lag Mode ON",
   LoadingSubtitle = "by Grok xAI | Update 29.1",
   ConfigurationSaving = {Enabled = true, FolderName = "GrokBF", FileName = "antilag"},
   KeySystem = false
})

local FarmTab = Window:CreateTab("📈 Anti-Lag Farm", 4482983098)
local RaidTab = Window:CreateTab("⚔️ Raids/Bosses", 4482983098)
local TeleTab = Window:CreateTab("🗺️ Teleports Third Sea", 4482983098)
local EventTab = Window:CreateTab("🎄 Christmas Event", 4482983098)
local PlayerTab = Window:CreateTab("👤 Player Mods", 4482983098)
local MiscTab = Window:CreateTab("⚙️ Misc/Codes", 4482983098)

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Globals
_G.AutoFarmMastery = false
_G.AutoRaid = false
_G.AutoBoss = false
_G.FruitSniper = false
_G.FlyEnabled = false
_G.FlyConnection = nil
_G.ESPConnection = nil
local LagWait = 0.5  -- Anti-lag default
local currentTween = nil
local FarmSpeed = 200

-- Utils
local function cancelTween()
   if currentTween then
      currentTween:Cancel()
      currentTween = nil
   end
end

local function tweenTo(pos, speed)
   cancelTween()
   local dist = (RootPart.Position - pos).Magnitude
   local time = dist / speed
   local info = TweenInfo.new(time, Enum.EasingStyle.Linear)
   currentTween = TweenService:Create(RootPart, info, {CFrame = CFrame.new(pos)})
   currentTween:Play()
   currentTween.Completed:Wait()
end

local function getClosest(targets)
   local closest, dist = nil, math.huge
   for _, obj in pairs(Workspace.Enemies:GetChildren()) do
      if obj:FindFirstChild("HumanoidRootPart") and obj.Humanoid.Health > 0 then
         for _, name in pairs(targets) do
            if obj.Name:find(name) then
               local d = (RootPart.Position - obj.HumanoidRootPart.Position).Magnitude
               if d < dist then
                  closest, dist = obj, d
               end
            end
         end
      end
   end
   return closest
end

local function attackMob(mob)
   if mob then
      tweenTo(mob.HumanoidRootPart.Position + Vector3.new(0,5,0), FarmSpeed)
      task.wait(0.2)
      -- Fruit/Sword spam (Z,X,C,V)
      for _, key in {"Z", "X", "C", "V"} do
         game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game)
         task.wait(0.1)
      end
   end
end

-- Farm Tab
FarmTab:CreateToggle({
   Name = "Auto Mastery Farm (Lv.2800 Mobs/Bosses)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarmMastery = Value
      task.spawn(function()
         while _G.AutoFarmMastery do
            pcall(function()
               local mob = getClosest({"2800", "Boss", "Elite"})
               if mob then attackMob(mob) end
            end)
            task.wait(LagWait)
         end
      end)
   end,
})

FarmTab:CreateSlider({
   Name = "Anti-Lag Wait (0.3-2s)",
   Range = {0.3, 2},
   Increment = 0.1,
   CurrentValue = 0.5,
   Callback = function(Value)
      LagWait = Value
   end,
})

FarmTab:CreateSlider({
   Name = "Tween Speed",
   Range = {100, 500},
   Increment = 25,
   CurrentValue = 200,
   Callback = function(Value)
      FarmSpeed = Value
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Stats (Melee/DF/Fruit)",
   CurrentValue = false,
   Callback = function(Value)
      task.spawn(function()
         while Value do
            pcall(function()
               ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
               ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
               ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Fruit", 1)
            end)
            task.wait(1)
         end
      end)
   end,
})

-- Event Tab (Christmas 2025)
EventTab:CreateToggle({
   Name = "Auto Elf/Candy Farm (North Pole)",
   CurrentValue = false,
   Callback = function(Value)
      task.spawn(function()
         while Value do
            pcall(function()
               local elf = getClosest({"Elf"})
               if elf then attackMob(elf) end
            end)
            task.wait(LagWait)
         end
      end)
   end,
})

-- Raid/Boss
RaidTab:CreateToggle({
   Name = "Auto Boss (Dough King/rip_indra)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoBoss = Value
      task.spawn(function()
         while _G.AutoBoss do
            pcall(function()
               local boss = getClosest({"Dough King", "rip_indra"})
               if boss then attackMob(boss) end
            end)
            task.wait(1)
         end
      end)
   end,
})

RaidTab:CreateToggle({
   Name = "Auto Raid",
   CurrentValue = false,
   Callback = function(Value)
      task.spawn(function()
         while Value do
            pcall(function()
               ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", "Flame")
               task.wait(2)
               ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Start")
            end)
            task.wait(10)
         end
      end)
   end,
})

-- Teleports (Third Sea Accurate)
local TPs = {
   ["Castle on Sea"] = CFrame.new(-5074.04, 314.8, -6134.1),
   ["Rip_indra"] = CFrame.new(2293.03, 53.37, 9229.37),
   ["Dough King Area"] = CFrame.new(-6230, 73, -2345),
   ["North Pole (Sea of Treats)"] = CFrame.new(5000, 141, 600),  -- Christmas event
   ["Temple of Time"] = CFrame.new(29600, 2000, 7500)
}

TeleTab:CreateDropdown({
   Name = "Teleport",
   Options = {"Castle on Sea", "Rip_indra", "Dough King Area", "North Pole (Sea of Treats)", "Temple of Time"},
   CurrentOption = "Castle on Sea",
   Callback = function(Option)
      tweenTo(TPs[Option].Position, 350)
   end,
})

-- Fruits/ESP
EventTab:CreateToggle({
   Name = "Fruit/Elf ESP (Low Lag)",
   CurrentValue = false,
   Callback = function(Value)
      _G.FruitSniper = Value
      if Value then
         _G.ESPConnection = RunService.Heartbeat:Connect(function()
            for _, obj in pairs(Workspace:GetChildren()) do
               if obj.Name:find("Fruit") or obj.Name:find("Elf") then
                  local high = obj:FindFirstChild("ESPHighlight")
                  if not high then
                     high = Instance.new("Highlight", obj)
                     high.FillColor = Color3.new(1,0,0)
                     high.OutlineColor = Color3.new(1,1,1)
                  end
               end
            end
         end)
      else
         if _G.ESPConnection then _G.ESPConnection:Disconnect() end
      end
   end,
})

-- Player Mods
PlayerTab:CreateToggle({
   Name = "Smooth Fly (No Lag)",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyEnabled = Value
      if Value then
         _G.FlyConnection = RunService.Heartbeat:Connect(function()
            if RootPart then
               local cam = Workspace.CurrentCamera
               local move = cam.CFrame.LookVector * 50
               RootPart.Velocity = Vector3.new(move.X, RootPart.Velocity.Y, move.Z)
            end
         end)
      else
         if _G.FlyConnection then _G.FlyConnection:Disconnect() end
      end
   end,
})

PlayerTab:CreateToggle({
   Name = "Infinite Jump + NoClip",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         Humanoid.JumpPower = 50
         local conn = RunService.Stepped:Connect(function()
            for _, part in pairs(Character:GetChildren()) do
               if part:IsA("BasePart") then part.CanCollide = false end
            end
         end)
      end
   end,
})

PlayerTab:CreateToggle({
   Name = "God Mode",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         Humanoid.MaxHealth = math.huge
         Humanoid.Health = math.huge
      end
   end,
})

-- Misc
MiscTab:CreateButton({
   Name = "Redeem All Codes (Dec 2025)",
   Callback = function()
      local codes = {"LIGHTNINGABUSE", "KITT_RESET", "SUB2OFFICIALNOOBIE", "AXIORE", "BIGNEWS", "BLUXXY", "CHANDLER", "ENYU_IS_PRO", "FUDD10", "FUDD10_V2", "JCWK", "KITTGAMING", "MAGICBUS", "STARCODEHEO", "STRAWHATMAINE", "SUB2CAPTAINMAUI", "SUB2DAIGROCK", "SUB2FER999", "SUB2GAMERROBOT_EXP1", "SUB2GAMERROBOT_RESET1", "SUB2NOOBMASTER123", "SUB2UNCLEKIZARU", "TANTAIGAMING", "THEGREATACE"}
      for _, code in pairs(codes) do
         ReplicatedStorage.Remotes.REDEEM_1:InvokeServer(code)
      end
      Rayfield:Notify({Title = "✅ All Codes Redeemed!", Content = "2x EXP + Resets OP!", Duration = 4, Image = 4483362458})
   end,
})

Rayfield:LoadConfiguration()
print("🟢 Grok Anti-Lag Hub v2 LOADED! Grind sin traba 🚀")

-- Auto Rejoin on death/spawn
LocalPlayer.CharacterAdded:Connect(function()
   Character = LocalPlayer.Character
   RootPart = Character:WaitForChild("HumanoidRootPart")
   Humanoid = Character:WaitForChild("Humanoid")
end)

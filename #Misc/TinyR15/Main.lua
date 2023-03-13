--//Player Setup
if not game:IsLoaded() then game.Loaded:wait() end;
local Players = game:GetService("Players")

local LP = Players.LocalPlayer
local LPChar = LP.Character or LP.CharacterAdded:Wait()

--//Functions
local function RemoveScale()
    pcall(function()
        for _, BodyPart in pairs(LPChar:GetDescendants()) do
            
            if not BodyPart:IsA("BasePart") then continue end
            if BodyPart.Name == "Head" then continue end
            
            for _, Prop in pairs(BodyPart:GetDescendants()) do
                if not Prop:IsA("Attachment") then continue end
                if Prop:FindFirstChild("OriginalPosition") then
                    Prop.OriginalPosition:Destroy()
                end
            end
            
            BodyPart:FindFirstChild("OriginalSize"):Destroy()
            
            if BodyPart:FindFirstChild("AvatarPartScaleType") then
                BodyPart:FindFirstChild("AvatarPartScaleType"):Destroy()
            end
            
        end
    end)
end

function TinyR15()
    if LPHum and Enum.RigType == Enum.RigType.R15 then
        for _, PropScale in pairs(ToRemove) do
            RemoveScale()
            LPHum:FindFirstChild(PropScale[1]):Destroy()
            task.wait(PropScale[2])
        end
    end
end

--//Script
if LPChar then
    LPHum = LPChar:WaitForChild("Humanoid")
    TinyR15()
end

if AlwaysOn then
    LP.CharacterAdded:Connect(function(NewChar)
        LPChar = NewChar
        LPHum = NewChar:WaitForChild("Humanoid")
        TinyR15()
    end)
end

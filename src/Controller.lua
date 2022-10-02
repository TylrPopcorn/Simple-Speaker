task.wait(2) --breathe.
--Created by Billy. (TylrPopcorn)
--2021.
--[[

	The purpose of this is to simulate a speaker FX
]]
local MODEL = script.Parent --The whole model.
local SPEAKER = MODEL.Speaker --The speaker itself.

local bumper = SPEAKER.BassBumper --The part moving.
local TweenService = game:GetService("TweenService") --Used for smooth transitions.
local lightFX = SPEAKER.LightFX
local goal = {}

local MUSIC = "rbxassetid://9048045656" --The music that will play out of the speaker.
------------
goal.Size = Vector3.new(bumper.Size.X, bumper.Size.Y, bumper.Size.Z)

for nam,obj in pairs(lightFX:GetChildren()) do  --Loop through the LIGHTFX model and get the childern.
	if obj:GetAttribute("Active") == nil then
		obj:SetAttribute('Active', false) --Give the child an attrbte if the child does NOT have one already.
	end

	--Each time the attrbte gets changed:
	obj:GetAttributeChangedSignal("Active"):Connect(function() --"OnChanged" function.
		local getAtty = obj:GetAttribute("Active") --Get the main attrribute that is needed.

		if getAtty == true then --If the value is set to true
			local transparency = 1

			--Get the children of the current child.
			for nam2,obj2 in pairs(obj:GetChildren()) do
				obj2.Transparency = 1 --Make the child of the child invisible.
			end
			--

			--Slowly fade in:
			while transparency > 0.6 do --While loop
				task.wait(0.02)
				--Get the children of the curernt child:
				for nam2,obj2 in pairs(obj:GetChildren()) do
					obj2.Transparency = obj2.Transparency - 0.1 --Make that child slowly fade in so the player can see it
				end

				transparency = transparency - 0.1 --Update the variable keeping track

				if transparency <=0.6 then --If we have reached the end point
					break; --break the loop.
				end
			end

			transparency = 0 --update.

			--Loop:
			while transparency < 1 do
				task.wait(0.06)
				--Get the children of the current child:
				for nam2,obj2 in pairs(obj:GetChildren()) do  
					obj2.Transparency = obj2.Transparency + 0.1 --Make that child slowly fade away so the player cannot see it.
				end

				transparency = transparency + 0.1 --Update the variable keeping track

				if transparency >= 1 then --Once we have reached our end point,
					break; --Break the loop and continue onward.
				end
			end

			obj:SetAttribute("Active", false) --Set the value of the attribute back to false so that we can restat when needed.
		end
	end)
end

--Begin:
if bumper:FindFirstChild("MUSIC") == nil then --IF there is not already a sound found inside the speakerr then
	--Create a new sound to be used
	local newMusic = Instance.new("Sound")
	newMusic.Name = "MUSIC"
	newMusic.Loaded = true
	newMusic.SoundId = MUSIC --Set the sound ID to the music to be played.
	newMusic.RollOffMaxDistance = 800
	newMusic.Volume = 0.5
	newMusic.Parent = bumper --Give the sound to the speaker
end
bumper.Music:Play() --

--Infinite loop:
while true do
	task.wait(0.48) --wait / breathe.

	local numbChosen = math.random(1,2) --choose a  random number

	if numbChosen == 2 then --if the numbeer is "2"
		--		if bumper.Music.PlaybackLoudness < 170 then
		bumper.Size = Vector3.new(bumper.Size.X,bumper.Music.PlaybackLoudness*0.004,bumper.Size.Z) --make the bumper bump 
		wait()	
		local tween = TweenService:Create(bumper, TweenInfo.new(0.175), goal) --Create a smooth transition
		tween:Play() --Allow the bumper to smoothly go back to original size (effect)

		numbChosen = math.random(1,2) --choose another random number
		if numbChosen == 2 then --IF the number is "2" again
			--Get the children of the lights
			for i = 1, #lightFX:GetChildren() do
				if lightFX:FindFirstChild("RingLight"..i) ~= nil then
					if lightFX["RingLight"..i]:GetAttribute("Active") ~= nil then  --IF the child has the corresponding attribute from earlier then
						if lightFX["RingLight"..i]:GetAttribute("Active") == false then --IF the child light is not already active then
							lightFX["RingLight"..i]:SetAttribute("Active", true) --Make it shine. (EFFECT)
						end
					end
				end
				task.wait(0.2) --Breathe and move to the next item.
			end
		end
		--	end	
	end	

end

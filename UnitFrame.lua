-- from SuperClassic UnitFrames and somg code from whoaUnitFrame
local path ="Interface\\Addons\\MySuperClassic\\texture\\"
local custombg = path.."pHishTex34" 	--姓名背景材质
local custombar = path.."pHishTex31"	--血条材质
local hpfont = 12	--血量文字大小
local ppfont = 9	--能量文字大小

--bar texture
hooksecurefunc(getmetatable(PlayerFrameHealthBar).__index, "Show", function(bar, ...)
        if bar:GetParent().healthbar then
            if bar.styled == nil then
                bar:SetStatusBarTexture(custombar)
                bar:GetStatusBarTexture():SetHorizTile(true)
                bar.styled = true
            end
        end
    end)
-- player frame
local function UpdatePlayerFrame()
	if not UnitHasVehicleUI("player") then
		PlayerFrameTexture:SetTexture(path.."UI-TargetingFrame")
		
		PlayerFrameHealthBar:SetHeight(16)
		PlayerFrameManaBar:ClearAllPoints()
		PlayerFrameManaBar:SetPoint("TOPLEFT", 106, -58)
		PlayerFrameManaBar:SetHeight(4)
	else
		PlayerFrameHealthBar:SetHeight(12)
        PlayerFrameManaBar:SetHeight(12)
	end
	
	PlayerFrameTexture:SetTexture(path.."UI-TargetingFrame-Elite")
end

hooksecurefunc("PlayerFrame_UpdateArt", UpdatePlayerFrame)
PlayerFrame:HookScript("OnEvent", function(self, event)
        if event=="PLAYER_ENTERING_WORLD" then
            UpdatePlayerFrame()
        end
    end)
		
--target frame
do
	TargetFrame.nameBackground:SetTexture(custombg)     --姓名背景素材
	TargetFrameHealthBar:SetHeight(14)
	TargetFrameManaBar:ClearAllPoints()
	TargetFrameManaBar:SetPoint("TOPLEFT", 5, -58)
	TargetFrameManaBar:SetHeight(4)
end

local function SC_TargetFrame_CheckClassification(self, forceNormalTexture)    --目标头像素材.(代码来自iTiny的iStyle)
	local texture
	local classification = UnitClassification(self.unit)
	if classification == "worldboss" or classification == "elite" then     --精英的素材
		texture = path.."UI-TargetingFrame-Elite"
	elseif classification == "rareelite" then                              --稀有精英
		texture = path.."UI-TargetingFrame-Rare-Elite"
	elseif classification == "rare" then                                   --稀有
		texture = path.."UI-TargetingFrame-Rare"
	elseif classification == "normal" then
		texture = path.."UI-TargetingFrame"				--正常的
	end
	--[[if texture and not forceNormalTexture then
		self.borderTexture:SetTexture(texture)
	else
		self.borderTexture:SetTexture(path.."UI-TargetingFrame")           --正常的
	end]]
	if texture then self.borderTexture:SetTexture(texture) end
end
hooksecurefunc("TargetFrame_CheckClassification", SC_TargetFrame_CheckClassification)


---------------------------------------------------
-- FOCUS
--------------------------------------------------- 
do
	FocusFrame.nameBackground:SetTexture(custombg)
	FocusFrameHealthBar:SetHeight(16)
	FocusFrameManaBar:ClearAllPoints()
	FocusFrameManaBar:SetPoint("TOPLEFT", 5, -58)
	FocusFrameManaBar:SetHeight(4)
end
---------------------------------------------------
-- class color
---------------------------------------------------
local colour = function(bar, unit)
	if unit and unit == bar.unit then
		local t = { r=0, g=1, b=0 }
		
		if (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
			t = { r=.6, g=.6, b=.6}
		elseif (not UnitIsConnected(unit)) then
			t = { r=.6, g=.6, b=.6}
		elseif(UnitIsUnit(unit, "pet")) then
			local happiness = {
			 [1] = {r=1, g=0, b=0}, -- need.... | unhappy
			 [2] = {r=1, g=1, b=0}, -- new..... | content
			 [3] = {r=0, g=1, b=0}, -- colors.. | happy
			}
			t = { r=0, g=1, b=0 }
		elseif UnitIsPlayer(unit) then
			local _, class = UnitClass(unit)
			t = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class] or  { r=0, g=1, b=0 }
		elseif UnitReaction(unit, "player") then
			t = FACTION_BAR_COLORS and FACTION_BAR_COLORS[UnitReaction(unit, "player")] or { r=0, g=1, b=0 }
		else
			t = {r=0, g=1, b=0}
		end
		
		bar:SetStatusBarColor(t.r, t.g, t.b)
	end
end

hooksecurefunc("UnitFrameHealthBar_Update", colour)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
   colour(self, self.unit)
end)
---------------------------------------------------
-- value and percent
---------------------------------------------------
local oldtextlist = {
		PlayerFrameHealthBarText,
		PlayerFrameManaBarText,
		
		--TargetFrameTextureFrameHealthBarText,
		--TargetFrameTextureFrameManaBarText,
		
		FocusFrameTextureFrameHealthBarText,
		FocusFrameTextureFrameManaBarText,
		}
local hideoldtext = function()
	for i,v in pairs(oldtextlist) do
		v:SetText()
	end
end

local function fixvalue(val)
	if(val >= 1e6) then
		return ('%.2fm'):format(val / 1e6):gsub('%.?0+([km])$', '%1')
	elseif(val >= 1e4) then
		return ('%.1fk'):format(val / 1e3):gsub('%.?0+([km])$', '%1')
	else
		return val
	end
end

local newtextlist = {
		player = { 
				healthpercent = {parent = PlayerFrameHealthBar, anchor = "RIGHT"},
				healthvalue = {parent = PlayerFrameHealthBar,anchor = "LEFT"},
				manavalue = {parent = PlayerFrameManaBar,anchor = "LEFT"},
				},
		target = {
				healthpercent = {parent = TargetFrameHealthBar,anchor = "LEFT"},
				healthvalue = {parent = TargetFrameHealthBar,anchor = "RIGHT"},
				manavalue = {parent = TargetFrameManaBar,anchor = "RIGHT"},
				},
		focus = {
				healthpercent = {parent = FocusFrameHealthBar,anchor = "RIGHT"},
				healthvalue = {parent = FocusFrameHealthBar,anchor = "LEFT"},
				manavalue = {parent = FocusFrameManaBar,anchor = "LEFT"},
				},
		}

for unit,elements in pairs(newtextlist) do
	for k, opts in pairs(elements) do
		local fontsize = hpfont
		local textname = unit..k
		local offsetX = 5
		local offsetY = 0
		if k == 'manavalue' then fontsize = ppfont offsetY = -4 end
		if opts.anchor == "RIGHT" then offsetX = -5  end
		
		if opts.text == nil then 
			local f = CreateFrame("Frame",nil,opts.parent)
			f:SetFrameLevel(10)
			local text = f:CreateFontString(name, "OVERLAY")
			text:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
			--text:SetJustifyH(opts.anchor)
			text:SetPoint(opts.anchor,opts.parent,opts.anchor,offsetX,offsetY)  
			opts.text = text
		end
	end
end

local UpDateText = function()
	hideoldtext()
	
	for unit, elements in pairs(newtextlist) do
		for k,opts in pairs(elements) do
			local Minvalue, Maxvalue = opts.parent:GetMinMaxValues()
			local value = opts.parent:GetValue()
			if k == 'healthpercent' then
				if GetCVarBool("statusTextPercentage") and value~=Maxvalue and value>0 then
					local per = math.floor((value / Maxvalue) * 100)
					opts.text:Show()
					opts.text:SetText(per.."%")
				else
					opts.text:Hide()
				end
			elseif k == 'healthvalue' then
				if(UnitIsDead(unit)) then
					opts.text:SetText(' ')
				elseif (UnitIsGhost(unit)) then
					opts.text:SetText('灵魂')
				elseif not UnitIsConnected(unit) then
					opts.text:SetText('掉线')
				elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
					opts.text:SetText('被攻击')
				else
					opts.text:SetText(fixvalue(value))
				end
			elseif k == 'manavalue' then
				if unit== 'tagert' and not UnitIsConnected(unit) or Maxvalue == 0 or value == 0  then
					opts.text:SetText()
				elseif (UnitIsDead(unit) or UnitIsGhost(unit)) then
					opts.text:SetText()
				else	
					opts.text:SetText(fixvalue(value))
				end
			end
		end
	end
end

hooksecurefunc("TextStatusBar_Initialize",  UpDateText)
hooksecurefunc("TextStatusBar_OnEvent",  UpDateText)
hooksecurefunc("TextStatusBar_UpdateTextString",  UpDateText)
hooksecurefunc("TextStatusBar_OnValueChanged",  UpDateText)
hooksecurefunc("HideTextStatusBarText",  UpDateText)
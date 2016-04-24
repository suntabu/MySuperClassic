local config = {
	buttonsize = 32,         -- Buff Size	图标尺寸
	spacing = 4,             -- Buff Spacing	图标间距
	buffsperrow = 14,        -- Buffs Per Row BUFF每行显示个数
	debuffsperrow = 7,        -- DEBuffs Per Row DEBUFF每行显示个数
	debuffsgrowright = true,	--DEBUFF 往右生长
	buffsgrowright = false,		--buff往右生长
	}
------------------------------------------
local font = STANDARD_TEXT_FONT		--字体
local fontcolor = {255/255, 207/255, 164/255,1}	--文字颜色

-- Default Spawn Positions默认的位置
local positions = {
    [1]  =  { p = "TOPRIGHT",   a = UIParent, p1 = "TOPRIGHT",  x = -30,    y = -30  },  -- Buff Anchor
    [2]  =  { p = "BOTTOMLEFT",   a = PlayerFrame, p1 = "TOPLEFT",  x = 30,    y = -12  },  -- Debuff Anchor
    [3]  =  { p = "TOPRIGHT",   a = UIParent, p1 = "BOTTOMRIGHT",  x = -20,    y = 200  },  -- Enchant Anchor武器附魔
}
--End Config

local function anchor(frame, r, g, b, pos1, anchor,pos2, x, y)
    frame:SetBackdrop({bgFile = 'Interface\\Buttons\\WHITE8x8'})
    frame:SetBackdropColor(r, g, b, 0.4)
    frame:SetHeight(config.buttonsize)
    frame:SetWidth(config.buttonsize)
    frame:SetPoint(pos1, anchor, pos2, x, y)
    frame:SetFrameStrata("BACKGROUND")
    frame:SetClampedToScreen(true)
    frame:SetAlpha(0)
end

local buffholder = CreateFrame("Frame", "Buffs", UIParent)
anchor(buffholder, 0, 1, 0, positions[1].p, positions[1].a,positions[1].p1, positions[1].x, positions[1].y)
local debuffholder = CreateFrame("Frame", "Debuffs", UIParent)
anchor(debuffholder, 1, 0, 0, positions[2].p, positions[2].a,positions[2].p1, positions[2].x, positions[2].y)
local enchantholder = CreateFrame("Frame", "TempEnchants", UIParent)
anchor(enchantholder, 0, 0, 1, positions[3].p, positions[3].a,positions[3].p1, positions[3].x, positions[3].y)



local function makeitgrow(button, index, anchor,debuff,growright)
    _G[button..index]:ClearAllPoints()
	local grow,pernum
	if growright then grow = 1 else grow = -1 end
	if debuff then pernum = config.debuffsperrow else pernum = config.buffsperrow end
	
	if index == 1 then
		_G[button..index]:SetPoint("TOPRIGHT",anchor,0,0)
	elseif index == pernum + 1 then
		_G[button..index]:SetPoint("TOP",_G[button..(index-pernum)],"BOTTOM",0,-config.spacing)
	elseif index == pernum*2 + 1 then
		_G[button..index]:SetPoint("TOP",_G[button..(index-pernum)],"BOTTOM",0,-config.spacing)
	elseif index == pernum*3 + 1 then
		_G[button..index]:SetPoint("TOP",_G[button..(index-pernum)],"BOTTOM",0,-config.spacing)
	elseif index == pernum*4 + 1 then
		_G[button..index]:SetPoint("TOP",_G[button..(index-pernum)],"BOTTOM",0,-config.spacing)
	elseif index == pernum*5 + 1 then
		_G[button..index]:SetPoint("TOP",_G[button..(index-pernum)],"BOTTOM",0,-config.spacing)
	elseif index == pernum*6 + 1 then
		_G[button..index]:SetPoint("TOP",_G[button..(index-pernum)],"BOTTOM",0,-config.spacing)
	else
		_G[button..index]:SetPoint("CENTER", _G[button..(index-1)],"CENTER",(config.buttonsize+config.spacing)*grow, 0)
	end
end

local function StyleBuffs(b,button, index, framekind, anchor,debuff,growright)	
		local buff = button..index
	
	if b then
		if not b.skin then
	    _G[buff.."Icon"]:SetDrawLayer("BACKGROUND",-8)
		_G[buff]:ClearAllPoints()
		_G[buff]:SetHeight(config.buttonsize)
		_G[buff]:SetWidth(config.buttonsize)
		
		if framekind == 2 then _G[buff]:SetBackdropColor(.7,0,0,1)
		elseif framekind == 3 then _G[buff]:SetBackdropColor(0,0,.5,1)
		else _G[buff]:SetBackdropColor(0,0,0,1) end
		
		_G[buff.."Count"]:SetFont(font, 11, "OUTLINE")
		_G[buff.."Count"]:SetTextColor(unpack(fontcolor))
		_G[buff.."Duration"]:SetFont(font, 11, "OUTLINE")
		
		_G[buff.."Count"]:ClearAllPoints()
		_G[buff.."Count"]:SetPoint("TOPRIGHT", 2, 0)
		_G[buff.."Count"]:SetDrawLayer("OVERLAY")
		
		_G[buff.."Duration"]:ClearAllPoints()
		_G[buff.."Duration"]:SetPoint("BOTTOM")
		_G[buff.."Duration"]:SetDrawLayer("OVERLAY")

		b.skin = true	
		end
	end
		
		makeitgrow(button, index, anchor,debuff,growright)
end

local function UpdateBuff()
    for i = 1, BUFF_ACTUAL_DISPLAY do
        local b = _G["BuffButton"..i]
		if b then
			StyleBuffs(b,"BuffButton", i, 1, buffholder,false,config.buffsgrowright)
		end
    end
    for i = 1, BuffFrame.numEnchants do
        local b = _G["TempEnchant"..i]
		if b then
			StyleBuffs(b,"TempEnchant", i, 3, enchantholder,false,config.buffsgrowright)
		end
    end
end
local function UpdateDebuff(buttonName, index)
	local b = _G[buttonName..index]
	if b then
		StyleBuffs(b,buttonName, index, 2, debuffholder,true,config.debuffsgrowright)
	end
end

local function updateTime(button, timeLeft)
	local duration = _G[button:GetName().."Duration"]
	if SHOW_BUFF_DURATIONS == "1" and timeLeft then
		duration:SetTextColor(unpack(fontcolor))
		local d, h, m, s = ChatFrame_TimeBreakDown(timeLeft);
		if d > 0 then
			duration:SetFormattedText("%1dd", d)
		elseif h > 0 then
			duration:SetFormattedText("%1dh", h)
		elseif m > 0 then
			duration:SetFormattedText("%1dm", m)
		else
			duration:SetFormattedText("%1d", s)
		end
	end
end

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuff)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuff)
hooksecurefunc("AuraButton_UpdateDuration", updateTime)
SetCVar("consolidateBuffs", 0)
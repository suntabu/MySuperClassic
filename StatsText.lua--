local cfg={
	color = {255/255, 207/255, 164/255},--默认颜色
	classcolor = true,	--使用职业染色
	font = STANDARD_TEXT_FONT,	--"Fonts\\ARIALN.ttf" 字体
	fontstyle = nil,	--"THINOUTLINE", "OUTLINE MONOCHROME", "OUTLINE" or nil (no outline)字体样式
	font_s = 14,	--小字体大小
	font_m = 20,	--位置文字字体大小
	font_l = 60,	--时间文字字体大小
	scale = 0.9,	--整体的缩放
	}
local r,g,b=unpack(cfg.color)
if cfg.classcolor then 
	local color=RAID_CLASS_COLORS[select(2, UnitClass("player"))] 
	r,g,b=color.r,color.g,color.b
end

local DataFrame = CreateFrame("Frame","DataFrame",UIParent)
DataFrame:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
DataFrame:RegisterEvent('PLAYER_LOGIN')
DataFrame:SetFrameStrata("LOW")
DataFrame:SetSize(146,62)
DataFrame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",300,-30)	--位置
DataFrame:SetScale(cfg.scale)
-- local blankTex = "Interface\\Buttons\\WHITE8x8"
-- local backdrop2 = {bgFile = blankTex}
-- DataFrame:SetBackdrop(backdrop2)

local Frames = {fps = {},latency={},durability = {},memory={},thetime = {},zone = {},}
local Texts = {fps,latency,durability,memory,thetime,zone}
local Data = {fps,latency,durability,memory,thetime,zone}
--postion
local Postion={
				fps = {"TOPLEFT",DataFrame,"TOPLEFT",0,-13},
				latency={"TOPLEFT",DataFrame,"TOPLEFT",0,0},
				durability = {"TOPLEFT",DataFrame,"TOPLEFT",0,-26},
				memory={"BOTTOMRIGHT",DataFrame,"BOTTOMRIGHT",0,0},
				thetime = {"TOPRIGHT",DataFrame,"TOPRIGHT",0,0},
				zone = {"BOTTOMLEFT",DataFrame,"BOTTOMLEFT",0,0},
				}				
--==	elements fuctions	==--
-- time
local thetime_onClick = function(self, button)
	if button == 'RightButton'  then
		ToggleTimeManager()
	else
		GameTimeFrame:Click()
	end
end
-- durability
local durabilityval=function()
	local durability,n=0,0
	for i = 1,20 do
		if GetInventoryItemDurability(i) ~= nil then
			local dur, max = GetInventoryItemDurability(i)
			local percent = dur / max * 100
			durability = durability + percent
			n = n+1
		end		
	end
	durability = floor(durability/n)
	return durability
end

local durability_onEnter = function()
	local total, equipped = GetAverageItemLevel()
	GameTooltip:SetOwner(Frames.durability, "ANCHOR_BOTTOMLEFT",-5,0)
	GameTooltip:SetText(DURABILITY," ",0.5, 02, 0.7)
	GameTooltip:AddLine("\n")
	for  i = 1,20 do
		if GetInventoryItemDurability(i) ~= nil then
            local dur, max = GetInventoryItemDurability(i)
            local percent = dur / max * 100
            if i == 1 then
                GameTooltip:AddDoubleLine("头部:", floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            elseif i == 3 then
                GameTooltip:AddDoubleLine("肩部:", floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            elseif i == 5 then
                GameTooltip:AddDoubleLine("胸部:", floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            elseif i == 9 then
                GameTooltip:AddDoubleLine("手腕:", floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            elseif i == 10 then
                GameTooltip:AddDoubleLine("手:", floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            elseif i == 6 then
                GameTooltip:AddDoubleLine("腰部:", floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            elseif i == 7 then
                GameTooltip:AddDoubleLine("腿部:" ,floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            elseif i == 8 then
                GameTooltip:AddDoubleLine("脚:" ,floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            elseif i == 16 then
                GameTooltip:AddDoubleLine("主手:" ,floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            elseif i == 17 then
                GameTooltip:AddDoubleLine("副手:",floor(percent).."%", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
            end
        end
	end
	GameTooltip:Show()
end

-- zone
local zone_onClick = function(self, button, down)
	WorldMapFrame:Show()
end
--memory 
local memoryval=function(val)
	return format(format("%%.%df %s",dec or 1,val > 1024 and "MB" or "KB"),val/(val > 1024 and 1024 or 1))
end

local memory_onClick = function()
	UpdateAddOnMemoryUsage()
    local before = gcinfo()
    collectgarbage()
    UpdateAddOnMemoryUsage()
    local after = gcinfo()
    print("Cleaned: "..memoryval(before-after))
end
local memory_onEnter = function()
	GameTooltip:SetOwner(Frames.memory, "ANCHOR_BOTTOMRIGHT",0,-5)
	local total, addons, all_mem = 0, {}, collectgarbage("count")
   collectgarbage()
    UpdateAddOnMemoryUsage()  
    for i=1, GetNumAddOns(), 1 do  
      if (GetAddOnMemoryUsage(i) > 0 ) then
        memory = GetAddOnMemoryUsage(i)  
        entry = {name=GetAddOnInfo(i), memory = memory}
        table.insert(addons, entry)  
        total = total + memory  
      end
    end  
    table.sort(addons, function(a, b) return a.memory > b.memory end)  
	GameTooltip:AddDoubleLine("插件内存占用", "\n", 0.5, 02, 0.7, 0.7, 0.7, 0.2)
    i = 0  
    for _, entry in pairs(addons) do  
		GameTooltip:AddDoubleLine(entry.name, memoryval(entry.memory), 0.5, 02, 0.7, 0.7, 0.7, 0.2)
        i = i + 1  
        if i >= 50 then  break  end  
    end  
    GameTooltip:AddLine("\n")
	GameTooltip:AddDoubleLine("插件", memoryval(total), 0.5, 02, 0.7, 0.7, 0.7, 0.2)
	GameTooltip:AddDoubleLine("系统", memoryval(all_mem-total), 0.5, 02, 0.7, 0.7, 0.7, 0.2)
	GameTooltip:AddDoubleLine("总占用", memoryval(all_mem), 0.5, 02, 0.7, 0.7, 0.7, 0.2)
    if not UnitAffectingCombat("player") then GameTooltip:Show() end
end

-----------------------------------

local function CreateElements()
	for k,v in pairs(Frames,Texts,Data,Postion) do
		Frames[k]=CreateFrame("Frame","Data_"..k.."_Frame",DataFrame)
		Frames[k]:SetFrameStrata("LOW")
		-- enableMouse
		Frames[k]:EnableMouse(true)
		if Frames[k] == Frames.thetime then
			Frames[k]:SetScript("OnMouseDown",thetime_onClick)
		elseif Frames[k] == Frames.durability then
			Frames[k]:SetScript("OnEnter",durability_onEnter)
		elseif Frames[k] == Frames.zone then
			Frames[k]:SetScript("OnMouseDown", zone_onClick)
		elseif Frames[k] == Frames.memory then
			Frames[k]:SetScript("OnMouseDown", memory_onClick)
			Frames[k]:SetScript("OnEnter", memory_onEnter)
		end
		Frames[k]:SetScript('OnLeave', function() GameTooltip:Hide() end)
		--size
		if Frames[k] == Frames.thetime then
			Frames[k]:SetSize(90,39)
		elseif Frames[k] == Frames.zone then
			Frames[k]:SetSize(90,23)
		else
			Frames[k]:SetSize(53,13)
		end
		--point
		Frames[k]:SetPoint(unpack(Postion[k]))
		
		--text
		Texts[k] = Frames[k]:CreateFontString(nil,"OVERLAY")
		if Texts[k] == Texts.thetime then
			Texts[k]:SetFont(cfg.font, cfg.font_l , cfg.fontstyle)
			Texts[k]:SetJustifyH("LEFT")
			Texts[k]:SetPoint("LEFT",Frames[k],"LEFT",3,0)
		elseif Texts[k] == Texts.zone then
			Texts[k]:SetFont(cfg.font, cfg.font_m , cfg.fontstyle)
			Texts[k]:SetJustifyH("RIGHT")	
			Texts[k]:SetPoint("RIGHT",Frames[k],"RIGHT",-3,0)			
		else
			Texts[k]:SetFont(cfg.font, cfg.font_s , cfg.fontstyle)
			Texts[k]:SetJustifyH("RIGHT")
			Texts[k]:SetPoint("RIGHT",Frames[k],"RIGHT",-3,0)
		end
		Texts[k]:SetText(Data[k])
		Texts[k]:SetTextColor(r,g,b)
		Texts[k]:SetShadowOffset(1, -1)
	end
end

local function GetData()
	Data.fps = GetFramerate()
	Data.fps = floor(Data.fps).." fps"
	
	Data.latency = select(3, GetNetStats())
	Data.latency = Data.latency.." ms"
	
	Data.durability = durabilityval().."%"
	Data.memory = memoryval(collectgarbage("count"))
	
	Data.thetime = date("%H:%M")
	
	Data.zone = GetMinimapZoneText()
end

local function Output()
	for k,v in pairs(Frames,Texts,Data) do
        Texts[k]:SetText(Data[k])
    end
end
-- local function onUpdate(self, elapsed)
 
    -- local ag = self:CreateAnimationGroup()
    -- ag.anim = ag:CreateAnimation()
    -- ag.anim:SetDuration(1)
    -- ag:SetLooping("REPEAT")
    -- ag:SetScript("OnLoop", function(self, event, ...)
      -- GetData()
	  -- Output()
    -- end)
    -- ag:Play()
  
-- end

function DataFrame:PLAYER_LOGIN()
	CreateElements() 
end

DataFrame:SetScript("OnUpdate", function(self, elapsed)
        if self.lt== nil then self.lt=0 end
        self.lt = self.lt + elapsed
        if self.lt > 1 then
            GetData()
			Output()
            self.lt=0
        end
    end)

--DataFrame:SetScript("OnUpdate", onUpdate)

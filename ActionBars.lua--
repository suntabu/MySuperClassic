----------------------
--仅仅实现主动作条缩放和右边动作条的鼠标可见
----------------------

local cfg = {
	["Scale"] = 0.8,
	["RlgithBar OnMouseOver"] = true,
	}

MainMenuBar:SetScale(cfg["Scale"])


local rightBar = CreateFrame("Frame","RightBarHold",UIParent, "SecureHandlerStateTemplate")
rightBar:SetSize(36*2+5,36*12+5*11)
rightBar:SetPoint("RIGHT",-10,0)
rightBar:SetScale(cfg["Scale"])
MultiBarLeft:SetParent(rightBar)
MultiBarRight:SetParent(rightBar)

MultiBarRightButton1:ClearAllPoints()
MultiBarRightButton1:SetPoint("TOPRIGHT",rightBar)

MultiBarLeftButton1:ClearAllPoints()
MultiBarLeftButton1:SetPoint("TOPLEFT",rightBar)

if cfg["RlgithBar OnMouseOver"] then
	local function lighton(alpha)
	  if MultiBarRight:IsShown() then
		for i=1, 12 do
		  local pb = _G["MultiBarRightButton"..i]
		  pb:SetAlpha(alpha)
		end
	  end
	  
	  if MultiBarLeft:IsShown() then
		for i=1, 12 do
		  local pb = _G["MultiBarLeftButton"..i]
		  pb:SetAlpha(alpha)
		end
	  end
	end    
   
	-- MultiBarRight:EnableMouse(true)
	-- MultiBarRight:SetScript("OnEnter", function(self) lighton(1) end)
	-- MultiBarRight:SetScript("OnLeave", function(self) lighton(0) end)
	
	-- MultiBarLeft:EnableMouse(true)
	-- MultiBarLeft:SetScript("OnEnter", function(self) lighton(1) end)
	-- MultiBarLeft:SetScript("OnLeave", function(self) lighton(0) end)  
	
	rightBar:EnableMouse(true)
	rightBar:SetScript("OnEnter", function(self) lighton(1) end)
	rightBar:SetScript("OnLeave", function(self) lighton(0) end) 
	
	for i=1, 12 do
	  local pb = _G["MultiBarRightButton"..i]
	  pb:SetAlpha(0)
	  pb:HookScript("OnEnter", function(self) lighton(1) end)
	  pb:HookScript("OnLeave", function(self) lighton(0) end)
	  
	  local pb = _G["MultiBarLeftButton"..i]
	  pb:SetAlpha(0)
	  pb:HookScript("OnEnter", function(self) lighton(1) end)
	  pb:HookScript("OnLeave", function(self) lighton(0) end)
	end 
end

--ExtraActionBar移动扩展技能按钮
local extrabtn = CreateFrame("Frame", "ExtraBtn_holder", UIParent)
extrabtn:SetPoint("TOPLEFT",260,-95)
extrabtn:SetSize(160, 80)
--extrabtn:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"})

ExtraActionBarFrame:SetParent(extrabtn)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("CENTER", extrabtn, "CENTER", 0, 0)
ExtraActionBarFrame.ignoreFramePositionManager = true
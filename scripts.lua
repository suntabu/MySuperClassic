local cfg = {
		multip = 0.4,	--界面变暗
		Focuser = true,	--shifh+左键点击 快速设置焦点  点击空白处取消焦点
		autorollgreens = true,	--自动贪婪绿装
		["Quest Reword"] = true,	--高亮售价最高任务奖励
		Easyaddfriend = true,		--在右键菜单添加“添加好友”选项
		AutoRepair = true,			--自动修理
		SellGreyCrap = true,		--自动出售灰色品质物品
		}
-- dark UI color
-- from SuperClassic
local artUI = function()
	local r1, g1, b1, a1 = 1,1,1,1 -- top color
	local r2, g2, b2, a2 = cfg.multip, cfg.multip, cfg.multip, 1 -- bottom color

      for _, obj in ipairs({Minimap:GetChildren()}) do
            if (obj and (obj:GetObjectType() == "Frame" or obj:GetObjectType() == "Button")) then
                  for _, tex in ipairs({obj:GetRegions()}) do
                        if (tex and tex:GetObjectType() == "Texture") then
                              if tex:GetTexture() == "Interface\\Minimap\\MiniMap-TrackingBorder" then
								tex:SetVertexColor(1, 1, 1)
								tex:SetDesaturated(1)
								tex:SetVertexColor(r2, g2, b2)
                              end
                        end
                  end
            end
      end
	
	for i,v in pairs({
		-- Action bars
		MainMenuMaxLevelBar0,
		MainMenuMaxLevelBar1,
		MainMenuMaxLevelBar2,
		MainMenuMaxLevelBar3,
		MainMenuBarTexture0,
		MainMenuBarTexture1,
		MainMenuBarTexture2,
		MainMenuBarTexture3,
		MainMenuXPBarTextureRightCap,
		MainMenuXPBarTextureMid,
		MainMenuXPBarTextureLeftCap,
		ActionBarUpButton:GetRegions(),
		ActionBarDownButton:GetRegions(),
		--BonusActionBarFrame:GetRegions(),
		--select(2, BonusActionBarFrame:GetRegions()),
		
		-- Unit frames
		PlayerFrameTexture,
		TargetFrameTextureFrameTexture,
		FocusFrameTextureFrameTexture,
		TargetFrameToTTextureFrameTexture,
		FocusFrameToTTextureFrameTexture,
		PetFrameTexture,
		
		-- Minimap
		MinimapBackdrop,
		MinimapBorder,
		MiniMapMailBorder,
		MiniMapTrackingButtonBorder,
		MinimapBorderTop,
		MinimapZoneTextButton,
		MiniMapWorldMapButton,
		MiniMapWorldMapButton,
		MiniMapWorldIcon,
		MinimapZoomIn:GetRegions(),
		MinimapZoomOut:GetRegions(),
		--TimeManagerClockButton:GetRegions(),
		MiniMapWorldMapButton:GetRegions(),
		select(6, GameTimeFrame:GetRegions()),
		
		-- Exp bubble dividers
		MainMenuXPBarDiv1,
		MainMenuXPBarDiv2,
		MainMenuXPBarDiv3,
		MainMenuXPBarDiv4,
		MainMenuXPBarDiv5,
		MainMenuXPBarDiv6,
		MainMenuXPBarDiv7,
		MainMenuXPBarDiv8,
		MainMenuXPBarDiv9,
		MainMenuXPBarDiv10,
		MainMenuXPBarDiv11,
		MainMenuXPBarDiv12,
		MainMenuXPBarDiv13,
		MainMenuXPBarDiv14,
		MainMenuXPBarDiv15,
		MainMenuXPBarDiv16,
		MainMenuXPBarDiv17,
		MainMenuXPBarDiv18,
		MainMenuXPBarDiv19,
		
		-- Chat frame buttons
		select(2, FriendsMicroButton:GetRegions()),
		ChatFrameMenuButton:GetRegions(),
		ChatFrame1ButtonFrameUpButton:GetRegions(),
		ChatFrame1ButtonFrameDownButton:GetRegions(),
		select(2, ChatFrame1ButtonFrameBottomButton:GetRegions()),
		ChatFrame2ButtonFrameUpButton:GetRegions(),
		ChatFrame2ButtonFrameDownButton:GetRegions(),
		select(2, ChatFrame2ButtonFrameBottomButton:GetRegions()),
		
		-- Chat edit box
		select(6, ChatFrame1EditBox:GetRegions()),
		select(7, ChatFrame1EditBox:GetRegions()),
		select(8, ChatFrame1EditBox:GetRegions()),
		select(5, ChatFrame1EditBox:GetRegions()),
		
		-- Micro menu buttons
		select(2, SpellbookMicroButton:GetRegions()),
		select(3, CharacterMicroButton:GetRegions()),
		select(2, TalentMicroButton:GetRegions()),
		select(2, AchievementMicroButton:GetRegions()),
		select(2, QuestLogMicroButton:GetRegions()),
		select(2, GuildMicroButton:GetRegions()),
		select(3, PVPMicroButton:GetRegions()),
		select(2, LFDMicroButton:GetRegions()),
		select(4, MainMenuMicroButton:GetRegions()),
		select(2, HelpMicroButton:GetRegions()),
		
		-- Other
		select(2, CastingBarFrame:GetRegions()),
		select(2, MirrorTimer1:GetRegions()),
		MainMenuBarLeftEndCap,
		MainMenuBarRightEndCap,
	}) do
		if v:GetObjectType() == "Texture" then
			--v:SetVertexColor(1, 1, 1)
			--v:SetDesaturated(1)
			v:SetVertexColor(r2, g2, b2)
		end
	end
	
	-- Desaturation fix for elite target texture (thanks SDPhantom!)
	--[[hooksecurefunc("TargetFrame_CheckClassification", function(self)
		self.borderTexture:SetDesaturated(1)
	end)]]
	
	-- Game tooltip
	TOOLTIP_DEFAULT_COLOR = { r = r1 * .6, g = g1 * .6, b = b1 * .6 }
	TOOLTIP_DEFAULT_BACKGROUND_COLOR = { r = r2 * .1, g = g2 * .1, b = b2 * .1}
	
	MinimapBackdrop:SetBackdropBorderColor(cfg.multip, cfg.multip, cfg.multip)
end

artUI()

---------------- > Some slash commands
SlashCmdList['RELOADUI'] = function() ReloadUI() end
SLASH_RELOADUI1 = '/rl'		--简化的重载界面命令

SlashCmdList["TICKET"] = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/gm"		--简化的GM命令

SlashCmdList["READYCHECKSLASHRC"] = function() DoReadyCheck() end
SLASH_READYCHECKSLASHRC1 = '/rc'	--简化的就位准备命令

SlashCmdList["DISABLE_ADDON"] = function(s) DisableAddOn(s) print(s, format("|cffd36b6b disabled")) end
SLASH_DISABLE_ADDON1 = "/dis"   -- You need to reload UI after enabling/disabling addon 禁用插件

SlashCmdList["ENABLE_ADDON"] = function(s) EnableAddOn(s) print(s, format("|cfff07100 enabled")) end
SLASH_ENABLE_ADDON1 = "/en"   -- You need to reload UI after enabling/disabling addon 启用插件

SlashCmdList["CLCE"] = function() CombatLogClearEntries() end
SLASH_CLCE1 = "/clfix"		--清空战斗信息

-- a command to show frame you currently have mouseovered 显示鼠标指向框体的名称
SlashCmdList["FRAME"] = function(arg)
	if arg ~= "" then
		arg = _G[arg]
	else
		arg = GetMouseFocus()
	end
	if arg ~= nil and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		ChatFrame1:AddMessage("Name: |cffFFD100"..arg:GetName())
		if arg:GetParent() then
			ChatFrame1:AddMessage("Parent: |cffFFD100"..arg:GetParent():GetName())
		end
 		ChatFrame1:AddMessage("Width: |cffFFD100"..format("%.2f",arg:GetWidth()))
		ChatFrame1:AddMessage("Height: |cffFFD100"..format("%.2f",arg:GetHeight()))
		ChatFrame1:AddMessage("Strata: |cffFFD100"..arg:GetFrameStrata())
		ChatFrame1:AddMessage("Level: |cffFFD100"..arg:GetFrameLevel())
 		if xOfs then
			ChatFrame1:AddMessage("X: |cffFFD100"..format("%.2f",xOfs))
		end
		if yOfs then
			ChatFrame1:AddMessage("Y: |cffFFD100"..format("%.2f",yOfs))
		end
		if relativeTo then
			ChatFrame1:AddMessage("Point: |cffFFD100"..point.."|r anchored to "..relativeTo:GetName().."'s |cffFFD100"..relativePoint)
		end
		ChatFrame1:AddMessage("----------------------")
	elseif arg == nil then
		ChatFrame1:AddMessage("Invalid frame name")
	else
		ChatFrame1:AddMessage("Could not find frame info")
	end
end
SLASH_FRAME1 = "/gf"

-------------- > ©Focuser 快速设置焦点
if cfg.Focuser then
	local modifier = "shift" -- shift, alt or ctrl
	local mouseButton = "1" -- 1 = left, 2 = right, 3 = middle, 4 and 5 = thumb buttons if there are any

	local function SetFocusHotkey(frame)
		frame:SetAttribute(modifier.."-type"..mouseButton, "focus")
	end

	local function CreateFrame_Hook(type, name, parent, template)
		if name and template == "SecureUnitButtonTemplate" then
			SetFocusHotkey(_G[name])
		end
	end

	hooksecurefunc("CreateFrame", CreateFrame_Hook)

	local f = CreateFrame("CheckButton", "FocuserButton", UIParent, "SecureActionButtonTemplate")
	f:SetAttribute("type1", "macro")
	f:SetAttribute("macrotext", "/focus mouseover")
	SetOverrideBindingClick(FocuserButton, true, modifier.."-BUTTON"..mouseButton, "FocuserButton")

	local duf = {
		PetFrame,
		PartyMemberFrame1,
		PartyMemberFrame2,
		PartyMemberFrame3,
		PartyMemberFrame4,
		PartyMemberFrame1PetFrame,
		PartyMemberFrame2PetFrame,
		PartyMemberFrame3PetFrame,
		PartyMemberFrame4PetFrame,

		TargetFrame,
		TargetFrameToT,
		TargetofTargetFrame,
	}

	for i, frame in pairs(duf) do
		SetFocusHotkey(frame)
	end
end

------------------- > ©Quest tracker(by Tukz) 移动任务追踪
local wf = WatchFrame
local wfmove = false 

wf:SetMovable(true);
wf:SetClampedToScreen(false); 
wf:ClearAllPoints()
wf:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -35, -200)
wf:SetWidth(250)
wf:SetHeight(500)
wf:SetUserPlaced(true)
wf.SetPoint = function() end

local function WATCHFRAMELOCK()
	if wfmove == false then
		wfmove = true
		print("WatchFrame unlocked for drag")
		wf:EnableMouse(true);
		wf:RegisterForDrag("LeftButton"); 
		wf:SetScript("OnDragStart", wf.StartMoving); 
		wf:SetScript("OnDragStop", wf.StopMovingOrSizing);
	elseif wfmove == true then
		wf:EnableMouse(false);
		wfmove = false
		print("WatchFrame locked")
	end
end

SLASH_WATCHFRAMELOCK1 = "/wf"			--移动任务追踪命令
SlashCmdList["WATCHFRAMELOCK"] = WATCHFRAMELOCK

---------------- > Proper Ready Check sound	就位准备的声音
local ShowReadyCheckHook = function(self, initiator, timeLeft)
	if initiator ~= "player" then PlaySound("ReadyCheck") end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

---------------- > AutoRepair and sell grey junk 自动修理和出售灰色物品
local g = CreateFrame("Frame")
g:RegisterEvent("MERCHANT_SHOW")
g:SetScript("OnEvent", function()    
	if(cfg.AutoRepair==true and CanMerchantRepair()) then
			  local cost = GetRepairAllCost()
		if cost > 0 then
			local money = GetMoney()
			if IsInGuild() then
				local guildMoney = GetGuildBankWithdrawMoney()
				if guildMoney > GetGuildBankMoney() then
					guildMoney = GetGuildBankMoney()
				end
				if guildMoney > cost and CanGuildBankRepair() then
					RepairAllItems(1)
					print(format("|cfff07100Repair cost covered by G-Bank: %.1fg|r", cost * 0.0001))
					return
				end
			end
			if money > cost then
					RepairAllItems()
					print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
			else
				print("Go farm newbie.")
			end
		end
	end 
    if(cfg.SellGreyCrap==true) then
        local bag, slot 
        for bag = 0, 4 do
            for slot = 0, GetContainerNumSlots(bag) do
                local link = GetContainerItemLink(bag, slot)
                if link and (select(3, GetItemInfo(link))==0) then
                    UseContainerItem(bag, slot)
                end
            end
        end
    end
end)

---------------- > ALT+RightClick to buy a stack	ALT+右键买一组
hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, button)
    if MerchantFrame.selectedTab == 1 then
        if IsAltKeyDown() and button=="RightButton" then
            local id=self:GetID()
			local quantity = select(4, GetMerchantItemInfo(id))
            local extracost = select(7, GetMerchantItemInfo(id))
            if not extracost then
                local stack 
				if quantity > 1 then
					stack = quantity*GetMerchantItemMaxStack(id)
				else
					stack = GetMerchantItemMaxStack(id)
				end
                local amount = 1
                if self.count < stack then
                    amount = stack / self.count
                end
                if self.numInStock ~= -1 and self.numInStock < amount then
                    amount = self.numInStock
                end
                local money = GetMoney()
                if (self.price * amount) > money then
                    amount = floor(money / self.price)
                end
                if amount > 0 then
                    BuyMerchantItem(id, amount)
                end
            end
        end
    end
end)

---------------- > Autogreed on greens © tekkub	自动贪婪绿装
if cfg.autorollgreens then
	local f = CreateFrame("Frame", nil, UIParent)
	f:RegisterEvent("START_LOOT_ROLL")
	f:SetScript("OnEvent", function(_, _, id)
	if not id then return end -- What the fuck?
	local _, _, _, quality, bop, _, _, canDE = GetLootRollItemInfo(id)
	if quality == 2 and not bop then RollOnLoot(id, canDE and 3 or 2) end
	end)
end

 ---选取最贵奖励
if cfg["Quest Reword"] then
local f = CreateFrame("Frame")

local function MostValueable()
	local bestp, besti = 0
	for i=1,GetNumQuestChoices() do
		local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
		local price = link and select(11, GetItemInfo(link))
		if not price then
			return
		elseif (price * (qty or 1)) > bestp then
			bestp, besti = (price * (qty or 1)), i
		end
	end
	if besti then
		local btn = _G["QuestInfoItem"..besti]
		if (btn.type == "choice") then
			btn:GetScript("OnClick")(btn)
		end
	end
end

f:SetScript("OnEvent", function(self, event, ...)
	if (event == "QUEST_COMPLETE") then
		if (GetNumQuestChoices() and GetNumQuestChoices() > 1) then
			MostValueable()
		end
	end
end)

f:RegisterEvent("QUEST_COMPLETE")
end

--[[-----------------------------------------------------------------------------
Easy Add Friend
-------------------------------------------------------------------------------]]
if cfg.Easyaddfriend then
local EasyAddFriend = CreateFrame("Frame","EasyAddFriendFrame")
EasyAddFriend:SetScript("OnEvent", function() hooksecurefunc("UnitPopup_ShowMenu", EasyAddFriendCheck) EasyAddFriendSlash() end)
EasyAddFriend:RegisterEvent("PLAYER_LOGIN")

local PopupUnits = {"PARTY", "PLAYER", "RAID_PLAYER", "RAID", "FRIEND", "TEAM", "CHAT_ROSTER", "TARGET", "FOCUS"}

local AddFriendButtonInfo = {
	text = "加为好友",
	value = "ADD_FRIEND",
	func = function() AddFriend(UIDROPDOWNMENU_OPEN_MENU.name) end,
	notCheckable = 1,
}

local CancelButtonInfo = {
	text = "取消",
	value = "CANCEL",
	notCheckable = 1
}

function EasyAddFriendSlash()
	SLASH_EASYADDFRIEND1 = "/add";
	SlashCmdList["EASYADDFRIEND"] = function(msg) if #msg == 0 then DEFAULT_CHAT_FRAME:AddMessage("EasyAddFriend: Use '/add' followed by a character's name to add them to your friends list.") else AddFriend(msg) end end
end
function EasyAddFriendCheck()		
	local PossibleButton = getglobal("DropDownList1Button"..(DropDownList1.numButtons)-1)
	if PossibleButton["value"] ~= "ADD_FRIEND" then
		local GoodUnit = false
		for i=1, #PopupUnits do	
		if OPEN_DROPDOWNMENUS[1]["which"] == PopupUnits[i] then	
			GoodUnit = true
			end
		end
		if UIDROPDOWNMENU_OPEN_MENU["unit"] == "target" and ((not UnitIsPlayer("target")) or (not UnitIsFriend("player", "target"))) then
			GoodUnit = false
		end
		if GoodUnit then				
			local IsAlreadyFriend = false
			for z=1, GetNumFriends() do
				if GetFriendInfo(z) == UIDROPDOWNMENU_OPEN_MENU["name"] or UIDROPDOWNMENU_OPEN_MENU["name"] == UnitName("player") then
					IsAlreadyFriend = true
				end
			end
			if not IsAlreadyFriend then				
				CreateAddFriendButton()
			
			end
		end
	end		
end

function CreateAddFriendButton()

		local CancelButtonFrame = getglobal("DropDownList1Button"..DropDownList1.numButtons)
		CancelButtonFrame:Hide()
		DropDownList1.numButtons = DropDownList1.numButtons - 1
		UIDropDownMenu_AddButton(AddFriendButtonInfo)
		UIDropDownMenu_AddButton(CancelButtonInfo)
	
end
end
--移动BOSS特殊能量条
_G["PlayerPowerBarAlt"]:HookScript("OnShow", function(self) self:ClearAllPoints() self:SetPoint("TOP", 0, -30) self.SetPoint = function() end end)

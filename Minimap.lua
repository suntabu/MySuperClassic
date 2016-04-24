---------------------------------------------------------------------
-- WorldMap CoordText 
---------------------------------------------------------------------
WorldMapButton:HookScript("OnUpdate", function(self)
	if not self.coordText then
		self.coordText = WorldMapFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
--			self.coordText:SetPoint("BOTTOM", WorldMapPositioningGuide, "BOTTOM", -120, 5)
		self.coordText:SetPoint("RIGHT", WorldMapShowDigSites, "LEFT", -10, 0)	
	end
	local px, py = GetPlayerMapPosition("player")
	local x, y = GetCursorPosition()
	local width, height, scale = self:GetWidth(), self:GetHeight(), self:GetEffectiveScale()
	local centerX, centerY = self:GetCenter()
	x, y = (x/scale - (centerX - (width/2))) / width, (centerY + (height/2) - y/scale) / height
	if px == 0 and py == 0 and (x > 1 or y > 1 or x < 0 or y < 0) then
		self.coordText:SetText("")
	elseif px == 0 and py == 0 then
		self.coordText:SetText(format("当前: %d,%d", x*100, y*100))
	elseif x > 1 or y > 1 or x < 0 or y < 0 then
		self.coordText:SetText(format("玩家: %d, %d", px*100, py*100))
	else
		self.coordText:SetText(format("玩家: %d, %d  当前: %d, %d", px*100, py*100, x*100, y*100))
	end
end)
----------------------------------------------------------------------------------------
--	Shape, location and scale
----------------------------------------------------------------------------------------
-- Kill Minimap Cluster
MinimapCluster:EnableMouse(false)

Minimap:ClearAllPoints()
Minimap:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-10,5)
Minimap:SetSize(160,160)
Minimap:SetFrameStrata("BACKGROUND")

----------------------------------------------------------------------------------------
--	Minimap border
----------------------------------------------------------------------------------------
local MinimapArt = CreateFrame("Frame", nil, Minimap)
MinimapArt:SetSize(160+2,160+2)
MinimapArt:SetFrameLevel(0)
MinimapArt:SetFrameStrata("LOW")
MinimapArt:SetPoint("TOPLEFT",Minimap,"TOPLEFT",-1,1)
MinimapArt:SetPoint("BOTTOMRIGHT",Minimap,"BOTTOMRIGHT",1,-1)
MinimapArt:RegisterEvent("ADDON_LOADED")

MinimapArt.texture = MinimapArt:CreateTexture(nil, "OVERLAY")
MinimapArt.texture:SetTexture("Interface\\Addons\\MySuperClassic\\texture\\minimapborder")
MinimapArt.texture:SetPoint("TOPRIGHT",MinimapArt,3,3)
MinimapArt.texture:SetPoint("BOTTOMLEFT",MinimapArt,-3,-3)
MinimapArt.texture:SetVertexColor(.4,.4,.4,1)

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Game Time
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, 0)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\HELPFRAME\\ReportLagIcon-Mail")
MiniMapMailIcon:SetSize(32,32)

-- Move QueueStatus icon
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("TOP", Minimap, "TOP", 1, 6)
QueueStatusMinimapButton:SetHighlightTexture(nil)
QueueStatusMinimapButtonBorder:Hide()

local function UpdateLFGTooltip()
	local position = MinimapArt:GetPoint()
	QueueStatusFrame:ClearAllPoints()
	if position:match("BOTTOMRIGHT") then
		QueueStatusFrame:SetPoint("BOTTOMRIGHT", QueueStatusMinimapButton, "BOTTOMLEFT", 0, 0)
	elseif position:match("BOTTOM") then
		QueueStatusFrame:SetPoint("BOTTOMLEFT", QueueStatusMinimapButton, "BOTTOMRIGHT", 4, 0)
	elseif position:match("LEFT") then
		QueueStatusFrame:SetPoint("TOPLEFT", QueueStatusMinimapButton, "TOPRIGHT", 4, 0)
	else
		QueueStatusFrame:SetPoint("TOPRIGHT", QueueStatusMinimapButton, "TOPLEFT", 0, 0)
	end
end
QueueStatusFrame:HookScript("OnShow", UpdateLFGTooltip)
QueueStatusFrame:SetFrameStrata("TOOLTIP")

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- Instance Difficulty icon
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 3, 2)
MiniMapInstanceDifficulty:SetScale(0.75)

-- Guild Instance Difficulty icon
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -2, 2)
GuildInstanceDifficulty:SetScale(0.75)

-- Invites icon
GameTimeCalendarInvitesTexture:ClearAllPoints()
GameTimeCalendarInvitesTexture:SetParent(Minimap)
GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)

-- Default LFG icon
LFG_EYE_TEXTURES.raid = LFG_EYE_TEXTURES.default
LFG_EYE_TEXTURES.unknown = LFG_EYE_TEXTURES.default

-- Feedback icon
if FeedbackUIButton then
	FeedbackUIButton:ClearAllPoints()
	FeedbackUIButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 0)
	FeedbackUIButton:SetScale(0.8)
end

-- Streaming icon
if StreamingIcon then
	StreamingIcon:ClearAllPoints()
	StreamingIcon:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -10)
	StreamingIcon:SetScale(0.8)
end

-- Ticket icon
HelpOpenTicketButton:SetParent(Minimap)
HelpOpenTicketButton:ClearAllPoints()
HelpOpenTicketButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -5)
HelpOpenTicketButton:SetHighlightTexture(nil)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- Hide Game Time
MinimapArt:RegisterEvent("PLAYER_LOGIN")
MinimapArt:RegisterEvent("ADDON_LOADED")
MinimapArt:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:ClearAllPoints()
		TimeManagerClockButton:SetScale(0.001)
		TimeManagerClockButton:SetAlpha(0)
	end
end)

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
menuFrame:SetFrameLevel(3)
local guildText = IsInGuild() and ACHIEVEMENTS_GUILD_TAB or LOOKINGFORGUILD
local micromenu = {
	{text = CHARACTER_BUTTON, notCheckable = 1, func = function()
		ToggleCharacter("PaperDollFrame")
	end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1, func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return
		end
		ToggleFrame(SpellBookFrame)
	end},
	{text = TALENTS_BUTTON, notCheckable = 1, 
	func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end PlayerTalentFrame_Toggle() end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1, func = function()
		ToggleAchievementFrame()
	end},
	{text = QUESTLOG_BUTTON, notCheckable = 1, func = function()
		ToggleFrame(QuestLogFrame)
	end},
	{text = guildText, notCheckable = 1, func = function()
		if IsTrialAccount() then
			UIErrorsFrame:AddMessage(ERR_RESTRICTED_ACCOUNT, 1, 0.1, 0.1)
			return
		end
		if IsInGuild() then
			if not GuildFrame then
				LoadAddOn("Blizzard_GuildUI")
			end
			ToggleGuildFrame()
			GuildFrame_TabClicked(GuildFrameTab2)
		else
			if not LookingForGuildFrame then
				LoadAddOn("Blizzard_LookingForGuildUI")
			end
			if not LookingForGuildFrame then return end
			LookingForGuildFrame_Toggle()
		end
	end},
	{text = SOCIAL_BUTTON, notCheckable = 1, func = function()
		ToggleFriendsFrame(1)
	end},
	{text = PLAYER_V_PLAYER, notCheckable = 1, func = function()
		ToggleFrame(PVPFrame)
	end},
	{text = DUNGEONS_BUTTON, notCheckable = 1, func = function()
		PVEFrame_ToggleFrame()
	end},
	{text = LOOKING_FOR_RAID, notCheckable = 1, func = function()
		ToggleRaidFrame(3)
	end},
	{text = MOUNTS_AND_PETS, notCheckable = 1, func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return
		end
		TogglePetJournal()
	end},
	{text = ENCOUNTER_JOURNAL, notCheckable = 1, func = function()
		if not IsAddOnLoaded("Blizzard_EncounterJournal") then
			LoadAddOn("Blizzard_EncounterJournal")
		end
		ToggleEncounterJournal()
	end},
	{text = HELP_BUTTON, notCheckable = 1, func = function()
		ToggleHelpFrame()
	end},
	{text = L_MINIMAP_CALENDAR, notCheckable = 1, func = function()
		if not CalendarFrame then
			LoadAddOn("Blizzard_Calendar")
		end
		Calendar_Toggle()
	end},
	{text = BATTLEFIELD_MINIMAP, notCheckable = true, func = function()
		ToggleBattlefieldMinimap()
	end},
}

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = MinimapArt:GetPoint()
	if button == "RightButton" then
		if position:match("LEFT") then
			EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU", nil)
		else
			EasyMenu(micromenu, menuFrame, "cursor", -160, 0, "MENU", nil)
		end
	elseif button == "MiddleButton" then
		if position:match("LEFT") then
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", 0, 0, "MENU", 2)
		else
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "LeftButton" then
		Minimap_OnClick(self)
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture([=[Interface\ChatFrame\ChatFrameBackground]=])
Minimap:SetArchBlobRingAlpha(0)
Minimap:SetQuestBlobRingAlpha(0)

-- For others mods with a minimap button, set minimap buttons position in square mode
function GetMinimapShape() return "SQUARE" end

----------------------------------------------------------------------------------------
--	Tracking icon
----------------------------------------------------------------------------------------
MiniMapTracking:Hide()
MiniMapTracking.Show = function() end
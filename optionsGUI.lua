local RRIncPrompt = LibStub("AceAddon-3.0"):NewAddon("RRIncPrompt")
local AceGUI = LibStub("AceGUI-3.0")
-- local AAATest = LibStub("AceAddon-3.0"):NewAddon("AAATest", "AceComm-3.0", "AceEvent-3.0", "AceHook-3.0", "AceSerializer-3.0")

-- local MyAddon = {
-- 	enabled = false
-- }
local test = false

myOptionsTable = {
  type = "group",
  args = {
    optionShowRollPopup = {
        name = "Roll popup",
        desc = "Shows popup when prompted for rolls (in case of ties).",
        type = "toggle",
        set = function(info,val) rripOptionShowRollPopup = val end,
        get = function(info) return rripOptionShowRollPopup  end
	},
	optionShowDuringCombat = {
        name = "In combat",
        desc = "Shows popup during combat, if disabled popups that would have been shown during combat wont be shown at all.",
        type = "toggle",
        set = function(info,val) rripOptionShowPopupsDuringCombat = val end,
        get = function(info) return rripOptionShowPopupsDuringCombat  end
    },
    optionAllowEscape = {
        name = "Close with Escape",
        desc = "Popup can be closed/rejected with 'Esc' key. Beware that this will decline offers of items etc. Will also register even if the popup is not the active window!",
        type = "toggle",
        set = function(info,val) rripOptionAllowEscape = val end,
        get = function(info) return rripOptionAllowEscape  end
    },
    -- moreoptions={
    --   name = "More Options",
    --   type = "group",
    --   args={
    --     -- more options go here
    --   }
    -- }
  }
}

local AceConfig = LibStub("AceConfig-3.0")
AceConfig:RegisterOptionsTable("RRInc Prompt", myOptionsTable, {"rrincpromptconfig", "rripcfg"})

LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RRInc Prompt", "RRInc Prompt", nil);



--  MyAddon = {};
--  MyAddon.panel = CreateFrame( "Frame", "MyAddonPanel", UIParent );
--  -- Register in the Interface Addon Options GUI
--  -- Set the name for the Category for the Options Panel
--  MyAddon.panel.name = "RRInc Prompt";
--  -- Add the panel to the Interface Options
 

-- MyAddon.panel.btnOptionShowRollPopup = CreateFrame("CheckButton", nil, UIConfig, "InterfaceOptionsCheckButtonTemplate")
-- MyAddon.panel.btnOptionShowRollPopup:SetPoint("CENTER", UIConfig, "TOP", 0, -80)
-- MyAddon.panel.btnOptionShowRollPopup:SetSize(40, 40)
-- MyAddon.panel.btnOptionShowRollPopup:SetText("Show roll popup:")
-- MyAddon.panel.btnOptionShowRollPopup:SetNormalFontObject("GameFontNormalLarge")
-- MyAddon.panel.btnOptionShowRollPopup:SetHighlightFontObject("GameFontHighlightLarge")
 

-- InterfaceOptions_AddCategory(MyAddon.panel);
-- --  -- Make a child panel
--  MyAddon.childpanel = CreateFrame( "Frame", "MyAddonChild", MyAddon.panel);
--  MyAddon.childpanel.name = "MyChild";
--  -- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
--  MyAddon.childpanel.parent = MyAddon.panel.name;
--  -- Add the child to the Interface Options
--  InterfaceOptions_AddCategory(MyAddon.childpanel);

-- RRIncPrompt_optionsFrame = CreateFrame("Frame", "RRIncPrompt_optionsFrame", UIParent)
-- RRIncPrompt_optionsFrame:SetPoint("CENTER")
-- RRIncPrompt_optionsFrame:SetSize(500, 150)
-- RRIncPrompt_optionsFrame:SetBackdrop(GameTooltip:GetBackdrop())
-- RRIncPrompt_optionsFrame:SetBackdropColor(0, 0, 0)
-- RRIncPrompt_optionsFrame:SetBackdropBorderColor(0.1, 0.1, 0.1)
-- -- RRIncPrompt_optionsFrame:Hide()

-- -- local Title = RRIncPrompt_optionsFrame:CreateFontString("$parentTitle", "OVERLAY", "GameFontNormal")
-- local Title = RRIncPrompt_optionsFrame:CreateFontString("$parentTitle", "OVERLAY", "GameFontHighlightLarge")
-- Title:SetPoint("TOPLEFT", RRIncPrompt_optionsFrame, 12, -12)
-- Title:SetText("RRInc Prompt v1 - Options ")
-- RRIncPrompt_optionsFrame.Title = Title

-- local Text = RRIncPrompt_optionsFrame:CreateFontString("$parentText", "OVERLAY", "GameFontHighlightSmall")
-- Text:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -10)
-- Text:SetPoint("RIGHT")
-- Text:SetHeight(32)
-- Text:SetJustifyH("LEFT")
-- Text:SetJustifyV("TOP")
-- Text:SetText("Type an emote in the box and then press the button...")
-- RRIncPrompt_optionsFrame.Text = Text

-- local EmoteBox = CreateFrame("EditBox", "$parentEditBox", RRIncPrompt_optionsFrame, "InputBoxTemplate")
-- EmoteBox:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", -4, -24)
-- EmoteBox:SetWidth(200)
-- RRIncPrompt_optionsFrame.EmoteBox = EmoteBox

-- local EmoteLabel = EmoteBox:CreateFontString("$parentLabel", "OVERLAY", "GameFontHighlightSmall")
-- EmoteLabel:SetPoint("BOTTOMLEFT", EmoteBox, "TOPLEFT")
-- EmoteLabel:SetText("Action:")
-- EmoteBox.Label = EmoteLabel

-- EmoteBox:SetScript("OnEnterPressed", function(self)
-- 	local text = self:GetText()
-- 	-- do something with the text here
-- end)

-- local RollButton = CreateFrame("Button", "$parentRollButton", RRIncPrompt_optionsFrame, "UIPanelButtonTemplate")
-- RollButton:SetPoint("TOPLEFT", EmoteBox, "BOTTOMLEFT", 0, -12)
-- RollButton:SetWidth(200)
-- RollButton:SetText("Roll!")
-- RRIncPrompt_optionsFrame.RollButton = RollButton

-- RollButton:SetScript("OnClick", function(self, mouseButton)
-- 	-- do something with the click here
-- end)

-- local CloseButton = CreateFrame("Button", "$parentCloseButton", RRIncPrompt_optionsFrame, "UIPanelCloseButton")
-- CloseButton:SetPoint("TOPRIGHT", -12, -12)
-- CloseButton:SetScript("OnClick", function(self)
-- 	self:GetParent():Hide()
-- end)
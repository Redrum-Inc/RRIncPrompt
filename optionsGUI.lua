local RRIncPrompt = LibStub("AceAddon-3.0"):NewAddon("RRIncPrompt")
local AceGUI = LibStub("AceGUI-3.0")

local test = false

local myOptionsTable = {
  type = "group",
  args = {
    optionShowRollPopup = {
        name = "Roll popup",
        desc = "Shows popup when prompted for rolls (in case of ties).",
        type = "toggle",
        set = function(info,val) rripOptionShowRollPopup = val end,
        get = function(info) return rripOptionShowRollPopup  end
    },
    optionShowFFA = {
        name = "FFA popup",
        desc = "Shows popup when FFA roll is announced.",
        type = "toggle",
        set = function(info,val) rripOptionShowFFA = val end,
        get = function(info) return rripOptionShowFFA  end
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
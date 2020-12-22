local addonChannel = "RRIncPrompt"

function PromptLootNext(item)
    StaticPopupDialogs["RRIncPrompt_Loot"] = {
		text = "Next in line for:\n\n"..item.."\n\nDo you want it?",
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			SendChatMessage("yes","RAID","COMMON");
		end,
		OnCancel = function()
			SendChatMessage("no","RAID","COMMON");
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}

	StaticPopup_Show("RRIncPrompt_Loot")
end

function PromptLootRoll(item)
    StaticPopupDialogs["RRIncPrompt_Loot"] = {
		text = "Tied for:\n\n"..item,
		button1 = "Roll",
		OnAccept = function()
			RandomRoll(1,100)
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}

	StaticPopup_Show("RRIncPrompt_Loot")
end

function IncomingMessage(...)
    local arg1, arg2, arg3, arg4, arg5, arg6 = ...

    local prefix=arg3;	
    local messageText = arg4;
    --print(arg5);
    local sender = arg6;    

    if prefix==addonChannel then        
        local targetPlayer, action, item = strsplit("_", messageText)

        local playerName = select(6, GetPlayerInfoByGUID(UnitGUID("player")))

        if playerName == targetPlayer then
            if action == "next" then
                PromptLootNext(item)
            end

            if action == "roll" then
                PromptLootRoll(item)
            end
        end
    end
end

function RRP_SendAddonMessage(msg)
    -- Can be sent to GUILD as well (might be preferable to WHISPER when not in RAID).
    if IsInGroup() then
        -- C_ChatInfo.SendAddonMessage( PmbVars_AddonChannel, sender.."|"..reciever.."|"..msg, "RAID" );
    else
        -- C_ChatInfo.SendAddonMessage( "RRIncPrompt", msg, "WHISPER", select(6, GetPlayerInfoByGUID(UnitGUID("player"))) );
        C_ChatInfo.SendAddonMessage(addonChannel, msg, "SAY");
    end
end


SLASH_RRINCPROMPT1 = '/rrincprompt'
SLASH_RRINCPROMPT2 = '/rrp'
function SlashCmdList.RRINCPROMPT(msg)
    local option, value = strsplit(" ",msg)	
    
    local playerName = select(6, GetPlayerInfoByGUID(UnitGUID("player")))
    
    print(C_ChatInfo.IsAddonMessagePrefixRegistered(addonChannel))
    if(msg~=nil and msg~="") then
        RRP_SendAddonMessage(msg)
    end
end

local function EventEnterWorld(self, event, isLogin, isReload)
    local title = GetAddOnMetadata("RRIncPrompt", "Title")
    local version = GetAddOnMetadata("RRIncPrompt", "Version")

    if(RRIncPrompt == nil) then
        print(title..": Setting defaults.")
        RRIncPrompt = {}
        RRIncPrompt.Settings = {
            optionShowRollPopup = true,
            optionShowPopupsDuringCombat = true
        }
    else
        if RRIncPrompt.Settings.optionShowRollPopup == nil then
            RRIncPrompt.Settings.optionShowRollPopup = true
        end

        if RRIncPrompt.Settings.optionShowPopupsDuringCombat == nil then
            RRIncPrompt.Settings.optionShowPopupsDuringCombat = true
        end

        -- print(title..": optionShowRollPopup == "..tostring(RRIncPrompt.Settings.optionShowRollPopup))
        -- print(title..": optionShowPopupsDuringCombat == "..tostring(RRIncPrompt.Settings.optionShowPopupsDuringCombat))
    end

    local successfulRequest = C_ChatInfo.RegisterAddonMessagePrefix(addonChannel)
    if isLogin or isReload then
        print(title.." loaded.")
    end
end

local FrameEnterWorld = CreateFrame("Frame")
FrameEnterWorld:RegisterEvent("PLAYER_ENTERING_WORLD")
FrameEnterWorld:SetScript("OnEvent", EventEnterWorld)

local RRIncPrompt_IncomingMessage = CreateFrame("Frame")
RRIncPrompt_IncomingMessage:RegisterEvent("CHAT_MSG_ADDON")
RRIncPrompt_IncomingMessage:SetScript("OnEvent", IncomingMessage)
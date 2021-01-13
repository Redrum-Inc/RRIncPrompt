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
		hideOnEscape = rripOptionAllowEscape,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
    }
    
    if not InCombatLockdown() then
        StaticPopup_Show("RRIncPrompt_Loot")
    end

    if InCombatLockdown() and rripOptionShowPopupsDuringCombat then
        StaticPopup_Show("RRIncPrompt_Loot")
    end
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
		hideOnEscape = rripOptionAllowEscape,
		preferredIndex = 3,
	}

    if rripOptionShowRollPopup then
        if not InCombatLockdown() then
            StaticPopup_Show("RRIncPrompt_Loot")
        end

        if InCombatLockdown() and rripOptionShowPopupsDuringCombat then
            StaticPopup_Show("RRIncPrompt_Loot")
        end
    end
end

function PromptLootFFA(item)
    StaticPopupDialogs["RRIncPrompt_Loot"] = {
		text = "FFA:\n\n"..item,
        button1 = "Roll",
        button2 = "Skip",
		OnAccept = function()
			RandomRoll(1,100)
        end,
        OnCancel = function()			
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = rripOptionAllowEscape,
		preferredIndex = 3,
	}

    if rripOptionShowFFA then
        if not InCombatLockdown() then
            StaticPopup_Show("RRIncPrompt_Loot")
        end

        if InCombatLockdown() and rripOptionShowPopupsDuringCombat then
            StaticPopup_Show("RRIncPrompt_Loot")
        end
    end
end

function IncomingMessage(...)
    local arg1, arg2, arg3, arg4, arg5, arg6 = ...

    local prefix=arg3;	
    local messageText = arg4;
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

        if targetPlayer == "all" then
            if action == "ffa" then
                PromptLootFFA(item)
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
SLASH_RRINCPROMPT2 = '/rrip'
function SlashCmdList.RRINCPROMPT(msg)
    local option, value = strsplit(" ",msg)	

    if ( not InterfaceOptionsFrame:IsShown() ) then
		InterfaceOptionsFrame:Show();
	end

    InterfaceOptionsFrame_OpenToCategory(MyAddon.panel);
end

local function EventEnterWorld(self, event, isLogin, isReload)
    local title = GetAddOnMetadata("RRIncPrompt", "Title")
    local version = GetAddOnMetadata("RRIncPrompt", "Version")

    local successfulRequest = C_ChatInfo.RegisterAddonMessagePrefix(addonChannel)
    if isLogin or isReload then
        if rripOptionShowRollPopup == nil then
            rripOptionShowRollPopup = true
        end
        if rripOptionShowPopupsDuringCombat == nil then
            rripOptionShowPopupsDuringCombat = true
        end
        if rripOptionAllowEscape == nil then
            rripOptionAllowEscape = false
        end
        print(title.." v"..version.." loaded.")
    end
end

local FrameEnterWorld = CreateFrame("Frame")
FrameEnterWorld:RegisterEvent("PLAYER_ENTERING_WORLD")
FrameEnterWorld:SetScript("OnEvent", EventEnterWorld)

local RRIncPrompt_IncomingMessage = CreateFrame("Frame")
RRIncPrompt_IncomingMessage:RegisterEvent("CHAT_MSG_ADDON")
RRIncPrompt_IncomingMessage:SetScript("OnEvent", IncomingMessage)
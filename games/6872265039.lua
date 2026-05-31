local run = function(func) func() end
local cloneref = cloneref or function(obj) return obj end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local inputService = cloneref(game:GetService('UserInputService'))
local tweenService = cloneref(game:GetService('TweenService'))
local runService = cloneref(game:GetService('RunService')) 
local httpService = cloneref(game:GetService('HttpService'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity
local sessioninfo = vape.Libraries.sessioninfo
local bedwars = {}

local function notif(...)
	return vape:CreateNotification(...)
end

run(function()
	local function dumpRemote(tab)
		local ind = table.find(tab, 'Client')
		return ind and tab[ind + 1] or ''
	end
	local KnitInit, Knit
	repeat
		KnitInit, Knit = pcall(function()
			return debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 9)
		end)
		if KnitInit then break end
		task.wait(0.1)
	until KnitInit

	if not debug.getupvalue(Knit.Start, 1) then
		repeat task.wait(0.1) until debug.getupvalue(Knit.Start, 1)
	end

	local Flamework = require(replicatedStorage['rbxts_include']['node_modules']['@flamework'].core.out).Flamework
	local InventoryUtil = require(replicatedStorage.TS.inventory['inventory-util']).InventoryUtil
	local Client = require(replicatedStorage.TS.remotes).default.Client
	local OldGet, OldBreak = Client.Get
	local function safeGetProto(func, index)
		if not func then return nil end
		local success, proto = pcall(safeGetProto, func, index)
		if success then
			return proto
		else
			warn("function:", func, "index:", index) 
			return nil
		end
	end

	bedwars = setmetatable({
	 	MatchHistroyApp = require(lplr.PlayerScripts.TS.controllers.global["match-history"].ui["match-history-moderation-app"]).MatchHistoryModerationApp,
	 	MatchHistroyController = Knit.Controllers.MatchHistoryController,
		AbilityController = Flamework.resolveDependency('@easy-games/game-core:client/controllers/ability/ability-controller@AbilityController'),
		AnimationType = require(replicatedStorage.TS.animation['animation-type']).AnimationType,
		AnimationUtil = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out['shared'].util['animation-util']).AnimationUtil,
		AppController = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out.client.controllers['app-controller']).AppController,
		BedBreakEffectMeta = require(replicatedStorage.TS.locker['bed-break-effect']['bed-break-effect-meta']).BedBreakEffectMeta,
		BedwarsKitMeta = require(replicatedStorage.TS.games.bedwars.kit['bedwars-kit-meta']).BedwarsKitMeta,
		ClickHold = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out.client.ui.lib.util['click-hold']).ClickHold,
		Client = Client,
		ClientConstructor = require(replicatedStorage['rbxts_include']['node_modules']['@rbxts'].net.out.client),
		MatchHistoryController = require(lplr.PlayerScripts.TS.controllers.global['match-history']['match-history-controller']),
		PlayerProfileUIController = require(lplr.PlayerScripts.TS.controllers.global['player-profile']['player-profile-ui-controller']),
		TitleTypes = require(game.ReplicatedStorage.TS.locker.title['title-type']).TitleType,
		TitleTypesMeta =  require(game.ReplicatedStorage.TS.locker.title['title-meta']).TitleMeta,
		EmoteType = require(replicatedStorage.TS.locker.emote['emote-type']).EmoteType,
		GameAnimationUtil = require(replicatedStorage.TS.animation['animation-util']).GameAnimationUtil,
		NotificationController = Flamework.resolveDependency('@easy-games/game-core:client/controllers/notification-controller@NotificationController'),
		getIcon = function(item, showinv)
			local itemmeta = bedwars.ItemMeta[item.itemType]
			return itemmeta and showinv and itemmeta.image or ''
		end,
		getInventory = function(plr)
			local suc, res = pcall(function()
				return InventoryUtil.getInventory(plr)
			end)
			return suc and res or {
				items = {},
				armor = {}
			}
		end,
		HudAliveCount = require(lplr.PlayerScripts.TS.controllers.global['top-bar'].ui.game['hud-alive-player-counts']).HudAlivePlayerCounts,
		ItemMeta = debug.getupvalue(require(replicatedStorage.TS.item['item-meta']).getItemMeta, 1),
		Knit = Knit,
		KnockbackUtil = require(replicatedStorage.TS.damage['knockback-util']).KnockbackUtil,
		MageKitUtil = require(replicatedStorage.TS.games.bedwars.kit.kits.mage['mage-kit-util']).MageKitUtil,
		NametagController = Knit.Controllers.NametagController,
		PartyController = Flamework.resolveDependency('@easy-games/lobby:client/controllers/party-controller@PartyController'),
		ProjectileMeta = require(replicatedStorage.TS.projectile['projectile-meta']).ProjectileMeta,
		QueryUtil = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out).GameQueryUtil,
		QueueCard = require(lplr.PlayerScripts.TS.controllers.global.queue.ui['queue-card']).QueueCard,
		QueueMeta = require(replicatedStorage.TS.game['queue-meta']).QueueMeta,
		Roact = require(replicatedStorage['rbxts_include']['node_modules']['@rbxts']['roact'].src),
		RuntimeLib = require(replicatedStorage['rbxts_include'].RuntimeLib),
		SoundList = require(replicatedStorage.TS.sound['game-sound']).GameSound,
		Store = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
		TeamUpgradeMeta = debug.getupvalue(require(replicatedStorage.TS.games.bedwars['team-upgrade']['team-upgrade-meta']).getTeamUpgradeMetaForQueue, 6),
		UILayers = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out).UILayers,
		VisualizerUtils = require(lplr.PlayerScripts.TS.lib.visualizer['visualizer-utils']).VisualizerUtils,
		WeldTable = require(replicatedStorage.TS.util['weld-util']).WeldUtil,
		WinEffectMeta = require(replicatedStorage.TS.locker['win-effect']['win-effect-meta']).WinEffectMeta,
		ZapNetworking = require(lplr.PlayerScripts.TS.lib.network),
	}, {
		__index = function(self, ind)
			rawset(self, ind, Knit.Controllers[ind])
			return rawget(self, ind)
		end
	})

	local kills = sessioninfo:AddItem('Kills')
	local beds = sessioninfo:AddItem('Beds')
	local wins = sessioninfo:AddItem('Wins')
	local games = sessioninfo:AddItem('Games')

	vape:Clean(function()
		table.clear(bedwars)
	end)
end)


getgenv()._aeroTierReady = true
local function getAccountTier(player)
    return 0
end

getgenv().getAeroTier = function(player)
    return getAccountTier(player)
end  
for _, v in vape.Modules do
	if v.Category == 'Combat' or v.Category == 'Render' then
		vape:Remove(i)
	end
end

run(function()
	local Sprint
	local old
	
	Sprint = vape.Categories.Combat:CreateModule({
		Name = 'Sprint',
		Function = function(callback)
			if callback then
				if inputService.TouchEnabled then pcall(function() lplr.PlayerGui.MobileUI['2'].Visible = false end) end
				old = bedwars.SprintController.stopSprinting
				bedwars.SprintController.stopSprinting = function(...)
					local call = old(...)
					bedwars.SprintController:startSprinting()
					return call
				end
				Sprint:Clean(entitylib.Events.LocalAdded:Connect(function() bedwars.SprintController:stopSprinting() end))
				bedwars.SprintController:stopSprinting()
			else
				if inputService.TouchEnabled then pcall(function() lplr.PlayerGui.MobileUI['2'].Visible = true end) end
				bedwars.SprintController.stopSprinting = old
				bedwars.SprintController:stopSprinting()
			end
		end,
		Tooltip = 'Sets your sprinting to true.'
	})
end)
	
run(function()
	local AutoGamble
	
	AutoGamble = vape.Categories.Minigames:CreateModule({
		Name = 'AutoGamble',
		Function = function(callback)
			if callback then
				AutoGamble:Clean(bedwars.Client:GetNamespace('RewardCrate'):Get('CrateOpened'):Connect(function(data)
					if data.openingPlayer == lplr then
						local tab = bedwars.CrateItemMeta[data.reward.itemType] or {displayName = data.reward.itemType or 'unknown'}
						notif('AutoGamble', 'Won '..tab.displayName, 5)
					end
				end))
	
				repeat
					if not bedwars.CrateAltarController.activeCrates[1] then
						for _, v in bedwars.Store:getState().Consumable.inventory do
							if v.consumable:find('crate') then
								bedwars.CrateAltarController:pickCrate(v.consumable, 1)
								task.wait(1.2)
								if bedwars.CrateAltarController.activeCrates[1] and bedwars.CrateAltarController.activeCrates[1][2] then
									bedwars.Client:GetNamespace('RewardCrate'):Get('OpenRewardCrate'):SendToServer({
										crateId = bedwars.CrateAltarController.activeCrates[1][2].attributes.crateId
									})
								end
								break
							end
						end
					end
					task.wait(1)
				until not AutoGamble.Enabled
			end
		end,
		Tooltip = 'Automatically opens lucky crates, piston inspired!'
	})
end)
	
run(function()
    local ok, err = pcall(function()
        repeat task.wait() until vape and vape.Categories and vape.Categories.Render
        local ClanModule
        local ClanColor = Color3.new(1, 1, 1)
        local enabledFlag = false
        local EquippedTag = nil
    
        local SavedTags = {}
        local TagToggles = {}
        
        local function safeSet(attr, value)
            local lp = game.Players.LocalPlayer
            if lp and lp.SetAttribute then
                pcall(function()
                    lp:SetAttribute(attr, value)
                end)
            end
        end
        
        local function buildTag()
            if not EquippedTag then return "" end
            local hex = string.format("#%02X%02X%02X",
                ClanColor.R * 255,
                ClanColor.G * 255,
                ClanColor.B * 255
            )
            return "<font color='"..hex.."'>"..EquippedTag.."</font>"
        end
        
        local function updateClanTag()
            if enabledFlag then
                safeSet("ClanTag", buildTag())
            else
                safeSet("ClanTag", "")
            end
        end
        
        local function createTagToggles()
            for i, toggle in pairs(TagToggles) do
                if toggle and toggle.Object then
                    toggle.Object:Remove()
                end
            end
            TagToggles = {}
            
            for i, tag in ipairs(SavedTags) do
                if tag and tag ~= "" then
                    TagToggles[i] = ClanModule:CreateToggle({
                        Name = tag,
                        Function = function(callback)
                            if callback then
                                EquippedTag = tag
                                for j, otherToggle in pairs(TagToggles) do
                                    if j ~= i and otherToggle and otherToggle.Enabled then
                                        otherToggle:Toggle()
                                    end
                                end
                            else
                                if EquippedTag == tag then
                                    EquippedTag = nil
                                end
                            end
                            updateClanTag()
                        end
                    })
                end
            end
        end
        
        ClanModule = vape.Categories.Render:CreateModule({
            Name = "CustomClanTag",
            HoverText = "Click tags to equip/unequip",
            Function = function(state)
                enabledFlag = state
                if state then
                    createTagToggles()
                end
                updateClanTag()
            end
        })
        
        ClanModule:CreateColorSlider({
            Name = "Tag Color",
            Function = function(h, s, v)
                ClanColor = Color3.fromHSV(h, s, v)
                updateClanTag()
            end
        })
        
        local tagListObject = ClanModule:CreateTextList({
            Name = "Clan Tags",
            Placeholder = "Add tags here",
            Function = function(list)
                SavedTags = {}
                for i, tag in ipairs(list) do
                    if tag and tag ~= "" then
                        table.insert(SavedTags, tag)
                    end
                end
                
                createTagToggles()
            end
        })
        
    end)
    if not ok then
        warn("CustomClanTag error:", err)
    end
end)

run(function()
	local ViewMatchHistory
	ViewMatchHistory = vape.Categories.Utility:CreateModule({
		Name = "ViewMatchHistory",
		Function = function(callback)
			if callback then
				ViewMatchHistory:Toggle(false)
				local d = nil
				bedwars.MatchHistroyController:requestMatchHistory(lplr.Name):andThen(function(Data)
					if Data then
						bedwars.AppController:openApp({app = bedwars.MatchHistroyApp,appId = "MatchHistoryApp",},Data)
					end
				end)
			else
				return
			end
		end,
		Tooltip = "matchhisory"
	})																								
end)

run(function()
	local OGNameTags
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local CollectionService = game:GetService("CollectionService")
	local LP = Players.LocalPlayer
	local FLAME_IMAGE = "rbxassetid://7101948108"
	local BedwarsImageId = require(ReplicatedStorage.TS.image["image-id"]).BedwarsImageId
	local TITLE_STROKE_TRANSP = nil
	local WIN_TEXT_PULL_LEFT = 14
	local ORIGINAL_NAMETAG_SCALE = 1.17
	local TITLE_TEXT_SIZE = 14
	local FLAME_ASPECT_RATIO = 0.8
	
	local KnitClient
	do
		local ok, knitMod = pcall(function()
			return require(ReplicatedStorage.rbxts_include.node_modules["@easy-games"].knit.src).KnitClient
		end)
		if ok then KnitClient = knitMod end
	end
	
	local function divisionToRankKey(division)
		if division >= 0 and division <= 3 then return "BRONZE_RANK"
		elseif division >= 4 and division <= 7 then return "SILVER_RANK"
		elseif division >= 8 and division <= 11 then return "GOLD_RANK"
		elseif division >= 12 and division <= 15 then return "PLATINUM_RANK"
		elseif division >= 16 and division <= 19 then return "DIAMOND_RANK"
		elseif division >= 20 and division <= 23 then return "EMERALD_RANK"
		elseif division == 24 then return "NIGHTMARE_RANK"
		end
		return "RANDOM_KIT_RENDER"
	end
	
	local function requestNametagData(callback)
		if not KnitClient or not KnitClient.Controllers or not KnitClient.Controllers.NametagController then return end
		local ctrl = KnitClient.Controllers.NametagController
		local ok, promise = pcall(function()
			return ctrl:requestNametagData(LP)
		end)
		if not ok or not promise then return end
		if typeof(promise) == "table" and promise.andThen then
			promise:andThen(function(data) callback(data) end)
		end
	end
	
	local function findLocalOriginalNametag(char)
		local head = char:FindFirstChild("Head")
		if not head then return nil end
		
		local direct = head:FindFirstChild("Nametag")
		if direct and direct:IsA("BillboardGui") then
			return direct
		end
		
		for _, gui in ipairs(CollectionService:GetTagged("EntityNameTag")) do
			if gui:IsA("BillboardGui") and (gui.Adornee == head or gui:IsDescendantOf(char)) then
				return gui
			end
		end
		
		return nil
	end
	
	local function scaleOriginalNametagSlightly(originalGui)
		if not originalGui then return end
		
		local attrW = originalGui:GetAttribute("BaseSizeW")
		local attrH = originalGui:GetAttribute("BaseSizeH")
		
		if type(attrW) ~= "number" or type(attrH) ~= "number" then
			originalGui:SetAttribute("BaseSizeW", originalGui.Size.X.Scale)
			originalGui:SetAttribute("BaseSizeH", originalGui.Size.Y.Scale)
			attrW = originalGui.Size.X.Scale
			attrH = originalGui.Size.Y.Scale
		end
		
		local w = (attrW or originalGui.Size.X.Scale) * ORIGINAL_NAMETAG_SCALE
		local h = (attrH or originalGui.Size.Y.Scale) * ORIGINAL_NAMETAG_SCALE
		
		originalGui.Size = UDim2.fromScale(w, h)
	end
	
	local function hideMiddleNameAndLevel(originalGui)
		if not originalGui then return end
		
		local container = originalGui:FindFirstChild("DisplayNameContainer", true)
		if container and container:IsA("GuiObject") then container.Visible = false end
		
		local nameLabel = originalGui:FindFirstChild("DisplayName", true)
		if nameLabel and nameLabel:IsA("TextLabel") then nameLabel.Visible = false end
		
		for _, d in ipairs(originalGui:GetDescendants()) do
			if d:IsA("TextLabel") then
				local t = tostring(d.Text or "")
				if t:match("^%(%d+%)") then d.Visible = false end
			end
		end
	end
	
	local function hideOldWinStreakOnly(originalGui)
		if not originalGui then return end
		
		for _, d in ipairs(originalGui:GetDescendants()) do
			if d:IsA("TextLabel") then
				local name = string.lower(d.Name or "")
				local txt = tostring(d.Text or "")
				if name:find("winstreak") or name:find("streak") or txt:find("🔥") then
					d.Visible = false
				end
			elseif d:IsA("ImageLabel") then
				local name = string.lower(d.Name or "")
				local img = tostring(d.Image or "")
				if name:find("winstreak") or name:find("streak") or img == FLAME_IMAGE then
					d.Visible = false
				end
			end
		end
	end
	
	local RANK_ICON_IMAGES = {}
	do
		local keys = {
			"BRONZE_RANK","SILVER_RANK","GOLD_RANK","PLATINUM_RANK",
			"DIAMOND_RANK","EMERALD_RANK","NIGHTMARE_RANK",
		}
		for _, k in ipairs(keys) do
			local img = BedwarsImageId[k]
			if type(img) == "string" and img ~= "" then
				RANK_ICON_IMAGES[img] = true
			end
		end
	end
	
	local function hideOldRankIconOnly(originalGui)
		if not originalGui then return end
		
		for _, d in ipairs(originalGui:GetDescendants()) do
			if d:IsA("ImageLabel") then
				local name = string.lower(d.Name or "")
				local img = tostring(d.Image or "")
				
				if RANK_ICON_IMAGES[img] then
					d.Visible = false
				elseif name:find("rank") or name:find("division") or name:find("elo") then
					d.Visible = false
				end
			end
		end
	end
	
	local function fixRoleTextScaling(originalGui)
		if not originalGui then return end
		
		for _, d in ipairs(originalGui:GetDescendants()) do
			if d:IsA("TextLabel") then
				local name = string.lower(d.Name or "")
				
				if name:find("title") or name:find("playertitle") or name:find("role") then
					d.TextScaled = true
					
					if TITLE_STROKE_TRANSP ~= nil then
						d.TextStrokeTransparency = TITLE_STROKE_TRANSP
					end
				end
			end
		end
	end
	
	local function hideOtherLocalBillboards(char)
		for _, inst in ipairs(char:GetDescendants()) do
			if inst:IsA("BillboardGui") and not CollectionService:HasTag(inst, "EntityNameTag") then
				if inst.Name ~= "LocalRankStreakGui" then
					inst.Enabled = false
				end
			end
		end
	end
	
	local function createHeadLockedGui(head)
		local existing = head:FindFirstChild("LocalRankStreakGui")
		if existing and existing:IsA("BillboardGui") then
			return existing
		end
		
		local bb = Instance.new("BillboardGui")
		bb.Name = "LocalRankStreakGui"
		bb.Parent = head
		bb.Adornee = head
		bb.AlwaysOnTop = true
		bb.ResetOnSpawn = false
		bb.MaxDistance = 1000
		
		bb.Size = UDim2.fromScale(7.2, 0.9)
		bb.StudsOffset = Vector3.new(0.44, 1.45, 0)
		
		local main = Instance.new("Frame")
		main.BackgroundTransparency = 1
		main.Size = UDim2.fromScale(1, 1)
		main.Parent = bb
		
		local row = Instance.new("Frame")
		row.Name = "Row"
		row.BackgroundTransparency = 1
		row.AnchorPoint = Vector2.new(0.5, 0.5)
		row.Position = UDim2.fromScale(0.525, 0.5)
		row.Size = UDim2.fromScale(1, 1)
		row.Parent = main
		
		local layout = Instance.new("UIListLayout")
		layout.FillDirection = Enum.FillDirection.Horizontal
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout.VerticalAlignment = Enum.VerticalAlignment.Center
		layout.Padding = UDim.new(0, 10)  
		layout.Parent = row
		
		local rank = Instance.new("ImageLabel")
		rank.Name = "RankIcon"
		rank.BackgroundTransparency = 1
		rank.Size = UDim2.fromScale(0.16, 0.95)
		rank.Parent = row
		local rAspect = Instance.new("UIAspectRatioConstraint")
		rAspect.AspectRatio = 1
		rAspect.Parent = rank
		
		local winGroup = Instance.new("Frame")
		winGroup.Name = "WinGroup"
		winGroup.BackgroundTransparency = 1
		winGroup.Size = UDim2.fromScale(0.28, 1.05)  
		winGroup.Parent = row
		
		local flame = Instance.new("ImageLabel")
		flame.Name = "WinFlame"
		flame.BackgroundTransparency = 1
		flame.Image = FLAME_IMAGE
		flame.AnchorPoint = Vector2.new(0, 0.5)
		flame.Position = UDim2.fromScale(0, 0.5)
		flame.Size = UDim2.fromScale(0.24, 1.05)
		flame.Parent = winGroup
		
		local fAspect = Instance.new("UIAspectRatioConstraint")
		fAspect.AspectRatio = FLAME_ASPECT_RATIO  
		fAspect.Parent = flame
		
		local num = Instance.new("TextLabel")
		num.Name = "WinStreak"
		num.BackgroundTransparency = 1
		num.Font = Enum.Font.Gotham
		num.TextColor3 = Color3.fromRGB(255, 255, 255)
		num.TextStrokeTransparency = 1
		num.TextXAlignment = Enum.TextXAlignment.Left
		num.TextYAlignment = Enum.TextYAlignment.Center
		
		num.TextScaled = true
		
		num.AnchorPoint = Vector2.new(0, 0.5)
		num.Position = UDim2.fromScale(0.28, 0.5) 
		num.Size = UDim2.new(0.72, 0, 0.94, 0)   
		num.Parent = winGroup
		
		local winLayout = Instance.new("UIListLayout")
		winLayout.FillDirection = Enum.FillDirection.Horizontal
		winLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		winLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		winLayout.Padding = UDim.new(0, 2)
		winLayout.Parent = winGroup
		
		return bb
	end
	
	local function forceWinTextStyle(gui) end
	
	local function updateGui(gui, data)
		if not gui then return end
		
		local streak = 0
		local division = -1
		if data then
			if data.winstreak ~= nil then streak = tonumber(data.winstreak) or 0 end
			if data.rankDivision ~= nil then division = tonumber(data.rankDivision) or -1 end
		end
		
		local rank = gui:FindFirstChild("RankIcon", true)
		if rank and rank:IsA("ImageLabel") then
			local key = divisionToRankKey(division)
			rank.Image = BedwarsImageId[key] or ""
		end
		
		local flame = gui:FindFirstChild("WinFlame", true)
		if flame and flame:IsA("ImageLabel") then
			flame.Image = FLAME_IMAGE
		end
		
		local num = gui:FindFirstChild("WinStreak", true)
		if num and num:IsA("TextLabel") then
			num.Text = tostring(streak)
		end
		
		forceWinTextStyle(gui)
	end
	
	local activeLoop = nil
	
	local function setup(char)
		local head = char:WaitForChild("Head", 5)
		if not head then return end
		
		local headGui = createHeadLockedGui(head)
		
		activeLoop = task.spawn(function()
			while char.Parent and OGNameTags.Enabled do
				task.wait(0.25)
				
				hideOtherLocalBillboards(char)
				
				local original = findLocalOriginalNametag(char)
				if original then
					hideMiddleNameAndLevel(original)
					hideOldWinStreakOnly(original)
					hideOldRankIconOnly(original)
				end
				
				requestNametagData(function(data)
					updateGui(headGui, data)
				end)
				
				forceWinTextStyle(headGui)
			end
		end)
	end
	
	local function cleanup()
		if activeLoop then
			task.cancel(activeLoop)
			activeLoop = nil
		end
		
		if LP.Character then
			local head = LP.Character:FindFirstChild("Head")
			if head then
				local customGui = head:FindFirstChild("LocalRankStreakGui")
				if customGui then
					customGui:Destroy()
				end
			end
		end
		
		if LP.Character then
			local original = findLocalOriginalNametag(LP.Character)
			if original then
				local attrW = original:GetAttribute("BaseSizeW")
				local attrH = original:GetAttribute("BaseSizeH")
				if attrW and attrH then
					original.Size = UDim2.fromScale(attrW, attrH)
				end
				
				for _, d in ipairs(original:GetDescendants()) do
					if d:IsA("GuiObject") then
						d.Visible = true
					end
				end
			end
		end
	end
	
	OGNameTags = vape.Categories.Render:CreateModule({
		Name = 'OGNameTags',
		Function = function(callback)
			if callback then
				if LP.Character then
					setup(LP.Character)
				end
				
				OGNameTags:Clean(LP.CharacterAdded:Connect(function(char)
					setup(char)
				end))
			else
				cleanup()
			end
		end,
		Tooltip = 'Custom nametag with rank icon and winstreak (lobby only)'
	})
	
	local TitleSizeSlider = OGNameTags:CreateSlider({
		Name = 'Title Scale',
		Min = 1.0,
		Max = 1.5,
		Default = 1.17,
		Decimal = 100,
		Function = function(val)
			ORIGINAL_NAMETAG_SCALE = val
			if LP.Character and OGNameTags.Enabled then
				local original = findLocalOriginalNametag(LP.Character)
				if original then
					scaleOriginalNametagSlightly(original)
					fixRoleTextScaling(original)
				end
			end
		end,
		Tooltip = 'Scale original nametag to make title/role bigger'
	})
end)

run(function()
	local TC
	local list
	local TABLE = {}
	local old
	TC = vape.Categories.Render:CreateModule({
	Name = "TitleChanger",
	Function = function(callback)
		if callback then
			if old then else old = lplr:GetAttribute("TitleType") end
				local att = list.Value or ""
				lplr:SetAttribute("TitleType",att)
				task.wait(.85) 
				if lplr:GetAttribute("TitleType") == old then
					att = list.Value or ""
					lplr:SetAttribute("TitleType",att)
				end
			else
				lplr:SetAttribute("TitleType",old)
				old = nil
			end
		end,
		Tooltip ='Client Sided Titles :D'
	})
	for _, v in pairs(bedwars.TitleTypes) do
		TABLE[#TABLE+1] = v
	end
	list = TC:CreateDropdown({
		Name = "Titles",
		List = TABLE,
		Function = function()
			if old then else old = lplr:GetAttribute("TitleType") end
				lplr:SetAttribute("TitleType",list.Value)
			end,
		})
end)

run(function()
	local LeaderboardSpoof
	local RS = game.ReplicatedStorage

	local CURRENT_BOARD = "Ranked"
	local CUSTOM_POSITION = 1
	local CUSTOM_STAT = 5000
	local SHOW_IN_LIST = true
	local savedFullLeaderboards = nil

	local ClientStore
	pcall(function() ClientStore = bedwars.Store end)

	local function getBoardKey()
		if CURRENT_BOARD == "Ranked" then
			local key = "RankPoints_S15"
			pcall(function()
				key = require(RS.TS.rank["rank-util"]).RankUtil.activeRankMeta.leaderboard
			end)
			return key, true
		elseif CURRENT_BOARD == "Overall Wins" then
			return "OverallWins", false
		elseif CURRENT_BOARD == "Monthly Wins" then
			return "Wins", false
		elseif CURRENT_BOARD == "Top Gifters" then
			return "gift_leaderboard", false
		end
		return nil, false
	end

	local function computeRankDisplay(totalRP)
		local result = nil
		pcall(function()
			local RankMeta = require(RS.TS.rank["rank-meta"]).RankMeta
			local divisionIndex = math.min(math.floor(totalRP / 100), 24) 
			local remainder = totalRP - divisionIndex * 100            
			local rankInfo = RankMeta[divisionIndex]
			if rankInfo then
				result = {
					image = rankInfo.image,
					rankName = rankInfo.name,
					rankStatValue = remainder,   
				}
			end
		end)
		return result
	end

	local function doDispatch()
		if not ClientStore then return end
		local boardKey, isRanked = getBoardKey()
		if not boardKey then return end

		local state = ClientStore:getState()
		local currentLeaderboards = state.Leaderboard and state.Leaderboard.leaderboards

		if not savedFullLeaderboards and currentLeaderboards then
			savedFullLeaderboards = {}
			for k, v in pairs(currentLeaderboards) do
				savedFullLeaderboards[k] = v
			end
		end

		local lp = game.Players.LocalPlayer
		local rankDisplay = isRanked and computeRankDisplay(CUSTOM_STAT) or nil

		local localUser = {
			username = lp.Name,
			avatarImage = "rbxthumb://type=AvatarHeadShot&id=" .. lp.UserId .. "&w=60&h=60",
			statValue = rankDisplay and rankDisplay.rankStatValue or CUSTOM_STAT,  
			userId = lp.UserId,
		}
		if rankDisplay then
			localUser.statRank = rankDisplay
		end

		local newLeaderboards = {}
		if currentLeaderboards then
			for k, v in pairs(currentLeaderboards) do
				newLeaderboards[k] = v
			end
		end

		local currentBoardData = currentLeaderboards and currentLeaderboards[boardKey]
		local users = {}
		if currentBoardData and currentBoardData.users then
			for _, u in ipairs(currentBoardData.users) do
				if u.userId ~= lp.UserId then
					table.insert(users, u)
				end
			end
		end

		if SHOW_IN_LIST then
			local pos = math.max(1, math.min(CUSTOM_POSITION, #users + 1))
			table.insert(users, pos, localUser)
		end

		local newData = {
			lastRefresh = os.time(),
			users = users,
			leaderboardPosition = CUSTOM_POSITION,
			localStatValue = rankDisplay and rankDisplay.rankStatValue or CUSTOM_STAT,  
		}
		if rankDisplay then
			newData.localStatRank = rankDisplay
		end
		if currentBoardData and currentBoardData.nextReset then
			newData.nextReset = currentBoardData.nextReset
		end

		newLeaderboards[boardKey] = newData

		ClientStore:dispatch({
			type = "UpdateAllLeaderboards",
			leaderboards = newLeaderboards,
		})
	end

	local function doRevert()
		if not ClientStore or not savedFullLeaderboards then return end
		ClientStore:dispatch({
			type = "UpdateAllLeaderboards",
			leaderboards = savedFullLeaderboards,
		})
		savedFullLeaderboards = nil
	end

	LeaderboardSpoof = vape.Categories.Minigames:CreateModule({
		Name = "LeaderboardSpoof",
		Function = function(enabled)
			if enabled then doDispatch() else doRevert() end
		end,
		Tooltip = "Spoof your leaderboard stats (client-sided only)"
	})

	LeaderboardSpoof:CreateDropdown({
		Name = "Board",
		List = {"Ranked", "Overall Wins", "Monthly Wins", "Top Gifters"},
		Default = "Ranked",
		Function = function(val)
			CURRENT_BOARD = val
			if LeaderboardSpoof.Enabled then doDispatch() end
		end
	})

	LeaderboardSpoof:CreateSlider({
		Name = "Position",
		Min = 1,
		Max = 200,
		Default = 1,
		Decimal = 1,
		Function = function(val)
			CUSTOM_POSITION = math.floor(val)
			if LeaderboardSpoof.Enabled then doDispatch() end
		end
	})

	LeaderboardSpoof:CreateSlider({
		Name = "Stat Value",
		Min = 1,
		Max = 50000,
		Default = 5000,
		Decimal = 1,
		Function = function(val)
			CUSTOM_STAT = math.floor(val)
			if LeaderboardSpoof.Enabled then doDispatch() end
		end
	})

	LeaderboardSpoof:CreateToggle({
		Name = "Show In List",
		Default = true,
		Function = function(state)
			SHOW_IN_LIST = state
			if LeaderboardSpoof.Enabled then doDispatch() end
		end
	})
end)

run(function()
	local NametagSpoof
	local SpoofRankDropdown

	local lplr = game.Players.LocalPlayer
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local CollectionService = game:GetService("CollectionService")

	local BedwarsImageId = require(ReplicatedStorage.TS.image["image-id"]).BedwarsImageId

	local RANK_MAP = {
		Bronze = "BRONZE_RANK",
		Silver = "SILVER_RANK",
		Gold = "GOLD_RANK",
		Platinum = "PLATINUM_RANK",
		Diamond = "DIAMOND_RANK",
		Emerald = "EMERALD_RANK",
		Nightmare = "NIGHTMARE_RANK"
	}

	local loop

	local function findNametag(char)
		local head = char:FindFirstChild("Head")
		if not head then return nil end

		for _, gui in ipairs(CollectionService:GetTagged("EntityNameTag")) do
			if gui:IsA("BillboardGui") and (gui.Adornee == head or gui:IsDescendantOf(char)) then
				return gui
			end
		end

		local direct = head:FindFirstChild("Nametag")
		if direct and direct:IsA("BillboardGui") then
			return direct
		end

		return nil
	end

	local function waitForNametag(char)
		for i = 1, 50 do 
			local tag = findNametag(char)
			if tag then return tag end
			task.wait(0.1)
		end
	end

	local function applySpoof(char)
		local head = char:WaitForChild("Head", 5)
		if not head then return end

		local original = waitForNametag(char)
		if not original then return end
		local old = head:FindFirstChild("NSSpoofGui")
		if old then old:Destroy() end
		local clone = original:Clone()
		clone.Name = "NSSpoofGui"
		clone.Adornee = head
		clone.Parent = head

		original.Enabled = false

		return clone
	end

	local function updateRank(spoof)
		if not spoof then return end

		for _, d in ipairs(spoof:GetDescendants()) do
			if d:IsA("ImageLabel") then
				for _, rankKey in pairs(RANK_MAP) do
					if d.Image == BedwarsImageId[rankKey] then
						d.Image = BedwarsImageId[RANK_MAP[SpoofRankDropdown.Value]]
					end
				end
			end
		end
	end

	local function startLoop(char)
		if loop then task.cancel(loop) end

		loop = task.spawn(function()
			local head = char:WaitForChild("Head", 5)
			if not head then return end

			while NametagSpoof.Enabled and char.Parent do
				task.wait(0.05)

				local spoof = head:FindFirstChild("NSSpoofGui")
				if spoof then
					updateRank(spoof)
				end
			end
		end)
	end

	local function cleanup(char)
		if loop then
			task.cancel(loop)
			loop = nil
		end

		if not char then return end
		local head = char:FindFirstChild("Head")
		if not head then return end

		local spoof = head:FindFirstChild("NSSpoofGui")
		if spoof then spoof:Destroy() end

		local original = findNametag(char)
		if original then
			original.Enabled = true
		end
	end

	NametagSpoof = vape.Categories.Render:CreateModule({
		Name = "NametagSpoof",
		Function = function(callback)
			if callback then
				if lplr.Character then
					task.spawn(function()
						local spoof = applySpoof(lplr.Character)
						if spoof then
							updateRank(spoof)
							startLoop(lplr.Character)
						end
					end)
				end

				NametagSpoof:Clean(lplr.CharacterAdded:Connect(function(char)
					task.spawn(function()
						local spoof = applySpoof(char)
						if spoof then
							updateRank(spoof)
							startLoop(char)
						end
					end)
				end))
			else
				cleanup(lplr.Character)
			end
		end
	})

	SpoofRankDropdown = NametagSpoof:CreateDropdown({
		Name = "Rank",
		List = {"Bronze","Silver","Gold","Platinum","Diamond","Emerald","Nightmare"},
		Default = "Nightmare"
	})
end)

run(function()
    local anim
    local asset
    local trackingConnection
    local lastPosition
    local NightmareEmote
    local cachedRootPart
    local cachedHumanoid
    local lastValidationCheck = 0
    
    NightmareEmote = vape.Categories.World:CreateModule({
        Name = "NightmareEmote",
        Function = function(call)
            if call then
                local l__GameQueryUtil__8
                if (not shared.CheatEngineMode) then 
                    l__GameQueryUtil__8 = require(game:GetService("ReplicatedStorage")['rbxts_include']['node_modules']['@easy-games']['game-core'].out).GameQueryUtil 
                else
                    local backup = {}; function backup:setQueryIgnored() end; l__GameQueryUtil__8 = backup;
                end
                local l__TweenService__9 = tweenService
                local player = playersService.LocalPlayer
                local character = player.Character
                
                if not character then 
                    NightmareEmote:Toggle() 
                    return 
                end
                
                local humanoid = character:WaitForChild("Humanoid")
                local rootPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")
                
                if not rootPart then 
                    NightmareEmote:Toggle() 
                    return 
                end
                
                cachedRootPart = rootPart
                cachedHumanoid = humanoid
                lastPosition = rootPart.Position
                lastValidationCheck = 0
                
                local v10 = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Effects"):WaitForChild("NightmareEmote"):Clone()
                asset = v10
                v10.Parent = game.Workspace
                
                local descendants = v10:GetDescendants()
                for _, part in ipairs(descendants) do
                    if part:IsA("BasePart") then
                        l__GameQueryUtil__8:setQueryIgnored(part, true)
                        part.CanCollide = false
                        part.Anchored = true
                    end
                end
                
                local l__Outer__15 = v10:FindFirstChild("Outer")
                if l__Outer__15 then
                    l__TweenService__9:Create(l__Outer__15, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
                        Orientation = l__Outer__15.Orientation + Vector3.new(0, 360, 0)
                    }):Play()
                end
                
                local l__Middle__16 = v10:FindFirstChild("Middle")
                if l__Middle__16 then
                    l__TweenService__9:Create(l__Middle__16, TweenInfo.new(12.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
                        Orientation = l__Middle__16.Orientation + Vector3.new(0, -360, 0)
                    }):Play()
                end
                
                anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://9191822700"
                anim = humanoid:LoadAnimation(anim)
                anim:Play()
                
                local movementThresholdSq = 0.1 * 0.1
                
                trackingConnection = runService.RenderStepped:Connect(function()
                    if not asset or not asset.Parent then 
                        if trackingConnection then
                            trackingConnection:Disconnect()
                        end
                        return 
                    end
                    
                    local currentTime = tick()
                    
                    if (currentTime - lastValidationCheck) > 0.5 then
                        if not character or not character.Parent then
                            asset:Destroy()
                            asset = nil
                            if trackingConnection then
                                trackingConnection:Disconnect()
                            end
                            NightmareEmote:Toggle()
                            return
                        end
                        
                        if not cachedRootPart or not cachedRootPart.Parent then
                            cachedRootPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")
                        end
                        
                        if not cachedHumanoid or not cachedHumanoid.Parent then
                            cachedHumanoid = character:FindFirstChildOfClass("Humanoid")
                        end
                        
                        if not cachedRootPart or not cachedHumanoid or cachedHumanoid.Health <= 0 then
                            asset:Destroy()
                            asset = nil
                            if trackingConnection then
                                trackingConnection:Disconnect()
                            end
                            NightmareEmote:Toggle()
                            return
                        end
                        
                        lastValidationCheck = currentTime
                    end
                    
                    if lastPosition and cachedRootPart then
                        local currentPosition = cachedRootPart.Position
                        local dx = currentPosition.X - lastPosition.X
                        local dy = currentPosition.Y - lastPosition.Y
                        local dz = currentPosition.Z - lastPosition.Z
                        local distanceMovedSq = dx * dx + dy * dy + dz * dz
                        
                        if distanceMovedSq > movementThresholdSq then
                            asset:Destroy()
                            asset = nil
                            if trackingConnection then
                                trackingConnection:Disconnect()
                            end
                            NightmareEmote:Toggle()
                            return
                        end
                        
                        lastPosition = currentPosition
                    end
                    
                    if cachedRootPart then
                        v10:SetPrimaryPartCFrame(cachedRootPart.CFrame * CFrame.new(0, -3, 0))
                    end
                end)
                
                NightmareEmote:Clean(trackingConnection)
                
            else 
                if trackingConnection then
                    trackingConnection:Disconnect()
                    trackingConnection = nil
                end
                
                if anim then 
                    anim:Stop()
                    anim = nil
                end
                
                if asset then
                    asset:Destroy() 
                    asset = nil
                end
                
                lastPosition = nil
                cachedRootPart = nil
                cachedHumanoid = nil
                lastValidationCheck = 0
            end
        end
    })
end)

run(function()
	local PlayerProfileSpoof
	local PPSRankDropdown
	local PPSRpSlider
	local PPSLeaderboardSlider

	local lplr = game.Players.LocalPlayer
	local PP_ReplicatedStorage = game:GetService("ReplicatedStorage")
	local PP_BedwarsImageId = require(PP_ReplicatedStorage.TS.image["image-id"]).BedwarsImageId

	local PP_RANK_MAP = {
		["Bronze 1"] = "BRONZE_RANK",   ["Bronze 2"] = "BRONZE_RANK",   ["Bronze 3"] = "BRONZE_RANK",
		["Silver 1"] = "SILVER_RANK",   ["Silver 2"] = "SILVER_RANK",   ["Silver 3"] = "SILVER_RANK",
		["Gold 1"]   = "GOLD_RANK",     ["Gold 2"]   = "GOLD_RANK",     ["Gold 3"]   = "GOLD_RANK",
		["Platinum 1"]= "PLATINUM_RANK",["Platinum 2"]= "PLATINUM_RANK",["Platinum 3"]= "PLATINUM_RANK",
		["Diamond 1"] = "DIAMOND_RANK", ["Diamond 2"] = "DIAMOND_RANK", ["Diamond 3"] = "DIAMOND_RANK",
		["Emerald 1"] = "EMERALD_RANK", ["Emerald 2"] = "EMERALD_RANK", ["Emerald 3"] = "EMERALD_RANK",
		["Nightmare"] = "NIGHTMARE_RANK"
	}

	local PP_RANK_COLORS = {
		Bronze   = Color3.fromRGB(188, 110, 60),
		Silver   = Color3.fromRGB(180, 180, 190),
		Gold     = Color3.fromRGB(255, 200, 0),
		Platinum = Color3.fromRGB(60, 220, 255),
		Diamond  = Color3.fromRGB(90, 150, 255),
		Emerald  = Color3.fromRGB(0, 200, 100),
	}

	local PP_RANK_IMAGES = {}
	for _, key in ipairs({"BRONZE_RANK","SILVER_RANK","GOLD_RANK","PLATINUM_RANK","DIAMOND_RANK","EMERALD_RANK","NIGHTMARE_RANK"}) do
		local img = PP_BedwarsImageId[key]
		if img and img ~= "" then PP_RANK_IMAGES[img] = true end
	end

	local ALL_RANK_NAMES = {}
	for k in pairs(PP_RANK_MAP) do ALL_RANK_NAMES[k] = true end

	local ppLoop = nil

	local function getBaseRank(rankName)
		return rankName:match("^(%a+)")
	end

	local function ppDoSpoof()
		local playerGui = lplr:FindFirstChild("PlayerGui")
		if not playerGui then return end

		local rankName    = PPSRankDropdown.Value
		local rankKey     = PP_RANK_MAP[rankName]
		local rpValue     = PPSRpSlider.Value
		local lbRank      = PPSLeaderboardSlider.Value
		local isNightmare = rankName == "Nightmare"
		local fillColor   = PP_RANK_COLORS[getBaseRank(rankName)]
		local fillScale   = math.clamp(rpValue / 100, 0, 1)

		for _, v in ipairs(playerGui:GetDescendants()) do
			if v:IsA("ImageLabel") and PP_RANK_IMAGES[v.Image] then
				v.Image = PP_BedwarsImageId[rankKey]

			elseif v:IsA("TextLabel") then
				local name = v.Name
				local txt  = v.Text
				if name == "CurrentRP" then
					if isNightmare then
						v.Visible = false
					else
						v.Visible = true
						v.Text = rpValue .. " RP / 100"
					end
				elseif name == "RankName" then
					v.Text = rankName
				elseif txt:find("Leaderboard Rank:") then
					v.Text = "Leaderboard Rank: " .. lbRank
				end

			elseif v:IsA("Frame") then
				local name = v.Name
				if name == "ProgressBar" then
					if isNightmare then
						v.Visible = false
					else
						v.Visible = true
						if fillColor then
							v.BackgroundColor3 = fillColor
						end
						v.Size = UDim2.new(fillScale, 0, v.Size.Y.Scale, v.Size.Y.Offset)
					end
				elseif name == "ProgressBarContainer" then
					v.Visible = not isNightmare
				end
			end
		end
	end

	local function ppStartLoop()
		if ppLoop then task.cancel(ppLoop) end
		ppLoop = task.spawn(function()
			while PlayerProfileSpoof.Enabled do
				task.wait(0.1)
				ppDoSpoof()
			end
		end)
	end

	local function ppCleanup()
		if ppLoop then task.cancel(ppLoop) ppLoop = nil end
	end

	PlayerProfileSpoof = vape.Categories.Render:CreateModule({
		Name = "PlayerProfileSpoof",
		Function = function(callback)
			if callback then ppStartLoop() else ppCleanup() end
		end,
		Tooltip = "Spoofs rank, RP bar color and leaderboard rank in your profile UI (client sided)"
	})

	PPSRankDropdown = PlayerProfileSpoof:CreateDropdown({
		Name = "Rank",
		List = {
			"Bronze 1","Bronze 2","Bronze 3",
			"Silver 1","Silver 2","Silver 3",
			"Gold 1","Gold 2","Gold 3",
			"Platinum 1","Platinum 2","Platinum 3",
			"Diamond 1","Diamond 2","Diamond 3",
			"Emerald 1","Emerald 2","Emerald 3",
			"Nightmare"
		},
		Default = "Nightmare"
	})

	PPSRpSlider = PlayerProfileSpoof:CreateSlider({
		Name = "RP", Min = 0, Max = 100, Default = 50
	})

	PPSLeaderboardSlider = PlayerProfileSpoof:CreateSlider({
		Name = "Leaderboard Rank", Min = 1, Max = 10000, Default = 1
	})
end)

run(function()
    local SetPlayerLevel
    local originalGetLevel = nil
    local customLevel = 1

    local function applyLevelOverride()
        local player = lplr
        if not player then return end
        local gamePlayer = bedwars.GamePlayerUtil.getGamePlayer(player)
        if gamePlayer and not originalGetLevel then
            originalGetLevel = gamePlayer.getLevel
            gamePlayer.getLevel = function(self)
                return customLevel
            end
        end
    end

    local function removeLevelOverride()
        if originalGetLevel then
            local player = lplr
            if player then
                local gamePlayer = bedwars.GamePlayerUtil.getGamePlayer(player)
                if gamePlayer then
                    gamePlayer.getLevel = originalGetLevel
                end
            end
            originalGetLevel = nil
        end
    end

    SetPlayerLevel = vape.Categories.Render:CreateModule({
        Name = "SetPlayerLevel",
        Function = function(state)
            if state then
                applyLevelOverride()
                SetPlayerLevel:Clean(lplr.CharacterAdded:Connect(function()
                    if SetPlayerLevel.Enabled then
                        applyLevelOverride()
                    end
                end))
            else
                removeLevelOverride()
            end
        end,
        Tooltip = "Spoof your player level (nametag updates on respawn)"
    })

    SetPlayerLevel:CreateSlider({
        Name = "Level",
        Min = 1,
        Max = 1000,
        Default = 1,
        Decimal = 1,
        Function = function(val)
            customLevel = math.floor(val)
            if SetPlayerLevel.Enabled then
            end
        end
    })
end)

run(function()
    local SetPlayerWins
    local originalWins = nil
    local customWins = 0
    local winsValue = nil 

    local function findWinsValue()
        local leaderstats = lplr:FindFirstChild("leaderstats")
        if leaderstats then
            return leaderstats:FindFirstChild("Wins") or leaderstats:FindFirstChild("OverallWins")
        end
        return nil
    end

    local function applyWinsOverride()
        winsValue = findWinsValue()
        if winsValue and winsValue:IsA("IntValue") then
            if originalWins == nil then
                originalWins = winsValue.Value
            end
            winsValue.Value = customWins
        else
            notif("SetPlayerWins", "Could not find Wins value", 3)
        end
    end

    local function restoreWins()
        if winsValue and winsValue:IsA("IntValue") and originalWins ~= nil then
            winsValue.Value = originalWins
        end
        winsValue = nil
        originalWins = nil
    end

    SetPlayerWins = vape.Categories.Minigames:CreateModule({
        Name = "SetPlayerWins",
        Function = function(state)
            if state then
                applyWinsOverride()
                SetPlayerWins:Clean(lplr.ChildAdded:Connect(function(child)
                    if child.Name == "leaderstats" and SetPlayerWins.Enabled then
                        applyWinsOverride()
                    end
                end))
            else
                restoreWins()
            end
        end,
        Tooltip = "Modify your wins in leaderstats (client‑sided)"
    })

    SetPlayerWins:CreateSlider({
        Name = "Wins",
        Min = 0,
        Max = 100000,
        Default = 0,
        Decimal = 1,
        Function = function(val)
            customWins = math.floor(val)
            if SetPlayerWins.Enabled and winsValue then
                winsValue.Value = customWins
            end
        end
    })
end)

run(function()
    local WinstreakSpoofer
    local Wins

    local oldSets = {
        Wins = nil,
        DoesExist = nil,
    }

    WinstreakSpoofer = vape.Categories.Minigames:CreateModule({
        Name = 'WinstreakSpoofer',
        Tooltip = 'Modifies/Adds your winstreak (client‑sided)',
        Function = function(callback)
            if callback then
                if not entitylib.isAlive then return end
                if lplr.Character.Head.Nametag then
                    local winStreakCounter = lplr.Character.Head.Nametag:FindFirstChild("WinStreakCounter")
                    if not winStreakCounter then
                        local main = Instance.new('Frame')
                        main.AnchorPoint = Vector2.new(1, 0.5)
                        main.Name = 'WinStreakCounter'
                        main.Size = UDim2.new(0.100000001, 0, 0.75, 0)
                        main.Position = UDim2.new(1.04999995, 0, 0.600000024, 0)
                        main.BackgroundTransparency = 1
                        main.Parent = lplr.Character.Head.Nametag
						main.LayoutOrder = 3
						main.BorderSizePixel =0
                        local icon = Instance.new('ImageLabel')
                        icon.BackgroundTransparency = 1
                        icon.Name = 'WinStreakFire'
                        icon.Size = UDim2.fromScale(1, 1)
                        icon.Image = 'rbxassetid://7101948108'
                        icon.ScaleType = Enum.ScaleType.Fit
						icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
                        icon.Parent = main
                        local value = Instance.new("TextLabel")
                        value.BackgroundTransparency = 1
                        value.Name = 'WinStreakValue'
                        value.Position = UDim2.fromScale(0.5, 0.375)
                        value.Size = UDim2.fromScale(0.8, 0.9)
                        value.FontFace = Font.new("Roboto", Enum.FontWeight.Bold)
                        value.TextSize = 8
                        oldSets.Wins = 0
                        value.Text = tostring(Wins.Value)
                        value.TextColor3 = Color3.fromRGB(255, 255, 255)
                        value.TextScaled = true
                        value.TextStrokeTransparency = 0.5
                        value.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        value.Parent = main
						value.AutoLocalize = false
						value.TextXAlignment = Enum.TextXAlignment.Center
						value.AnchorPoint = Vector2.new(0.5,0)
                        oldSets.DoesExist = false
                    else
                        oldSets.DoesExist = true
                        oldSets.Wins = winStreakCounter.WinStreakValue.Text
                        winStreakCounter.WinStreakValue.Text = tostring(Wins.Value)
                    end
                end
            else
                if lplr.Character.Head.Nametag then
                    local winStreakCounter = lplr.Character.Head.Nametag:FindFirstChild("WinStreakCounter")
                    if winStreakCounter then
                        if oldSets.DoesExist then
                            winStreakCounter.WinStreakValue.Text = oldSets.Wins
                        else
                            winStreakCounter:Destroy()
                        end
                    end
                end
                oldSets.Wins = nil
                oldSets.DoesExist = nil
            end
        end
    })

    Wins = WinstreakSpoofer:CreateSlider({
        Name = "Wins",
        Min = 0,
        Max = 100000,
        Default = 0,
        Decimal = 1,
        Function = function(val)
            if WinstreakSpoofer.Enabled then
                if lplr.Character.Head.Nametag then
                    local winStreakCounter = lplr.Character.Head.Nametag:FindFirstChild("WinStreakCounter")
	                if not winStreakCounter then
                        local main = Instance.new('Frame')
                        main.AnchorPoint = Vector2.new(1, 0.5)
                        main.Name = 'WinStreakCounter'
                        main.Size = UDim2.new(0.100000001, 0, 0.75, 0)
                        main.Position = UDim2.new(1.04999995, 0, 0.600000024, 0)
                        main.BackgroundTransparency = 1
                        main.Parent = lplr.Character.Head.Nametag
						main.LayoutOrder = 3
						main.BorderSizePixel =0
                        local icon = Instance.new('ImageLabel')
                        icon.BackgroundTransparency = 1
                        icon.Name = 'WinStreakFire'
                        icon.Size = UDim2.fromScale(1, 1)
                        icon.Image = 'rbxassetid://7101948108'
                        icon.ScaleType = Enum.ScaleType.Fit
						icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
                        icon.Parent = main
                        local value = Instance.new("TextLabel")
                        value.BackgroundTransparency = 1
                        value.Name = 'WinStreakValue'
                        value.Position = UDim2.fromScale(0.5, 0.375)
                        value.Size = UDim2.fromScale(0.8, 0.9)
                        value.FontFace = Font.new("Roboto", Enum.FontWeight.Bold)
                        value.TextSize = 8
                        oldSets.Wins = 0
                        value.Text = tostring(Wins.Value)
                        value.TextColor3 = Color3.fromRGB(255, 255, 255)
                        value.TextScaled = true
                        value.TextStrokeTransparency = 0.5
                        value.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        value.Parent = main
						value.AutoLocalize = false
						value.TextXAlignment = Enum.TextXAlignment.Center
						value.AnchorPoint = Vector2.new(0.5,0)
                        oldSets.DoesExist = false
                    else
                        winStreakCounter.WinStreakValue.Text = tostring(val)
                    end
                end
            end
        end
    })
end)

																									run(function()
	local Headless
	local faceTransparencyBackup = nil

	Headless = vape.Categories.Utility:CreateModule({
		PerformanceModeBlacklisted = true,
		Name = 'Headless',
		Tooltip = 'free headless 2026',
		Function = function(callback)
			if callback then
				local function applyHeadless()
					if not (entitylib.isAlive and entitylib.character and entitylib.character.Character and entitylib.character.Head) then return end
					local head = entitylib.character.Head
					if faceTransparencyBackup == nil then
						local face = head:FindFirstChild('face')
						if face and face:IsA("Decal") then
							faceTransparencyBackup = face.Transparency
						end
					end
					head.Transparency = 1
					local face = head:FindFirstChild('face')
					if face and face:IsA("Decal") then
						face.Transparency = 1
					end
				end

				applyHeadless()

				Headless:Clean(entitylib.Events.LocalAdded:Connect(function()
					faceTransparencyBackup = nil
					applyHeadless()
				end))

				Headless:Clean(vapeEvents.AttributeChanged.Event:Connect(function(attr)
					if attr == 'Health' then
						applyHeadless()
					end
				end))
			else
				if entitylib.isAlive and entitylib.character and entitylib.character.Character and entitylib.character.Head then
					entitylib.character.Head.Transparency = 0
					local face = entitylib.character.Head:FindFirstChild('face')
					if face and face:IsA("Decal") then
						face.Transparency = faceTransparencyBackup ~= nil and faceTransparencyBackup or 0
						faceTransparencyBackup = nil
					end
				end
			end
		end,
		Default = false
	})
end)

run(function()
    local AutoFarmQueue
    local queueLoop

    AutoFarmQueue = vape.Categories.World:CreateModule({
        Name = 'AutoFarm Queue',
        Tooltip = 'Spams queue to get into a game faster-old method btw',
        Function = function(callback)
            if callback then
                queueLoop = task.spawn(function()
                    while AutoFarmQueue.Enabled do
                        pcall(function()
                            local events = replicatedStorage:WaitForChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events", 5)
                            task.wait(3)
                            if events then
                                local joinQueue = events:FindFirstChild("joinQueue")
                                if joinQueue then
                                    joinQueue:FireServer({
                                        queueType = store.queueType
                                    })
                                end
                            end
                        end)
                        task.wait(5)
                    end
                end)
            end
        end
    })
end)

--// BEGIN NERV8 MERGED MODULES
-- Merged from Nerv8 6872265039.lua; universal.lua intentionally excluded.
-- These blocks are appended instead of replacing R12SA's existing modules.
local role = role or 'owner'
local oldpred = oldpred or prediction
local downloadFile = downloadFile or function(filePath, func)
	filePath = filePath:gsub('^ReVape/', 'newvape/')
	if isfile and isfile(filePath) then
		return (func or readfile)(filePath)
	end
	error('Missing merged Nerv8 dependency: '..tostring(filePath))
end
-- Nerv8 feature block count: 17

-- Nerv8 block 1: [Render] AutoGamble
	
run(function()
	local AutoGamble
	
	AutoGamble = vape.Categories.Render:CreateModule({
		Name = 'AutoGamble',
		Function = function(callback)
			if callback then
				AutoGamble:Clean(bedwars.Client:GetNamespace('RewardCrate'):Get('CrateOpened'):Connect(function(data)
					if data.openingPlayer == lplr then
						local tab = bedwars.CrateItemMeta[data.reward.itemType] or {displayName = data.reward.itemType or 'unknown'}
						notif('AutoGamble', 'Won '..tab.displayName, 5)
					end
				end))
	
				repeat
					if not bedwars.CrateAltarController.activeCrates[1] then
						for _, v in bedwars.Store:getState().Consumable.inventory do
							if v.consumable:find('crate') then
								bedwars.CrateAltarController:pickCrate(v.consumable, 1)
								task.wait(1.2)
								if bedwars.CrateAltarController.activeCrates[1] and bedwars.CrateAltarController.activeCrates[1][2] then
									bedwars.Client:GetNamespace('RewardCrate'):Get('OpenRewardCrate'):SendToServer({
										crateId = bedwars.CrateAltarController.activeCrates[1][2].attributes.crateId
									})
								end
								break
							end
						end
					end
					task.wait(1)
				until not AutoGamble.Enabled
			end
		end,
		Tooltip = 'Automatically opens lucky crates, piston inspired!'
	})
end)

-- Nerv8 block 2: [Render] Nightmare Emote

run(function()	
	NM = vape.Categories.Render:CreateModule({
		Name = 'Nightmare Emote',
		Tooltip = 'Client-Sided nightmare emote, animation is Server-Side visuals are Client-Sided',
		Function = function(callback)
			if callback then				
				local l__TweenService__9 = game:GetService("TweenService")
				local player = game:GetService("Players").LocalPlayer
				local p6 = player.Character
				
				if not p6 then return end
				
				local v10 = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Effects"):WaitForChild("NightmareEmote"):Clone();
				asset = v10
				v10.Parent = game.Workspace
				lastPosition = p6.PrimaryPart and p6.PrimaryPart.Position or Vector3.new()
				
				task.spawn(function()
					while asset ~= nil do
						local currentPosition = p6.PrimaryPart and p6.PrimaryPart.Position
						if currentPosition and (currentPosition - lastPosition).Magnitude > 0.1 then
							asset:Destroy()
							asset = nil
							NM:Toggle()
							break
						end
						lastPosition = currentPosition
						v10:SetPrimaryPartCFrame(p6.LowerTorso.CFrame + Vector3.new(0, -2, 0));
						task.wait()
					end
				end)
				
				local v11 = v10:GetDescendants();
				local function v12(p8)
					if p8:IsA("BasePart") then
						p8.CanCollide = false;
						p8.Anchored = true;
					end;
				end;
				for v13, v14 in ipairs(v11) do
					v12(v14, v13 - 1, v11);
				end;
				local l__Outer__15 = v10:FindFirstChild("Outer");
				if l__Outer__15 then
					l__TweenService__9:Create(l__Outer__15, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
						Orientation = l__Outer__15.Orientation + Vector3.new(0, 360, 0)
					}):Play();
				end;
				local l__Middle__16 = v10:FindFirstChild("Middle");
				if l__Middle__16 then
					l__TweenService__9:Create(l__Middle__16, TweenInfo.new(12.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
						Orientation = l__Middle__16.Orientation + Vector3.new(0, -360, 0)
					}):Play();
				end;
                anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://9191822700"
				anim = p6.Humanoid:LoadAnimation(anim)
				anim:Play()
			else 
                if anim then 
					anim:Stop()
					anim = nil
				end
				if asset then
					asset:Destroy() 
					asset = nil
				end
			end
		end
	})
end)

-- Nerv8 block 3: [AltFarm] AccountGrinding


run(function()
local AG
local QueueTypes
	AG = vape.Categories.AltFarm:CreateModule({
		Name = "AccountGrinding",
		Function = function(callback)
			if role ~= "owner" and role ~= "coowner" and role ~= "admin" and role ~= "friend" and role ~= "premium"then
				vape:CreateNotification("Onyx", "You do not have permission to use this", 10, "alert")
				return
			end       
			if QueueTypes.Value == "duels" then 
				bedwars.QueueController:joinQueue('bedwars_duels')
			elseif QueueTypes.Value == "1v1s" then 
				bedwars.QueueController:joinQueue('winstreak_1v1')
			end
		end,
		Tooltip ='Used for getting accounts having rank enabled'
	})
    QueueTypes = AG:CreateDropdown({
        Name = "Type",
        List = {'duels', '1v1s'},
    })

end)

-- Nerv8 block 4: [Exploits] Anti-Cheat Mods


																																						
run(function()
    local Users = {
        KnownUsers = {
            Chase = {22808138, 4782733628, 7447190808, 3196162848},
            Orion = {547598710, 5728889572, 4652232128, 7043591647, 7209929547, 7043958628, 7418525152, 3774791573, 8606089749},
            LisNix = {162442297, 702354331, 9350301723},
            Nwr = {307212658, 5097000699, 4923561416},
            Gorilla = {514679433, 2431747703, 4531785383},
            Typhoon = {2428373515, 7659437319},
            Erin = {2465133159},
            Ghost = {7558211130, 1708400489,9554637663},
            Sponge = {376388734, 5157136850},
            Gora = {589533315, 567497793},
            Apple = {334013471, 145981200, 4721068661, 8006518573, 3547758846, 7155624750, 7468661659},
            Dom = {239431610, 2621170992},
            Kevin = {575474067, 4785639950, 8735055832},
            Vic = {839818760, 1524739259},
        },
        UnknownUsers = {
            7547477786, 7574577126, 5816563976, 240526951, 7587479685, 7876617827,
            2568824396, 7604102307, 7901878324, 5087196317, 7187604802, 7495829767,
            7718511355, 7928472983, 7922414080, 7758683476, 4079687909, 1160595313
        }
    }

    local ACMOD
    local Side
    local Specific
    local IncludeOffline
    local IncludeStudio

    ACMOD = vape.Categories.Exploits:CreateModule({
        Name = 'Anti-Cheat Mods',
        Tooltip = "Fetches all AC mod users (including unknowns)",
        Function = function()
            vape:CreateNotification('ReVape', "Currently fetching mods", 3)
            task.wait(4)

            local HttpService = httpService
            local Players = game:GetService("Players")

            local Offline, InGame, Online, Studio = 0, 0, 0, 0
            local url = "https://presence.roproxy.com/v1/presence/users"
            local data = {userIds = {}}

            if Side and Side.Value == "Known" then
                if Specific and Specific.Value == "All" then
                    for _, numbers in pairs(Users.KnownUsers) do
                        for _, num in ipairs(numbers) do
                            table.insert(data.userIds, num)
                        end
                    end
                elseif Specific and Users.KnownUsers[Specific.Value] then
                    for _, num in ipairs(Users.KnownUsers[Specific.Value]) do
                        table.insert(data.userIds, num)
                    end
                end
            elseif Side and Side.Value == "Unknown" then
                for _, num in ipairs(Users.UnknownUsers) do
                    table.insert(data.userIds, num)
                end
            end

            if #data.userIds == 0 then
                vape:CreateNotification('No Users Selected', "Pick a Side/Specific to fetch", 5, "alert")
                return
            end

            local jsonData = HttpService:JSONEncode(data)
            local response
            local success, err = pcall(function()
                response = HttpService:PostAsync(url, jsonData, Enum.HttpContentType.ApplicationJson)
            end)

            if success and response then
                local okDecode, result = pcall(function()
                    return HttpService:JSONDecode(response)
                end)

                if not okDecode or not result then
                    vape:CreateNotification('Failed!', "Failed to decode presence JSON", 15, "alert")
                    return
                end

                if result.userPresences then
                    for _, user in pairs(result.userPresences) do
                        local username = tostring(user.userId)
                        local okName, nameOrErr = pcall(function()
                            return Players:GetNameFromUserIdAsync(user.userId)
                        end)
                        if okName and nameOrErr then
                            username = nameOrErr
                        end

                        if user.userPresenceType == 0 then
                            Offline = Offline + 1
                            if IncludeOffline and IncludeOffline.Value then
                                vape:CreateNotification('Offline Mod detected!', username, 5, "alert")
                            end
                        elseif user.userPresenceType == 1 then 
                            Online = Online + 1
                            vape:CreateNotification('Online Mod detected!', username, 15, "warning")
                        elseif user.userPresenceType == 2 then 
                            InGame = InGame + 1
                            vape:CreateNotification('InGame Mod detected!', username, 15, "warning")
                        elseif user.userPresenceType == 3 then 
                            Studio = Studio + 1
                            if IncludeStudio and IncludeStudio.Value then
                                vape:CreateNotification('Studio Mod detected!', username, 5, "warning")
                            end
                        end
                    end
                end

                task.wait(5)
                if InGame >= 2 then
                    vape:CreateNotification('Multiple Mods In-Game!', "There are [" .. InGame .. "] mods in game", 45)
                elseif InGame == 0 then
                    vape:CreateNotification('No Mods In-Game!', "There are none in-game", 45)
                end

                if Online >= 2 then
                    vape:CreateNotification('Multiple Mods Online!', "There are [" .. Online .. "] mods online", 45)
                elseif Online == 0 then
                    vape:CreateNotification('No Mods Online!', "There are none online", 45)
                end
            else
                vape:CreateNotification('ReVape', "Failed to get presence data: " .. tostring(err), 15, "alert")
            end
        end
    })

    Side = ACMOD:CreateDropdown({
        Name = "Version",
        List = {'Known', 'Unknown'},
    })

    Specific = ACMOD:CreateDropdown({
        Name = "Specific",
        Tooltip = 'Fetch a specific user (mains and alts)',
        List = {'All', 'Chase', 'Orion', 'LisNix', 'Nwr', 'Gorilla', 'Typhoon', 'Vic', 'Erin', 'Ghost', 'Sponge', 'Apple', 'Dom', 'Gora', 'Kevin'},
    })

    IncludeStudio = ACMOD:CreateToggle({
        Name = "Include Studio",
        Tooltip = "Include when a mod is in studio",
        Default = false
    })

    IncludeOffline = ACMOD:CreateToggle({
        Name = "Include Offline",
        Tooltip = "Include when a mod is offline",
        Default = false
    })
end)

-- Nerv8 block 5: [Utility] StaffDetectorV2, [Exploits] SetPlayerLevel

run(function()
    local UsersList = {
        22808138, 4782733628, 7447190808, 3196162848,
        547598710, 5728889572, 4652232128, 7043591647, 7209929547, 7043958628, 7418525152, 3774791573, 8606089749,
        162442297, 702354331, 9350301723,
        307212658, 5097000699, 4923561416,
        514679433, 2431747703, 4531785383,
        2428373515, 7659437319,
        2465133159,
        7558211130, 1708400489,
        376388734, 5157136850,
        589533315, 567497793,
        334013471, 145981200, 4721068661, 8006518573, 3547758846, 7155624750, 7468661659,
        239431610, 2621170992,
        575474067, 4785639950, 8735055832,
        839818760, 1524739259,
        7547477786, 7574577126, 5816563976, 240526951, 7587479685, 7876617827,
        2568824396, 7604102307, 7901878324, 5087196317, 7187604802, 7495829767,
        7718511355, 7928472983, 7922414080, 7758683476, 4079687909, 1160595313
    }

    local UsersSet = {}
    for _, id in ipairs(UsersList) do
        UsersSet[id] = true
    end

    local playersService = game:GetService("Players")
    local lplr = playersService.LocalPlayer
    local joined = {} 

    local StaffDetector
    local Party
    local IncludeSpecs
    local CreateLogsOfMODS

    local function notif(title, body, duration, typ)
        if vape and vape.CreateNotification then
            vape:CreateNotification(title, body, duration or 5, typ)
        else
            print(("NOTIF [%s] %s"):format(title, body))
        end
    end

    local function checkFriends(list)
        for _, v in ipairs(list) do
            local id = v
            if type(v) == "table" and v.Id then id = v.Id end
            if joined[id] then
                return joined[id]
            end
        end
        return nil
    end

local function staffFunction(plr, checktype, checktypee)
    if not vape or not vape.Loaded then
        repeat task.wait() until vape and vape.Loaded
    end
if checktype == "spectator_join" then

else
notif('StaffDetector', 'Staff Detected ('..checktype..'): '..plr.Name..' ('..plr.UserId..')', 60, checktypee)
end
    

    if whitelist and whitelist.customtags then
        whitelist.customtags[plr.Name] = {{text = 'GAME STAFF', color = Color3.new(1, 0, 0)}}
    end


    if Party and Party.Enabled then
        if checktype == "impossible_join" or checktype == "detected_mod_join" then
            if bedwars and bedwars.PartyController and bedwars.PartyController.leaveParty then
                pcall(function()
                    bedwars.PartyController:leaveParty()
                end)
            end
        end
    end

    if CreateLogsOfMODS and CreateLogsOfMODS.Enabled then
        local Format
        local date = DateTime.now():ToLocalTime():ToTable()
        local dateString = string.format("%02d/%02d/%04d %02d:%02d:%02d", 
            date.month, date.day, date.year, date.hour, date.min, date.sec
        )

        if checktype == "impossible_join" then
            Format = "[USERNAME]:"..plr.Name.."|"..
                     "[USERID]:"..plr.UserId.."|"..
                     "[DATE]:"..dateString.."|"..
                     "[TYPE]:[IMPOSSIBLE JOIN]\n"

        elseif checktype == "detected_mod_join" then
            Format = "[USERNAME]:"..plr.Name.."|"..
                     "[USERID]:"..plr.UserId.."|"..
                     "[DATE]:"..dateString.."|"..
                     "[TYPE]:[KNOWN MOD JOIN]\n"

        elseif checktype == "spectator_join" then
            Format = "[USERNAME]:"..plr.Name.."|"..
                     "[USERID]:"..plr.UserId.."|"..
                     "[DATE]:"..dateString.."|"..
                     "[TYPE]:[SPECTATOR JOIN]\n"
        end
if Format then
    local path = "newvape/profiles/logs.txt"

    if not isfolder("newvape/profiles") then
        makefolder("newvape/profiles")
    end

    if not isfile(path) then
        writefile(path, Format)
    else
        local prev = readfile(path)
        writefile(path, prev .. Format)
    end
end
     end
end
    local function checkJoin(plr, connection)
        if not plr or not plr.UserId then return false end

        local spectatorAttr = plr:GetAttribute('Spectator')
        local teamAttr = plr:GetAttribute('Team')
        local isCustomMatch = false
        if bedwars and bedwars.Store and bedwars.Store.getState then
            local ok, state = pcall(bedwars.Store.getState, bedwars.Store)
            if ok and state and state.Game and state.Game.customMatch then
                isCustomMatch = true
            end
        end

        if (not teamAttr) and spectatorAttr and not isCustomMatch then
            if connection then connection:Disconnect() end

            local tab = {}
            local success, pages = pcall(function()
                return playersService:GetFriendsAsync(plr.UserId)
            end)

            if not success or not pages then
                staffFunction(plr, 'impossible_join','warning')
                return true
            end

            for _ = 1, 4 do
                local currentPage = pages:GetCurrentPage()
                for _, v in ipairs(currentPage) do
                    table.insert(tab, v.Id or v.id or v.Id)
                end
                if pages.IsFinished then break end
                pages:AdvanceToNextPageAsync()
            end

            local friend = checkFriends(tab)
            if not friend then
                staffFunction(plr, 'impossible_join','warning')
                return true
            elseif UsersSet[plr.UserId] then
                staffFunction(plr, 'detected_mod_join','alert')
                return true
            else
                if IncludeSpecs and IncludeSpecs.Enabled then
                    notif('StaffDetector', string.format('Spectator %s joined from %s', plr.Name, tostring(friend)), 20, 'warning')
                    if CreateLogsOfMODS and CreateLogsOfMODS.Enabled then
                        staffFunction(plr, "spectator_join", 'info')
                    end
                end
            end
        end

        return false
    end

    local function playerAdded(plr)
        if not plr then return end
        joined[plr.UserId] = plr.Name
        if plr == lplr then return end

        local connection
        connection = plr:GetAttributeChangedSignal('Spectator'):Connect(function()
            checkJoin(plr, connection)
        end)
        if StaffDetector and StaffDetector.Clean then
            StaffDetector:Clean(connection)
        end

        if checkJoin(plr, connection) then
            return
        end
    end

    StaffDetector = vape.Categories.Utility:CreateModule({
        Name = 'StaffDetectorV2',
        Function = function(callback)
            if callback then
                if playersService and playersService.PlayerAdded then
                    StaffDetector:Clean(playersService.PlayerAdded:Connect(playerAdded))
                end
                for _, v in ipairs(playersService:GetPlayers()) do
                    task.spawn(playerAdded, v)
                end
            else
                table.clear(joined)
            end
        end,
        Tooltip = 'A Newer verison of Staff-Detector'
    })

    Party = StaffDetector:CreateToggle({
        Name = 'Leave party',
        Default = true,
    })
    IncludeSpecs = StaffDetector:CreateToggle({
        Name = 'Include Spectators',
        Tooltip = 'NOTE: Anti-Cheat mods could create new alts, ill say to keep this on to get the new username. BUT THIS CAN DO FALSE DETECTIONS!!',
        Default = true,
    })
    CreateLogsOfMODS = StaffDetector:CreateToggle({
        Name = 'Logs',
        Default = false,
        Tooltip = 'all this does is keep track of every mod/spectators has joined you with a date'
    })
end)

-- Nerv8 block 6: [Utility] QueueCardMods
run(function()
    local QueueDisplayConfig = {
        ActiveState = false,
        GradientControl = {Enabled = true},
        ColorSettings = {
            Gradient1 = {Hue = 0, Saturation = 0, Brightness = 1},
            Gradient2 = {Hue = 0, Saturation = 0, Brightness = 0.8}
        },
        Animation = {Speed = 0.5, Progress = 0}
    }

    local DisplayUtils = {
        createGradient = function(parent)
            local gradient = parent:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
            gradient.Parent = parent
            return gradient
        end,
        updateColor = function(gradient, config)
            local time = tick() * config.Animation.Speed
            local interp = (math.sin(time) + 1) / 2
            local h = config.ColorSettings.Gradient1.Hue + (config.ColorSettings.Gradient2.Hue - config.ColorSettings.Gradient1.Hue) * interp
            local s = config.ColorSettings.Gradient1.Saturation + (config.ColorSettings.Gradient2.Saturation - config.ColorSettings.Gradient1.Saturation) * interp
            local b = config.ColorSettings.Gradient1.Brightness + (config.ColorSettings.Gradient2.Brightness - config.ColorSettings.Gradient1.Brightness) * interp
            gradient.Color = ColorSequence.new(Color3.fromHSV(h, s, b))
        end
    }

	local CoreConnection

    local function enhanceQueueDisplay()
		pcall(function() 
			CoreConnection:Disconnect()
		end)
        local success, err = pcall(function()
            if not lplr.PlayerGui:FindFirstChild('QueueApp') then return end
            
            for attempt = 1, 3 do
                if QueueDisplayConfig.GradientControl.Enabled then
                    local queueFrame = lplr.PlayerGui.QueueApp['1']
                    queueFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    
                    local gradient = DisplayUtils.createGradient(queueFrame)
                    gradient.Rotation = 180
                    
                    local displayInterface = {
                        module = vape.watermark,
                        gradient = gradient,
                        GetEnabled = function()
                            return QueueDisplayConfig.ActiveState
                        end,
                        SetGradientEnabled = function(state)
                            QueueDisplayConfig.GradientControl.Enabled = state
                            gradient.Enabled = state
                        end
                    }
                    CoreConnection = game:GetService("RunService").RenderStepped:Connect(function()
                        if QueueDisplayConfig.ActiveState and QueueDisplayConfig.GradientControl.Enabled then
                            DisplayUtils.updateColor(gradient, QueueDisplayConfig)
                        end
                    end)
                end
                task.wait(0.1)
            end
        end)
        
        if not success then
            warn("Queue display enhancement failed: " .. tostring(err))
        end
    end

    local QueueDisplayEnhancer
    QueueDisplayEnhancer = vape.Categories.Utility:CreateModule({
        Name = 'QueueCardMods',
        Tooltip = 'Enhances the Queues display with dynamic gradients!!',
        Function = function(enabled)
            QueueDisplayConfig.ActiveState = enabled
            if enabled then
                enhanceQueueDisplay()
                QueueDisplayEnhancer:Clean(lplr.PlayerGui.ChildAdded:Connect(enhanceQueueDisplay))
			else
				pcall(function() 
					CoreConnection:Disconnect()
				end)
			end
        end
    })

   	QueueDisplayEnhancer:CreateSlider({
        Name = "Animation Speed",
        Function = function(speed)
            QueueDisplayConfig.Animation.Speed = math.clamp(speed, 0.1, 5)
        end,
        Min = 1,
        Max = 6,
        Default = 5
    })

    QueueDisplayEnhancer:CreateColorSlider({
        Name = "Color 1",
        Function = function(h, s, v)
            QueueDisplayConfig.ColorSettings.Gradient1 = {Hue = h, Saturation = s, Brightness = v}
        end
    })

    QueueDisplayEnhancer:CreateColorSlider({
        Name = "Color 2",
        Function = function(h, s, v)
            QueueDisplayConfig.ColorSettings.Gradient2 = {Hue = h, Saturation = s, Brightness = v}
        end
    })
end)

-- Nerv8 block 7: [Exploits] ViewProfile


run(function()
	local ViewProfiles
	local lplr = game.Players.LocalPlayer
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local function create(name, props)
		local obj = Instance.new(name)
		for k, v in pairs(props) do
			if type(k) == "number" then
				v.Parent = obj
			else
				obj[k] = v
			end
		end
		return obj
	end

	local function CreateProfile()
		local Profile = create("ScreenGui", {
			Name = "Profile",
			DisplayOrder = 30,
			ResetOnSpawn = false,
			Parent = lplr:WaitForChild("PlayerGui"),
			IgnoreGuiInset = true
		})

		local BackgroundProfileUI = create("ImageButton", {
			Name = "Background",
			AutoButtonColor = false,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 0.6,
			BackgroundColor3 = Color3.new(0, 0, 0),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(2, 2),
			Parent = Profile
		})

		local MainProfileFrame = create("Frame", {
			Name = "Main",
			Parent = Profile,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1)
		})

		local MainMainBG = create("ImageButton", {
			Name = "MainBG",
			AutoButtonColor = false,
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.05),
			Size = UDim2.fromOffset(800, 700),
			Parent = MainProfileFrame
		})

		create("UIAspectRatioConstraint", { Parent = MainMainBG, AspectRatio = 1.143 })
		create("UIScale", { Parent = MainMainBG, Scale = 1.297 })

		local IconButtonWrapper = create("ImageButton", {
			Name = "IconButtonWrapper",
			Parent = MainMainBG,
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -4, 0, 4),
			Size = UDim2.fromOffset(40, 40)
		})
		create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = IconButtonWrapper })
		create("UIPadding", {
			PaddingBottom = UDim.new(0.1, 0),
			PaddingLeft = UDim.new(0.1, 0),
			PaddingRight = UDim.new(0.1, 0),
			PaddingTop = UDim.new(0.1, 0),
			Parent = IconButtonWrapper
		})
		create("ImageLabel", {
			Name = "Icon",
			Parent = IconButtonWrapper,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			ZIndex = 100,
			Image = "rbxassetid://6693945013",
			ImageTransparency = 0.2
		})

		local FrameMainBG = create("Frame", {
			Parent = MainMainBG,
			BackgroundColor3 = Color3.fromRGB(100, 103, 167),
			Size = UDim2.fromScale(1, 1)
		})
		create("UICorner", { CornerRadius = UDim.new(0.05, 0), Parent = FrameMainBG })
		create("UIListLayout", {
			Parent = FrameMainBG,
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder
		})

		local UserFrame = create("Frame", {
			Name = "UserFrame",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(78, 80, 130),
			Parent = FrameMainBG
		})
		create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = UserFrame })

		local BGImage = create("ImageLabel", {
			Name = "BGImage",
			Parent = UserFrame,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.05, 0.05),
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Image = "rbxassetid://71356717298935",
			ScaleType = Enum.ScaleType.Crop,
			ImageTransparency = 0.38
		})
		create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = BGImage })

		create("TextLabel", {
			Name = "Title",
			Parent = UserFrame,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.043, 0, 0, 0),
			Size = UDim2.new(0, 703, 0, 46),
			Text = "⚠️⚠️ PLEASE NOTE: USER MUST BE INGAME ⚠️⚠️",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.SemiBold),
			TextScaled = true
		})

		local err = create("TextLabel", {
			Name = "Error",
			Parent = UserFrame,
			Visible = false,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.066, 0, 0.3, 0),
			Size = UDim2.new(0, 703, 0, 46),
			TextColor3 = Color3.fromRGB(213, 48, 48),
			Text = "[ERROR]:",
			FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.SemiBold),
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Left
		})

		local RequestHistory = create("TextButton", {
			Name = "RequestHistory",
			Parent = UserFrame,
			BackgroundTransparency = 0.15,
			BackgroundColor3 = Color3.fromRGB(85, 170, 127),
			Position = UDim2.new(0.066, 0, 0.176, 0),
			Size = UDim2.new(0, 683, 0, 62),
			Text = "Request history",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic),
			TextSize = 24
		})
		create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = RequestHistory })

		local textbox = create("TextBox", {
			Name = "UserTextbox",
			Parent = UserFrame,
			BackgroundColor3 = Color3.fromRGB(95, 99, 159),
			Position = UDim2.new(0.066, 0, 0.066, 0),
			ShowNativeInput = false,
			Size = UDim2.new(0, 685, 0, 54),
			Text = "",
			PlaceholderText = "@Roblox",
			TextColor3 = Color3.fromRGB(155, 155, 155),
			TextSize = 32,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Italic)
		})


		local function HandleRequest()
			local plrrr = Players:FindFirstChild(textbox.Text)
			if not plrrr then
				notif('Onyx', "Player does not exist ingame", 10, "alert")
				return
			end

			bedwars.PlayerProfileUIController:openPlayerProfile(plrrr)
			ViewProfiles:Toggle(false)
		end
																				
		ViewProfiles:Clean(textbox.FocusLost:Connect(function(enterPressed)
			if enterPressed then
				HandleRequest()
			end
		end))

		ViewProfiles:Clean(RequestHistory.MouseButton1Click:Connect(HandleRequest))

		ViewProfiles:Clean(IconButtonWrapper.MouseButton1Click:Connect(function()
			ViewProfiles:Toggle()
		end))
	end

	local function DestroyProfile()
		local p = lplr.PlayerGui:FindFirstChild("Profile")
		if p then p:Destroy() end
	end

	ViewProfiles = vape.Categories.Exploits:CreateModule({
		Name = "ViewProfile",
		Function = function(callback)
			   			if role ~= "owner" and role ~= "coowner" and role ~= "admin" and role ~= "friend" and role ~= "premium"then
				vape:CreateNotification("Onyx", "You do not have permission to use this", 10, "alert")
				return
			end  
			if callback then
				CreateProfile()
			else
				DestroyProfile()
			end
		end,
		Tooltip = "Allows you to see other players' profiles"
	})
end)

-- Nerv8 block 8: [Utility] SetFPS

run(function()
	local SetFPS
	local FPS
	
	SetFPS = vape.Categories.Utility:CreateModule({
		Name = "SetFPS",
		Function = function(callback)
			

			if callback then
				setfpscap(FPS.Value)
			else
				setfpscap(240)
			end
		end,
		Tooltip = "Removes or customizes the Frame-Per-Second limit",
	})
	
	FPS = SetFPS:CreateSlider({
		Name = "Frames Per Second",
		Min = 0,
		Max = 420,
		Default = 240,
		Function = function(value)
			setfpscap(value)
		end
	})
end)

-- Nerv8 block 9: [Render] PlayerData

run(function()
    local TypeData
    local PlayerData
    local includeEmptyMatches
	local Clean
    PlayerData = vape.Categories.Render:CreateModule({
        Name = "PlayerData",
        Function = function(callback)
			if role ~= "owner" and role ~= "coowner" and role ~= "admin" and role ~= "friend" and role ~= "premium"then
				vape:CreateNotification("Onyx", "You do not have permission to use this", 10, "alert")
				return
			end  
	    	if not callback then return end

            local http = httpService
            local store = bedwars.Store:getState()

            if TypeData.Value == "important" then
                local stats = {}
                local totals = {
                    TotalWins = 0,
                    TotalLosses = 0,
                    TotalMatches = 0,
                    TotalBedBreaks = 0,
                    TotalFinalKills = 0
                }

                local leaderboard = store and store.Leaderboard and store.Leaderboard.queues

                if leaderboard then
                    for mode, data in pairs(leaderboard) do
                        local wins = data.wins or 0																
                        local losses = data.losses or 0
						local ties = data.ties or 0
                        local matches = data.matches or (wins + losses + ties)
                        local winrate = (wins + losses > 0) and ((wins / (wins + losses)) * 100) or 0
						local earlyleaves = data.earlyLeaves or 0
                        local bedBreaks = data.bedBreaks or 0
                        local finalKills = data.finalKills or 0

                        totals.TotalWins += wins
                        totals.TotalLosses += losses
                        totals.TotalMatches += matches
                        totals.TotalBedBreaks += bedBreaks
                        totals.TotalFinalKills += finalKills

                        if includeEmptyMatches.Value or (wins > 0 or losses > 0 or matches > 0) then
                            stats[mode] = {
                                Winrate = string.format("%.2f%%", winrate),
                                Wins = wins,
                                Losses = losses,
								Ties = ties,
                                Matches = matches,
								EarlyLeaves = earlyleaves,
                                BedBreaks = bedBreaks,
                                FinalKills = finalKills
                            }
                        end
                    end
                end

                local achievements = {}
                if store and store.Bedwars and store.Bedwars.achievements then
                    for _, ach in pairs(store.Bedwars.achievements) do
                        table.insert(achievements, ach)
                    end
                elseif leaderboard and leaderboard.bedwars_duels and leaderboard.bedwars_duels.obtainedAchievements then
                    achievements = leaderboard.bedwars_duels.obtainedAchievements
                end

                local dataOut = {
					GameModes = stats,
                    Totals = totals,
                    Achievements = achievements
                }
				if Clean then
					local json = http:JSONEncode(dataOut)
	                json = json:gsub(',"', ',\n    "')
	                json = json:gsub('{', '{\n    ')
	                json = json:gsub('}', '\n}')
	
	                writefile("newvape/profiles/PlayerData.txt", json)
	                vape:CreateNotification("PlayerData", "Created PlayerData.txt file at profiles", 10)
					else
						local json = dataOut
						
                		writefile("newvape/profiles/PlayerData.txt", json)
                		vape:CreateNotification("PlayerData", "Created PlayerData.txt file at profiles", 10)
					end
            elseif TypeData.Value == "full" then

				if Clean then
					local json = http:JSONEncode(bedwars.Store:getState())
	                json = json:gsub(',"', ',\n    "')
	                json = json:gsub('{', '{\n    ')
	                json = json:gsub('}', '\n}')
	
	                writefile("newvape/profiles/PlayerDataJSON.txt", json)
	                vape:CreateNotification("PlayerData", "Created PlayerData.json file at profiles", 10)
					else
						local json = http:JSONEncode(bedwars.Store:getState())
						
                		writefile("newvape/profiles/PlayerDataJSON.txt", json)
                		vape:CreateNotification("PlayerData", "Created PlayerData.json file at profiles", 10)
					end
            end
		PlayerData:Toggle()
        end,
        Tooltip = "Creates a file that has your data"
    })

    TypeData = PlayerData:CreateDropdown({
        Name = "Type",
        List = {"important", "full"}
    })

    includeEmptyMatches = PlayerData:CreateToggle({
        Name = "EmptyMatches",
        Default = false,
        Tooltip = "ONLY FOR IMPORTANT TYPE (adds 0-stats matches to your file)"
    })
	Clean = PlayerData:CreateToggle({
        Name = "Clean",
        Default = true,
        Tooltip = "Cleans up the JSON file"
    })
end)

-- Nerv8 block 10: [Exploits] Switch Kits

run(function()
	local CK
	local kit
	
	local KitsTable = {
		['no kit'] = 'none',
	    ['none'] = 'none',
	    ['nokit'] = 'none',
		['uma'] = 'spirit_summoner',
		['zeno'] = 'wizard',
	    ['wizard'] = 'wizard',
		['bounty hunter'] = 'bounty_hunter',
	    ['bounty'] = 'bounty_hunter',
	    ['hunter'] = 'bounty_hunter',
	    ['shielder'] = 'shielder',
	    ['infernal'] = 'shielder',
	    ['inferno'] = 'shielder',
	    ['infernal shielder'] = 'shielder',
		['inferno shielder'] = 'shielder',
		['merchant'] = 'merchant',
	    ['marco'] = 'merchant',
	    ['merchant marco'] = 'merchant',
		['miner'] = 'miner',
	    ['isabel'] = 'sword_shield',
	    ['defender'] = 'defender',
		['marcel'] = 'defender',
	    ['skeleton'] = 'skeleton',
	    ['marrow'] = 'skeleton',
		['boolymon'] = 'skeleton', -- gas the jews...
	    ['berserker'] = 'berserker',
	    ['ragnar'] = 'berserker',
	    ['rangar'] = 'berserker',
	    ['scarab'] = 'scarab',
	    ['abaddon'] = 'scarab',
	    ['ade'] = 'frost_hammer_kit',
	    ['adetunde'] = 'frost_hammer_kit',
	    ['arachne'] = 'spider_queen',
	    ['spider'] = 'spider_queen',
	    ['archer'] = 'archer',
	    ['axolotl'] = 'axolotl',
	    ['amy'] = 'axolotl',
 	   	['axolotl amy'] = 'axolotl',
	    ['axo'] = 'axolotl',
	    ['baker'] = 'baker',
	    ['barbarian'] = 'barbarian',
	    ['barb'] = 'barbarian',
	    ['builder'] = 'builder',
	    ['crypt'] = 'necromancer',
	    ['cyber'] = 'cyber',
	    ['bigman'] = 'bigman',
		['death adder'] = 'sorcerer',
		['adder'] = 'sorcerer',
		['elder'] = 'bigman',
	    ['eldertree'] = 'bigman',
	    ['eldric'] = 'warlock',
	    ['ember'] = 'ember',
	    ['evelynn'] = 'spirit_assassin',
	    ['eve'] = 'spirit_assassin',
	    ['farmer'] = 'farmer_cletus',
	    ['cletus'] = 'farmer_cletus',
	    ['farmer cletus'] = 'farmer_cletus',
	    ['freiya'] = 'ice_queen',
	    ['reaper'] = 'grim_reaper',
	    ['grim'] = 'grim_reaper',
	    ['grim reaper'] = 'grim_reaper',
	    ['grove'] = 'spirit_gardener',
	    ['hannah'] = 'hannah',
	    ['kaida'] = 'summoner',
	    ['krystal'] = 'glacial_skater',	
		['crystal'] = 'glacial_skater',
	    ['lassy'] = 'cowgirl',
		['lian'] = 'dragon_sword',
	    ['lumen'] = 'lumen',
	    ['lyla'] = 'flower_bee',
		['marina'] = 'jellyfish',
		['martin'] = 'cactus',
		['melody'] = 'melody',
		['milo'] = 'mimic',
	    ['nahla'] = 'oasis',
	    ['nazar'] = 'nazar',
		['davey'] = 'davey',
		['best kit'] = 'davey',
		['ramil'] = 'airbender',
		['sheila'] = 'seahorse',
	    ['elk'] = 'elk_master',
	    ['sigrid'] = 'elk_master',
		['silas'] = 'rebellion_leader',
		['skoll'] = 'void_hunter',
	    ['taliyah'] = 'taliyah',
	    ['chicken'] = 'taliyah',
		['kfc'] = 'taliyah',
		['trinity'] = 'angel',
	    ['angel'] = 'angel',
	    ['triton'] = 'harpoon',
		['trixie'] = 'void_walker',
	    ['vanessa'] = 'triple_shot',
	    ['void knight'] = 'void_knight',
		['regent'] = 'regent',
		['knight'] = 'void_knight',
	    ['void'] = 'regent',
	    ['vr'] = 'regent',
		['vk'] = 'void_knight',
	    ['vulcan'] = 'vulcan',
	    ['owl'] = 'owl',
		['bird'] = 'owl',
	    ['whisper'] = 'owl',
	    ['wren'] = 'black_market_trader',
		['yuzi'] = 'dasher',
	    ['dasher'] = 'dasher',
	    ['zarrah'] = 'gun_blade',
		['zenith'] = 'disruptor',
	    ['aery'] = 'aery',
	    ['agni'] = 'agni',
	    ['alchemist'] = 'alchemist',
	    ['alc'] = 'alchemist',
	    ['ares'] = 'spearman',
	    ['beekeeper'] = 'beekeeper',
	    ['beatrix'] = 'beekeeper',
	    ['beekeeper beatrix'] = 'beekeeper',
	    ['bee'] = 'beekeeper',
	    ['falconer'] = 'falconer',
	    ['bekzat'] = 'falconer',
	    ['assassin'] = 'blood_assassin',
	    ['cait'] = 'blood_assassin',
	    ['caitlyn'] = 'blood_assassin',
	    ['robot'] = 'battery',
	    ['cobalt'] = 'battery',
	    ['cogsworth'] = 'steam_engineer',
	    ['vesta'] = 'vesta',
	    ['conqueror'] = 'vesta',
	    ['conq'] = 'vesta',
	    ['croc'] = 'beast',
	    ['croco'] = 'beast',
	    ['crocowolf'] = 'beast',
	    ['wolf'] = 'beast',
	    ['beast'] = 'beast',
	    ['dino'] = 'dino_tamer',
	    ['dom'] = 'dino_tamer',
	    ['dino tamer dom'] = 'dino_tamer',
	    ['drill'] = 'drill',
	    ['elektra'] = 'elektra',
	    ['fisherman'] = 'fisherman',
	    ['fisher'] = 'fisherman',
	    ['flora'] = 'queen_bee',
	    ['fortuna'] = 'card',
	    ['frosty'] = 'frosty',
	    ['snowman'] = 'frosty',
	    ['ginger'] = 'gingerbread_man',
	    ['gingerbread'] = 'gingerbread_man',
	    ['gingerbread man'] = 'gingerbread_man',
	    ['ghost catcher'] = 'ghost_catcher',
	    ['ghost'] = 'ghost_catcher',
	    ['gompy'] = 'ghost_catcher',
	    ['hephaestus'] = 'tinker',
	    ['tinker'] = 'tinker',
	    ['ignis'] = 'ignis',
	    ['ghost walker'] = 'ignis',
	    ['oil man'] = 'oil_man',
	    ['oil'] = 'oil_man',
	    ['jack'] = 'oil_man',
	    ['jade'] = 'jade',
	    ['fire dragon'] = 'dragon_slayer',
	    ['kaliyah'] = 'dragon_slayer',
	    ['lani'] = 'paladin',
	    ['lucia'] = 'pinata',
		['pinata'] = 'pinata',
	    ['metal'] = 'metal_detector',
	    ['detector'] = 'metal_detector',
	    ['metal detector'] = 'metal_detector',
	    ['noelle'] = 'slime_tamer',
	    ['slime tamer'] = 'slime_tamer',
	    ['nyoka'] = 'nyoka',
	    ['midnight'] = 'midnight',
		['nyx'] = 'midnight',
	    ['pyro'] = 'pyro',
	    ['flamethrower'] = 'pyro',
	    ['raven'] = 'raven',
	    ['santa'] = 'santa',
	    ['ohsxnta'] = 'santa', -- OH SANTA LOOL
	    ['sheep'] = 'sheep_herder',
	    ['sheep herder'] = 'sheep_herder',
	    ['smoke'] = 'smoke',
		['spirit catcher'] = 'spirit_catcher',
	    ['sc'] = 'spirit_catcher',
	    ['spirit'] = 'spirit_catcher',
		['star'] = 'star_collector',
		['star collector'] = 'star_collector',
		['stella'] = 'star_collector',
		['styx'] = 'styx',
		['terra'] = 'block_kicker',
		['trapper'] = 'trapper',
		['umbra'] = 'hatter',
		['ninja'] = 'ninja',
		['umeko'] = 'ninja',
		['jailor'] = 'jailor',
		['warden'] = 'jailor',
		['warrior'] = 'warrior',
		['whim'] = 'mage',
		['mage'] = 'mage',
		['void dragon'] = 'void_dragon',
		['dragon'] = 'void_dragon',
		['xurot'] = 'axolotl',
		["xu'rot"] = 'void_dragon',
		['cat'] = 'cat',
		['yamini'] = 'cat',
		['yeti'] = 'yeti',
		['ice demon'] = 'yeti',
		['19thou'] = 'yeti', -- no penguin kit sadly yeti is the nearest tho
		['wind walker'] = 'wind_walker',
		['zephyr'] = 'wind_walker',
		[''] = 'none',
	}
	
	CK = vape.Categories.Exploits:CreateModule({
	    Name = "Switch Kits",
	    Function = function(callback)
			if role ~= "owner" and role ~= "coowner" and role ~= "admin" and role ~= "friend" and role ~= "premium"then
				vape:CreateNotification("Onyx", "You do not have permission to use this", 10, "alert")
				return
			end  																	
			if not callback then return end
			local name = string.lower(kit.Value)
			local NewKit = KitsTable[name] or "none"
					
	        if callback then
	            local args = {
					[1] = {
					    ["kit"] = NewKit
					}
				}
					
				game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.BedwarsActivateKit:InvokeServer(unpack(args))
				kit.Placeholder = NewKit
	        end
	    end,
	    Tooltip = "This is for reconnecting, you can switch ur kit with this",
	})
	
	kit = CK:CreateTextBox({
		Name = "Kit",
		Tooltip = "Changes kit for reconnecting to a new match",
		Placeholder = lplr:GetAttribute("PlayingAsKits"),
	})
end)

-- Nerv8 block 11: [Legit] Piston Effect

run(function()
    local function CreateUI()
        local Players = cloneref(game:GetService("Players"))
        local LocalPlayer = lplr

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "CustomGui"
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        screenGui.IgnoreGuiInset = true 
        screenGui.ResetOnSpawn = false

        local frame = Instance.new("Frame")
        frame.Name = "MainFrame"
        frame.Size = UDim2.new(0, 150, 0, 150)
        frame.Position = UDim2.new(0, 0, 0, 0) 
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.BorderSizePixel = 0
        frame.ZIndex = 1
        frame.Parent = screenGui

        local playerLevel = LocalPlayer:GetAttribute("PlayerLevel") or 0

        local image = Instance.new("ImageLabel")
        image.Name = "IconImage"
        image.Size = UDim2.new(0, 48, 0, 48)
        image.Position = UDim2.new(0.5, -24, 0, 5)
        image.BackgroundTransparency = 1
        image.Image = "rbxassetid://138775259837229"
        image.Parent = frame

        local function createStyledLabel(name, text, posY)
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = name
            textLabel.Size = UDim2.new(1, -10, 0, 20)
            textLabel.Position = UDim2.new(0, 5, 0, posY)
            textLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            textLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            textLabel.TextStrokeTransparency = 0.7
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.GothamMedium
            textLabel.BorderSizePixel = 0
            textLabel.Text = text
            textLabel.Parent = frame
        end

        createStyledLabel("PlayerLevelLabel", "Lvl: " .. tostring(playerLevel), 60)
        lplr:GetAttributeChangedSignal("PlayerLevel"):Connect(function()
            playerLevel = lplr:GetAttribute("PlayerLevel") or 0
            createStyledLabel("PlayerLevelLabel", "Lvl: " .. playerLevel, 60)
        end)
    end
	local Piston
	Piston = vape.Categories.Legit:CreateModule({
		Name = 'Piston Effect',
		Function = function(callback)
			if callback then
	           	CreateUI()
			else
				lplr.PlayerGui:FindFirstChild('CustomGui'):Destroy()
	        end
		end,
		Tooltip = 'Creates a piston frame!'
	})
end)

-- Nerv8 block 12: [Render] CustomTags

run(function()
	local CustomTags
	local Color
	local TAG
	local old, old2
	local tagConnections = {}
	local tagRenderConn
	local tagGuiConn


	local function Color3ToHex(r, g, b)
		return string.lower(string.format("#%02X%02X%02X", r, g, b))
	end

	local function CompleteTagEffect()
		if not lplr:FindFirstChild("Tags") then return end
		local tagObj = lplr.Tags:FindFirstChild("0")
		if not tagObj then return end

		if not old then
			old = tagObj.Value
			old2 = tagObj:GetAttribute("Text")
		end

		local color = Color3.fromHSV(Color.Hue, Color.Sat, Color.Value)
		local R = math.floor(color.R * 255)
		local G = math.floor(color.G * 255)
		local B = math.floor(color.B * 255)

		tagObj.Value = string.format("<font color='rgb(%d,%d,%d)'>[%s]</font>",R, G, B, TAG.Value)
		tagObj:SetAttribute("Text", TAG.Value)
		lplr:SetAttribute("ClanTag", TAG.Value)

		if tagRenderConn then
			tagRenderConn:Disconnect()
			tagRenderConn = nil
		end
		if tagGuiConn then
			tagGuiConn:Disconnect()
			tagGuiConn = nil
		end

		tagGuiConn = lplr.PlayerGui.ChildAdded:Connect(function(child)
			if child.Name ~= "TabListScreenGui" or not child:IsA("ScreenGui") then return end
			tagRenderConn = runService.RenderStepped:Connect(function()
				local nameToFind = (lplr.DisplayName == "" or lplr.DisplayName == lplr.Name) and lplr.Name or lplr.DisplayName
				for _, v in ipairs(child:GetDescendants()) do
					if v:IsA("TextLabel") and string.find(string.lower(v.Text), string.lower(nameToFind)) then
						v.Text = string.format('<font transparency="0.3" color="%s">[%s]</font> %s',Color3ToHex(R, G, B),TAG.Value,nameToFind)
					end
				end
			end)
		end)
	end
	
	local function RemoveTagEffect()
		if tagRenderConn then
			tagRenderConn:Disconnect()
			tagRenderConn = nil
		end

		if tagGuiConn then
			tagGuiConn:Disconnect()
			tagGuiConn = nil
		end

		if lplr:FindFirstChild("Tags") then
			local tagObj = lplr.Tags:FindFirstChild("0")
			if tagObj then
				if old then
					tagObj.Value = old
				end
				if old2 then
					tagObj:SetAttribute("Text", old2)
				end
			end
		end

		if lplr:GetAttribute("ClanTag") then
			lplr:SetAttribute("ClanTag", old)
		end

		old = nil
		old2 = nil
	end

	CustomTags = vape.Categories.Render:CreateModule({
		Name = "CustomTags",
		Tooltip = "Client-Sided visual custom clan tag on-chat",
		Function = function(callback)
			if callback then
				CompleteTagEffect()
			else
 				RemoveTagEffect()
			end
		end
	})

	Color = CustomTags:CreateColorSlider({
		Name = 'Color',
		Function = function()
			if CustomTags.Enabled then
				CompleteTagEffect()
			end
		end
	})

	TAG = CustomTags:CreateTextBox({
		Name = 'Tag',
		Default = "KKK",
		Function = function()
			if CustomTags.Enabled then
				CompleteTagEffect()
			end
		end
	})
end)

-- Nerv8 block 13: [AltFarm] OldAutoWin

run(function()
    local AutoWin
	local dropdown
	AutoWin = vape.Categories.AltFarm:CreateModule({
        Name = "OldAutoWin",
            Function = function(callback)
                if role ~= "owner" and role ~= "coowner" and role ~= "admin" and role ~= "friend" and role ~= "premium" then
                    vape:CreateNotification("Onyx", "You do not have permission to use this", 10, "alert")
                    return
                end
			if dropdown.Value == "duels" then
            	bedwars.QueueController:joinQueue("bedwars_duels")
			else
				bedwars.QueueController:joinQueue("skywars_to2")
			end
        end,
        Tooltip = "Lobby Autowin for queueing"
	})
	dropdown = AutoWin:CreateDropdown({
		Name = "Game Mode",
		List = {"duels",'skywars'},
		Function = function()
			writefile('newvape/profiles/autowin.txt',dropdown.Value)
		end
	})
end)

-- Nerv8 block 14: [Exploits] FakeLeaderboard
    
run(function()
    local FakeLeaderboard
	local num
	local connection
	local old = {
		PlayerName = nil,
		Thumbnail = nil
	}
	local function Fake(slot)
		if connection then
			connection:Disconnect()
			connection = nil
		end
		local Thumbnail = playersService:GetUserThumbnailAsync(lplr.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size420x420)
		local rlb = workspace:FindFirstChild('Lobby'):FindFirstChild('Boards'):FindFirstChild('WinsLeaderboard'):FindFirstChild('Meshes/Board'):FindFirstChild('LeaderboardApp'):FindFirstChild('1'):FindFirstChild('1'):FindFirstChild('2'):FindFirstChild('AutoCanvasScrollingFrame')
		for i, v in rlb:GetDescendants() do
			if v:IsA("ImageLabel") and v.Name == "PlayerAvatar" then
				old.Thumbnail = v.Image
				old.PlayerName = v.Parent:FindFirstChild('PlayerUsername').Text
				connection = runService.RenderStepped:Connect(function()
					v.Image = Thumbnail
					v.Parent:FindFirstChild('PlayerUsername').Text = lplr.Name
				end)
			end
		end
	end

	local function ReVert(slot)
		if connection then
			connection:Disconnect()
			connection = nil
			local newthumb = old.Thumbnail
			local newName = old.PlayerName
			local rlb = workspace:FindFirstChild('Lobby'):FindFirstChild('Boards'):FindFirstChild('WinsLeaderboard'):FindFirstChild('Meshes/Board'):FindFirstChild('LeaderboardApp'):FindFirstChild('1'):FindFirstChild('1'):FindFirstChild('2'):FindFirstChild('AutoCanvasScrollingFrame')
			for i, v in rlb:GetDescendants() do
				if v:IsA("ImageLabel") and v.Name == "PlayerAvatar" then
					v.Image = newthumb
					v.Parent:FindFirstChild('PlayerUsername').Text = newName
					old.Thumbnail = nil
					old.PlayerName = nil
				end
			end
		end
	end

	FakeLeaderboard = vape.Categories.Exploits:CreateModule({
        Name = "FakeLeaderboard",
        Function = function(callback)
            if role ~= "owner" and role ~= "coowner" and role ~= "admin" and role ~= "friend" and role ~= "premium" then
                vape:CreateNotification("Onyx", "You do not have permission to use this", 10, "alert")
                return
            end
			if callback then
				Fake(num.Value)
			else
				ReVert(num.Value)
			end
		end,
        Tooltip = "fakes you onto the rank leaderboard\nclient only"
	})
	num = FakeLeaderboard:CreateTextBox({
		Name = "Slot",
		Tooltip = 'what placement you will be at',
	})
end)

-- Nerv8 block 15: [Exploits] ViewHistory
																										
	run(function()
		local MHA
		MHA = vape.Categories.Exploits:CreateModule({
			Name = "ViewHistory",
			Function = function(callback)
				if role ~= "owner" and role ~= "coowner" and role ~= "admin" and role ~= "friend" then
					vape:CreateNotification("Onyx", "You do not have permission to use this", 10, "alert")
					return
				end
				if callback then
					bedwars.MatchHistroyController:requestMatchHistory(lplr.Name):andThen(function(Data)
						if Data then
							bedwars.AppController:openApp({
								app = bedwars.MatchHistroyApp,
								appId = "MatchHistoryApp",
							}, Data)
						end
					end)
					MHA:Toggle(false)
				else
					return
				end
			end,
			Tooltip = "allows you to see peoples history without being in the same game with you"
		})																								
	end)

-- Nerv8 block extra: [Exploits] SetPlayerLevel
run(function()
    local UsersList = {
        22808138, 4782733628, 7447190808, 3196162848,
        547598710, 5728889572, 4652232128, 7043591647, 7209929547, 7043958628, 7418525152, 3774791573, 8606089749,
        162442297, 702354331, 9350301723,
        307212658, 5097000699, 4923561416,
        514679433, 2431747703, 4531785383,
        2428373515, 7659437319,
        2465133159,
        7558211130, 1708400489,
        376388734, 5157136850,
        589533315, 567497793,
        334013471, 145981200, 4721068661, 8006518573, 3547758846, 7155624750, 7468661659,
        239431610, 2621170992,
        575474067, 4785639950, 8735055832,
        839818760, 1524739259,
        7547477786, 7574577126, 5816563976, 240526951, 7587479685, 7876617827,
        2568824396, 7604102307, 7901878324, 5087196317, 7187604802, 7495829767,
        7718511355, 7928472983, 7922414080, 7758683476, 4079687909, 1160595313
    }

    local UsersSet = {}
    for _, id in ipairs(UsersList) do
        UsersSet[id] = true
    end

    local playersService = game:GetService("Players")
    local lplr = playersService.LocalPlayer
    local joined = {} 

    local StaffDetector
    local Party
    local IncludeSpecs
    local CreateLogsOfMODS

    local function notif(title, body, duration, typ)
        if vape and vape.CreateNotification then
            vape:CreateNotification(title, body, duration or 5, typ)
        else
            print(("NOTIF [%s] %s"):format(title, body))
        end
    end

    local function checkFriends(list)
        for _, v in ipairs(list) do
            local id = v
            if type(v) == "table" and v.Id then id = v.Id end
            if joined[id] then
                return joined[id]
            end
        end
        return nil
    end

local function staffFunction(plr, checktype, checktypee)
    if not vape or not vape.Loaded then
        repeat task.wait() until vape and vape.Loaded
    end
if checktype == "spectator_join" then

else
notif('StaffDetector', 'Staff Detected ('..checktype..'): '..plr.Name..' ('..plr.UserId..')', 60, checktypee)
end
    

    if whitelist and whitelist.customtags then
        whitelist.customtags[plr.Name] = {{text = 'GAME STAFF', color = Color3.new(1, 0, 0)}}
    end


    if Party and Party.Enabled then
        if checktype == "impossible_join" or checktype == "detected_mod_join" then
            if bedwars and bedwars.PartyController and bedwars.PartyController.leaveParty then
                pcall(function()
                    bedwars.PartyController:leaveParty()
                end)
            end
        end
    end

    if CreateLogsOfMODS and CreateLogsOfMODS.Enabled then
        local Format
        local date = DateTime.now():ToLocalTime():ToTable()
        local dateString = string.format("%02d/%02d/%04d %02d:%02d:%02d", 
            date.month, date.day, date.year, date.hour, date.min, date.sec
        )

        if checktype == "impossible_join" then
            Format = "[USERNAME]:"..plr.Name.."|"..
                     "[USERID]:"..plr.UserId.."|"..
                     "[DATE]:"..dateString.."|"..
                     "[TYPE]:[IMPOSSIBLE JOIN]\n"

        elseif checktype == "detected_mod_join" then
            Format = "[USERNAME]:"..plr.Name.."|"..
                     "[USERID]:"..plr.UserId.."|"..
                     "[DATE]:"..dateString.."|"..
                     "[TYPE]:[KNOWN MOD JOIN]\n"

        elseif checktype == "spectator_join" then
            Format = "[USERNAME]:"..plr.Name.."|"..
                     "[USERID]:"..plr.UserId.."|"..
                     "[DATE]:"..dateString.."|"..
                     "[TYPE]:[SPECTATOR JOIN]\n"
        end
if Format then
    local path = "newvape/profiles/logs.txt"

    if not isfolder("newvape/profiles") then
        makefolder("newvape/profiles")
    end

    if not isfile(path) then
        writefile(path, Format)
    else
        local prev = readfile(path)
        writefile(path, prev .. Format)
    end
end
     end
end
    local function checkJoin(plr, connection)
        if not plr or not plr.UserId then return false end

        local spectatorAttr = plr:GetAttribute('Spectator')
        local teamAttr = plr:GetAttribute('Team')
        local isCustomMatch = false
        if bedwars and bedwars.Store and bedwars.Store.getState then
            local ok, state = pcall(bedwars.Store.getState, bedwars.Store)
            if ok and state and state.Game and state.Game.customMatch then
                isCustomMatch = true
            end
        end

        if (not teamAttr) and spectatorAttr and not isCustomMatch then
            if connection then connection:Disconnect() end

            local tab = {}
            local success, pages = pcall(function()
                return playersService:GetFriendsAsync(plr.UserId)
            end)

            if not success or not pages then
                staffFunction(plr, 'impossible_join','warning')
                return true
            end

            for _ = 1, 4 do
                local currentPage = pages:GetCurrentPage()
                for _, v in ipairs(currentPage) do
                    table.insert(tab, v.Id or v.id or v.Id)
                end
                if pages.IsFinished then break end
                pages:AdvanceToNextPageAsync()
            end

            local friend = checkFriends(tab)
            if not friend then
                staffFunction(plr, 'impossible_join','warning')
                return true
            elseif UsersSet[plr.UserId] then
                staffFunction(plr, 'detected_mod_join','alert')
                return true
            else
                if IncludeSpecs and IncludeSpecs.Enabled then
                    notif('StaffDetector', string.format('Spectator %s joined from %s', plr.Name, tostring(friend)), 20, 'warning')
                    if CreateLogsOfMODS and CreateLogsOfMODS.Enabled then
                        staffFunction(plr, "spectator_join", 'info')
                    end
                end
            end
        end

        return false
    end

    local function playerAdded(plr)
        if not plr then return end
        joined[plr.UserId] = plr.Name
        if plr == lplr then return end

        local connection
        connection = plr:GetAttributeChangedSignal('Spectator'):Connect(function()
            checkJoin(plr, connection)
        end)
        if StaffDetector and StaffDetector.Clean then
            StaffDetector:Clean(connection)
        end

        if checkJoin(plr, connection) then
            return
        end
    end

    StaffDetector = vape.Categories.Utility:CreateModule({
        Name = 'StaffDetectorV2',
        Function = function(callback)
            if callback then
                if playersService and playersService.PlayerAdded then
                    StaffDetector:Clean(playersService.PlayerAdded:Connect(playerAdded))
                end
                for _, v in ipairs(playersService:GetPlayers()) do
                    task.spawn(playerAdded, v)
                end
            else
                table.clear(joined)
            end
        end,
        Tooltip = 'A Newer verison of Staff-Detector'
    })

    Party = StaffDetector:CreateToggle({
        Name = 'Leave party',
        Default = true,
    })
    IncludeSpecs = StaffDetector:CreateToggle({
        Name = 'Include Spectators',
        Tooltip = 'NOTE: Anti-Cheat mods could create new alts, ill say to keep this on to get the new username. BUT THIS CAN DO FALSE DETECTIONS!!',
        Default = true,
    })
    CreateLogsOfMODS = StaffDetector:CreateToggle({
        Name = 'Logs',
        Default = false,
        Tooltip = 'all this does is keep track of every mod/spectators has joined you with a date'
    })
end)


run(function()
  local Players = game:GetService("Players")
local player = Players.LocalPlayer
    local PlayerLevel
	local level 
  local old

PlayerLevel = vape.Categories.Exploits:CreateModule({
        Name = 'SetPlayerLevel',
	Tooltip = "Sets your player level to 100 (client sided)",
        Function = function(callback)
if callback then
				notif("SetPlayerLevel", "This is client sided (only u will see the new level)", 3,"warning")
	old = game.Players.LocalPlayer:GettAttribute("PlayerLevel")				
game.Players.LocalPlayer:SetAttribute("PlayerLevel", level.Value)
else
	game.Players.LocalPlayer:SetAttribute("PlayerLevel", old)
	old = nil
end
	end
})

level = PlayerLevel:CreateSlider({
        Name = 'Player Level',
        Min = 1,
        Max = 1000,
        Default = 100,
	Function = function(val)
	    player:SetAttribute("PlayerLevel", val)
	end
    })

-- Nerv8 block extra: [Utility] Staff Fetcher
run(function()
	local function OnlineMods(Mod)
		local url = "https://onyxclient.fsl58.workers.dev/fetch?mods=" .. Mod

		local success, response = pcall(function()
			return request({
				Url = url,
				Method = "GET"
			})
		end)

		if not success or not response or response.StatusCode ~= 200 then
			warn("Request failed")
			return {}
		end

		local success2, data = pcall(function()
			return httpService:JSONDecode(response.Body)
		end)

		if not success2 or not data or not data.mods then
			warn("Invalid JSON response")
			return {}
		end

		local online = {}

		for _, mod in ipairs(data.mods) do
			local status = mod.status
			if status and status.presenceType and status.presenceType ~= "Offline" then
				table.insert(online, mod)

				vape:CreateNotification("StaffFetcher", string.format("[Mod Online]: Username: %s | Presence: %s",mod.username,status.presenceType),7.5)
			end
		end

		if #online == 0 then
			vape:CreateNotification("StaffFetcher", Mod.." Has no current online accounts!",3.23)
		end

		return online
	end
	local StaffFetcher
	local Type
	local Mod
	StaffFetcher = vape.Categories.Utility:CreateModule({
		Name = 'Staff Fetcher',
		Function = function(callback)
			if role ~= "owner" and role ~= "coowner" and role ~= "admin" and role ~= "friend" and role ~= "premium"then
				vape:CreateNotification("Onyx", "You do not have permission to use this", 10, "alert")
				return
			end 
			if not callback then return end
			if Type.Value == "Known" then
				OnlineMods(Mod.Value)
			else
				OnlineMods("nns")
			end
		end,
		Tooltip = 'Fetches Online status of known/unknown mods'
	})
	Mod = StaffFetcher:CreateDropdown({
		Name = "Type",
		List = {"Chase","Orion","LisNix","Nwr","Gorilla",'Typhoon',"Vic","Erin","Ghost","Sponge","Gora","Apple","Dom","Kevin"},
	})
	Type = StaffFetcher:CreateDropdown({
		Name = "Type",
		List = {"Known","Unknown"},
		Function = function()
			if Type.Value == "Known" then
				Mod.Visible = true
			else
				Mod.Visible = false
			end
		end
	})

end)


--// END NERV8 MERGED MODULES

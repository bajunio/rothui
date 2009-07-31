
  -- oUF_D3Orbs2 layout by roth - 2009
  
  -----------------------------
  -- VARIABLES + CONFIG
  -----------------------------
  
  local myname, _ = UnitName("player")
  local _, myclass = UnitClass("player")
  local dudustance, vehiclepower, playerinvehicle
  
  -- 0 = off
  -- 1 = on
  
  --size of the orbs
  local orbsize = 150
  
  --font used
  local d3font = "FONTS\\FRIZQT__.ttf"  
  
  --player scale
  local playerscale = 0.82
  --target and castbar scale
  local targetscale = 0.82  
  --focus, focustarget, pet and partyscale
  local focusscale = 0.5
  
  --activate this if you want to use rbottombarstyler
  --rember that you need to use jExp2 instead of jExp too. 
  local use_rbottombarstyler = 0
  
  --animated portraits yes/no
  local use_3dportraits = 1
  
  --automatic mana detection on stance/class (only works with glows active)
  local automana = 1
  
  --activate the orb glow
  local useglow = 1
  
  --variable to lighten the orb glow. the higher the value, the lighter the glow gets.
  local fog_smoother = 1.3
  
  --hide party in raids yes/no
  local hidepartyinraid = 1
  
  -- healthcolor defines what healthcolor will be used
  -- 1 = red, 2 = green, 3 = blue, 4 = yellow, 5 = runic
  local healthcolor = 2

  -- manacolor defines what manacolor will be used
  -- 1 = red, 2 = green, 3 = blue, 4 = yellow, 5 = runic
  local manacolor = 3
  
  -- usebar defines what actionbar texture will be used. 
  -- not really needed anymore, 36 texture will only be used if MultiBarRight is shown
  -- usebar = 1 -> choose automatically
  -- usebar = 2 -> 12 button texture always
  -- usebar = 3 -> 24 button texture always
  -- usebar = 4 -> 36 button texture always
  local usebar = 1
  
  local orbtab = {
    [1] = {r = 0.3, g = 0, b = 0, scale = 0.8, z = -12, x = 0.8, y = -1.7, anim = "SPELLS\\RedRadiationFog.m2"}, -- red
    [2] = {r = 0, g = 0.3, b = 0.1, scale = 0.75, z = -12, x = 0, y = -1.1, anim = "SPELLS\\GreenRadiationFog.m2"}, -- green
    [3] = {r = 0, g = 0.2,   b = 0.3, scale = 0.75, z = -12, x = 1.2, y = -1, anim = "SPELLS\\BlueRadiationFog.m2"}, -- blue
    [4] = {r = 0.4, g = 0.3, b = 0, scale = 0.75, z = -12, x = -0.3, y = -1.2, anim = "SPELLS\\OrangeRadiationFog.m2"}, -- yellow
    [5] = {r = 0, g = 0.7,   b = 0.7, scale = 0.9, z = -12, x = -0.5, y = -0.8, anim = "SPELLS\\WhiteRadiationFog.m2"}, -- runic
  }
  
  local tabvalues = {
    power = {
      [-2] = rPowerBarColor["AMMO"], -- fuel
      [-1] = rPowerBarColor["FUEL"], -- fuel
      [0] = rPowerBarColor["MANA"], -- Mana
      [1] = rPowerBarColor["RAGE"], -- Rage
      [2] = rPowerBarColor["FOCUS"], -- Focus
      [3] = rPowerBarColor["ENERGY"], -- Energy
      [4] = rPowerBarColor["HAPPINESS"], -- Happiness
      [5] = rPowerBarColor["RUNES"], -- dont know
      [6] = rPowerBarColor["RUNIC_POWER"], -- deathknight
    },
    happiness = {
      [0] = {r = 1, g = 1, b = 1}, -- bla test
      [1] = {r = 1, g = 0, b = 0}, -- need.... | unhappy
      [2] = {r = 1, g = 1, b = 0}, -- new..... | content
      [3] = {r = 0, g = 1, b = 0}, -- colors.. | happy
    },
    frame_positions = {
      [1] =   { a1 = "BOTTOM",  a2 = "BOTTOM",  af = "UIParent",                  x = 260,    y = -9      }, --player mana orb
      [2] =   { a1 = "BOTTOM",  a2 = "BOTTOM",  af = "UIParent",                  x = -260,   y = -9      }, --player health orb
      [3] =   { a1 = "CENTER",  a2 = "CENTER",  af = "UIParent",                  x = 0,      y = -200    }, --target frame
      [4] =   { a1 = "RIGHT",   a2 = "LEFT",    af = "oUF_D3Orbs2_TargetFrame",   x = -80,    y = 0       }, --tot
      [5] =   { a1 = "LEFT",    a2 = "RIGHT",   af = "UIParent",                  x = 50,     y = 100     }, --pet
      [6] =   { a1 = "LEFT",    a2 = "LEFT",    af = "UIParent",                  x = 60,     y = -100    }, --focus
      [7] =   { a1 = "TOPLEFT", a2 = "TOPLEFT", af = "UIParent",                  x = 30,     y = 50      }, --party
      [8] =   { a1 = "BOTTOM",  a2 = "BOTTOM",  af = "UIParent",                  x = 270,    y = 0       }, --angel
      [9] =   { a1 = "BOTTOM",  a2 = "BOTTOM",  af = "UIParent",                  x = -265,   y = 0       }, --demon
      [10] =  { a1 = "BOTTOM",  a2 = "BOTTOM",  af = "UIParent",                  x = 0,      y = -5      }, --botomline texture
      [11] =  { a1 = "BOTTOM",  a2 = "BOTTOM",  af = "UIParent",                  x = 1,      y = 0       }, --bottom bar background texture
      [12] =  { a1 = "CENTER",  a2 = "CENTER",  af = "oUF_D3Orbs2_TargetFrame",   x = 0,      y = 100     }, --castbar target
      [13] =  { a1 = "CENTER",  a2 = "CENTER",  af = "oUF_D3Orbs2_TargetFrame",   x = 0,      y = -80    },  --castbar player
      [14] =  { a1 = "CENTER",  a2 = "CENTER",  af = "oUF_D3Orbs2_TargetFrame",   x = 0,      y = 180     }, --castbar focus
    },
  }
  
  playerinvehicle = 0
  
  -----------------------------
  -- VARIABLES + CONFIG END
  -----------------------------
  
  --rewrite unit popup menus
  -- First level menus
  UnitPopupMenus["SELF"] = { "PVP_FLAG", "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "DUNGEON_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "LEAVE", "CANCEL" };
  UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL" };
  UnitPopupMenus["PARTY"] = { "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "LOOT_PROMOTE", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" };
  UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" };
  UnitPopupMenus["RAID_PLAYER"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" };
  UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "CANCEL" };
  UnitPopupMenus["FRIEND"] = { "WHISPER", "INVITE", "TARGET", "IGNORE", "REPORT_SPAM", "GUILD_PROMOTE", "GUILD_LEAVE", "PVP_REPORT_AFK", "CANCEL" };
  UnitPopupMenus["TEAM"] = { "WHISPER", "INVITE", "TARGET", "TEAM_PROMOTE", "TEAM_KICK", "TEAM_LEAVE", "CANCEL" };
  UnitPopupMenus["RAID_TARGET_ICON"] = { "RAID_TARGET_1", "RAID_TARGET_2", "RAID_TARGET_3", "RAID_TARGET_4", "RAID_TARGET_5", "RAID_TARGET_6", "RAID_TARGET_7", "RAID_TARGET_8", "RAID_TARGET_NONE" };
  UnitPopupMenus["CHAT_ROSTER"] = { "WHISPER", "TARGET", "MUTE", "UNMUTE", "CHAT_SILENCE", "CHAT_UNSILENCE", "CHAT_PROMOTE", "CHAT_DEMOTE", "CHAT_OWNER", "CANCEL"  };
  UnitPopupMenus["VEHICLE"] = { "RAID_TARGET_ICON", "VEHICLE_LEAVE", "CANCEL" };
  UnitPopupMenus["TARGET"] = { "RAID_TARGET_ICON", "CANCEL" };
  UnitPopupMenus["ARENAENEMY"] = { "CANCEL" };
  UnitPopupMenus["FOCUS"] = { "CLEAR_FOCUS", "LOCK_FOCUS_FRAME", "UNLOCK_FOCUS_FRAME", "RAID_TARGET_ICON", "CANCEL" };
  
  -- Second level menus
  UnitPopupMenus["PVP_FLAG"] = { "PVP_ENABLE", "PVP_DISABLE"};
  UnitPopupMenus["LOOT_METHOD"] = { "FREE_FOR_ALL", "ROUND_ROBIN", "MASTER_LOOTER", "GROUP_LOOT", "NEED_BEFORE_GREED", "CANCEL" };
  UnitPopupMenus["LOOT_THRESHOLD"] = { "ITEM_QUALITY2_DESC", "ITEM_QUALITY3_DESC", "ITEM_QUALITY4_DESC", "CANCEL" };
  UnitPopupMenus["OPT_OUT_LOOT_TITLE"] = { "OPT_OUT_LOOT_ENABLE", "OPT_OUT_LOOT_DISABLE"};
  UnitPopupMenus["DUNGEON_DIFFICULTY"] = { "DUNGEON_DIFFICULTY1", "DUNGEON_DIFFICULTY2" };
  
  --position deathknight runes
  RuneButtonIndividual1:ClearAllPoints()
  RuneButtonIndividual1:SetPoint("BOTTOM", UIParent, "BOTTOM", -55, 140)

  --disable the pet castbar (for vehicles!)
  PetCastingBarFrame:UnregisterAllEvents()
  PetCastingBarFrame.Show = function() end
  PetCastingBarFrame:Hide()
  
  -----------------------------
  -- FUNCTIONS
  -----------------------------

  --chat output func
  local function am(text)
    DEFAULT_CHAT_FRAME:AddMessage(text)
  end
  
  --automana
  local function set_automana()
    if automana == 1 then
      local st = GetShapeshiftForm()
      if myclass == "WARRIOR" then
        manacolor = 1
      elseif myclass == "DEATHKNIGHT" then
        manacolor = 5
      elseif myclass == "ROGUE" then
        manacolor = 4
      elseif myclass == "DRUID" and st == 3 then
        manacolor = 4
      elseif myclass == "DRUID" and st == 1 then
        manacolor = 1
      else
        manacolor = 3
      end
    end
  end
  --call it once
  set_automana()
  
  --check function for vehicle manatype
  local function set_vehicle_mana(self)
    self.Power.Filling:SetVertexColor(orbtab[manacolor].r,orbtab[manacolor].g,orbtab[manacolor].b)
    self.pm3:SetModel(orbtab[manacolor].anim)
    self.pm3:SetModelScale(orbtab[manacolor].scale)
    self.pm3:SetPosition(orbtab[manacolor].z, orbtab[manacolor].x, orbtab[manacolor].y) 
    self.pm4:SetModel(orbtab[manacolor].anim)
    self.pm4:SetModelScale(orbtab[manacolor].scale)
    self.pm4:SetPosition(orbtab[manacolor].z, orbtab[manacolor].x, orbtab[manacolor].y+1)       
  end
  
  --check function for druid manatype
  local function check_druid_mana(self)
    local st = GetShapeshiftForm()
    if st ~= dudustance then
      set_automana()
      set_vehicle_mana(self)
      dudustance = st
    end    
  end
  
  --do format func
  local function do_format(v)
    local string = ""
    if v > 1000000 then
      string = (floor((v/1000000)*10)/10).."m"
    elseif v > 1000 then
      string = (floor((v/1000)*10)/10).."k"
    else
      string = v
    end  
    return string
  end
  
  --update player health func
  local function d3o2_updatePlayerHealth(self, event, unit, bar, min, max)
    local d = floor(min/max*100)
    self.Health.Filling:SetHeight((min / max) * self.Health:GetWidth())
    self.Health.Filling:SetTexCoord(0,1,  math.abs(min / max - 1),1)
    if useglow == 1 then
      self.pm1:SetAlpha((min/max)/fog_smoother)
      self.pm2:SetAlpha((min/max)/fog_smoother)
    end
    if d <= 25 and min > 1 then
      self.LowHP:Show()
    else
      self.LowHP:Hide()
    end
  end
  
  --update player power func
  local function d3o2_updatePlayerPower(self, event, unit, bar, min, max)
    local d, d2
    if max == 0 then
      d = 0
      d2 = 0
    else
     d = min/max
     d2 = floor(min/max*100)
    end
    self.Power.Filling:SetHeight((d) * self.Power:GetWidth())
    self.Power.Filling:SetTexCoord(0,1,  math.abs(d - 1),1)
    if useglow == 1 then
      self.pm3:SetAlpha((d)/fog_smoother)
      self.pm4:SetAlpha((d)/fog_smoother)
    end
    
    local shape
    if myclass == "DRUID" then
      shape = GetShapeshiftForm()    
    end  
    
    if myclass == "WARRIOR" or (myclass == "DRUID" and shape == 3) or (myclass == "DRUID" and shape == 1) or myclass == "DEATHKNIGHT" or myclass == "ROGUE" then
      self.mpval1:SetText(do_format(min))
      self.mpval2:SetText(d2)
    else
      self.mpval1:SetText(d2)
      self.mpval2:SetText(do_format(min))
    end
    
    if playerinvehicle == 1 then
      local pt = UnitPowerType("pet");
      if pt then
        if pt ~= vehiclepower then
          --am("ping"..pt)
          vehiclepower = pt
          if pt == 1 then
            manacolor = 1
          elseif pt == 3 then
            manacolor = 4
          else
            manacolor = 3
          end
          set_vehicle_mana(self)
        end        
      end      
    end
    
  end
  
  --update health func
  local function d3o2_updateHealth(self, event, unit, bar, min, max)
    local d = floor(min/max*100)
    local color
    local dead
    if UnitIsDeadOrGhost(unit) == 1 or UnitIsConnected(unit) == nil then
      color = {r = 0.4, g = 0.4, b = 0.4}
      dead = 1
    elseif UnitIsPlayer(unit) then
      if rRAID_CLASS_COLORS[select(2, UnitClass(unit))] then
        color = rRAID_CLASS_COLORS[select(2, UnitClass(unit))]
      end
    elseif unit == "pet" and UnitExists("pet") and GetPetHappiness() then
      local happiness = GetPetHappiness()
      color = tabvalues.happiness[happiness]
    else
      color = rFACTION_BAR_COLORS[UnitReaction(unit, "player")]
    end
    bar:SetStatusBarColor(0.15,0.15,0.15,0.9)
    bar.bg:SetVertexColor(0.7,0,0,1)
    --if you like color colored background, use this
    --bar.bg:SetVertexColor(color.r, color.g, color.b,1)
    if dead == 1 then
      bar.bg:SetVertexColor(0,0,0,0)  
    end
    if color then
      self.Name:SetTextColor(color.r, color.g, color.b,1)
    end
    if d <= 25 and min > 1 then
      self.LowHP:Show()
    else
      self.LowHP:Hide()
    end
  end
  
  --update power func
  local function d3o2_updatePower(self, event, unit, bar, min, max)
    --if max == 0 then
    --  bar:SetAlpha(0)
    --else
    --  bar:SetAlpha(1)
      local color = tabvalues.power[UnitPowerType(unit)]
      bar:SetStatusBarColor(color.r, color.g, color.b,0.9)
      bar.bg:SetVertexColor(color.r*0.3, color.g*0.3, color.b*0.3,1)
    --end
  end

  --menu  
  local function menu(self)
    local unit = self.unit:sub(1, -2)
    local cunit = self.unit:gsub("(.)", string.upper, 1)
    if(unit == "party" or unit == "partypet") then
      ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor", 0, 0)
    elseif(_G[cunit.."FrameDropDown"]) then
      ToggleDropDownMenu(1, nil, _G[cunit.."FrameDropDown"], "cursor", 0, 0)
    end
  end
  
  --setup frame width, height, strata
  local function d3o2_setupFrame(self,w,h,strata)
    self.menu = menu
    self:RegisterForClicks("AnyUp")
    self:SetAttribute("*type2", "menu")
    self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)
    self:SetFrameStrata(strata)
    self:SetWidth(w)
    self:SetHeight(h)
  end
  
  --orb glow func
  local function create_me_a_orb_glow(f,type,pos)
    local glow = CreateFrame("PlayerModel", nil, f)
    glow:SetFrameStrata("BACKGROUND")
    glow:SetFrameLevel(5)
    glow:SetAllPoints(f)
    if type == "power" then
      glow:SetModel(orbtab[manacolor].anim)
      glow:SetModelScale(orbtab[manacolor].scale)
      glow:SetPosition(orbtab[manacolor].z, orbtab[manacolor].x, orbtab[manacolor].y+pos) 
      glow:SetAlpha(1/fog_smoother)
      glow:SetScript("OnShow",function() 
        glow:SetModel(orbtab[manacolor].anim)
        glow:SetModelScale(orbtab[manacolor].scale)
        glow:SetPosition(orbtab[manacolor].z, orbtab[manacolor].x, orbtab[manacolor].y+pos) 
      end)
    else
      glow:SetModel(orbtab[healthcolor].anim)
      glow:SetModelScale(orbtab[healthcolor].scale)
      glow:SetPosition(orbtab[healthcolor].z, orbtab[healthcolor].x, orbtab[healthcolor].y+pos) 
      glow:SetAlpha(1/fog_smoother)
      glow:SetScript("OnShow",function() 
        glow:SetModel(orbtab[healthcolor].anim)
        glow:SetModelScale(orbtab[healthcolor].scale)
        glow:SetPosition(orbtab[healthcolor].z, orbtab[healthcolor].x, orbtab[healthcolor].y+pos) 
      end)    
    end
    return glow
  end
  
  --check vehicle type
  local function check_vehicle_mana(self,event)
    if event == "UNIT_ENTERED_VEHICLE" then
      playerinvehicle = 1
    else
      playerinvehicle = 0
      vehiclepower = nil
      set_automana()
      set_vehicle_mana(self)
    end
  end
  
  --create orb func
  local function d3o2_createOrb(self,type)
    local orb = CreateFrame("StatusBar", nil, self)    
    orb:SetStatusBarTexture("Interface\\AddOns\\rTextures\\orb_transparent.tga")
    orb:SetHeight(orbsize)
    orb:SetWidth(orbsize)
    orb.bg = orb:CreateTexture(nil, "BACKGROUND")
    orb.bg:SetTexture("Interface\\AddOns\\rTextures\\orb_back2.tga")
    orb.bg:SetAllPoints(orb)
    orb.Filling = orb:CreateTexture(nil, "ARTWORK")
    if type == "power" then
      orb.Filling:SetTexture("Interface\\AddOns\\rTextures\\orb_filling6.tga")
    else
      orb.Filling:SetTexture("Interface\\AddOns\\rTextures\\orb_filling6.tga")
    end
    orb.Filling:SetPoint("BOTTOMLEFT",0,0)
    orb.Filling:SetWidth(orbsize)
    orb.Filling:SetHeight(orbsize)
    --orb.Filling:SetBlendMode("add")
    orb.Filling:SetAlpha(1)
    orbGlossHolder = CreateFrame("Frame", nil, orb)
    orbGlossHolder:SetAllPoints(orb)
    orbGlossHolder:SetFrameStrata("LOW")
    orbOrbGloss = orbGlossHolder:CreateTexture(nil, "OVERLAY")
    orbOrbGloss:SetTexture("Interface\\AddOns\\rTextures\\orb_gloss.tga")
    orbOrbGloss:SetAllPoints(orbGlossHolder)
    if type == "power" then
      orb:SetPoint(tabvalues.frame_positions[1].a1, tabvalues.frame_positions[1].af, tabvalues.frame_positions[1].a2, tabvalues.frame_positions[1].x, tabvalues.frame_positions[1].y)
      self.Power = orb
      self.Power.Filling = orb.Filling
      if useglow == 1 then
        self.pm3 = create_me_a_orb_glow(orb,type,0)
        self.pm4 = create_me_a_orb_glow(orb,type,1)
        self.Power.Filling:SetVertexColor(orbtab[manacolor].r,orbtab[manacolor].g,orbtab[manacolor].b)        
        if myclass == "DRUID" and automana == 1 then
          self.Power:RegisterEvent("PLAYER_ENTERING_WORLD")
          self.Power:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
          self.Power:SetScript("OnEvent", function()
            check_druid_mana(self)        
          end)
        end
        if automana == 1 then
          orbGlossHolder:RegisterEvent("UNIT_ENTERED_VEHICLE")
          orbGlossHolder:RegisterEvent("UNIT_EXITED_VEHICLE")
          orbGlossHolder:SetScript("OnEvent", function(_,event,arg1)
            if arg1 == "player" then
              check_vehicle_mana(self,event)
            end
          end)
        end
      else
        self.Power.Filling:SetVertexColor(0,0.5,1)
      end
      self.Power.frequentUpdates = true
      self.Power.Smooth = true
    else
      orb:SetPoint("TOPLEFT", 0, 0)
      self.Health = orb
      self.Health.Filling = orb.Filling
      if useglow == 1 then
        self.pm1 = create_me_a_orb_glow(orb,type,0)
        self.pm2 = create_me_a_orb_glow(orb,type,1)
        self.Health.Filling:SetVertexColor(orbtab[healthcolor].r,orbtab[healthcolor].g,orbtab[healthcolor].b)
      else
        self.Health.Filling:SetVertexColor(0.5,1,0)
      end
      self.Health.Smooth = true
    end
  end
  
  --set fontstring
  local function SetFontString(parent, fontName, fontHeight, fontStyle)
    local fs = parent:CreateFontString(nil, "OVERLAY")
    fs:SetFont(fontName, fontHeight, fontStyle)
    fs:SetShadowColor(0,0,0,1)
    return fs
  end
  
  --create health and power bar func for every frame but not player
  local function d3o2_createHealthPowerFrames(self,unit)
    --health
    self.Health = CreateFrame("StatusBar", nil, self)
    self.Health:SetStatusBarTexture("Interface\\AddOns\\rTextures\\statusbar.tga")
    self.Health:SetHeight(16)
    self.Health:SetWidth(self:GetWidth())
    if unit == "target" or unit == "targettarget" then
      self.Health:SetPoint("TOPLEFT",0,-1)
    else
      self.Health:SetPoint("BOTTOMLEFT",0,1)
    end      
    if unit == "target" then
      self.bg = self:CreateTexture(nil, "BACKGROUND")
      self.bg:SetTexture("Interface\\AddOns\\rTextures\\d3_targetframe.tga")
      self.bg:SetWidth(512)
      self.bg:SetHeight(128)
      self.bg:SetPoint("CENTER",-3,0)
      self.Health.bg = self.Health:CreateTexture(nil, "BACKGROUND")
      self.Health.bg:SetTexture("Interface\\AddOns\\rTextures\\statusbar.tga")
      self.Health.bg:SetAllPoints(self.Health)    
    elseif unit == "targettarget" then
      self.bg = self:CreateTexture(nil, "BACKGROUND")
      self.bg:SetTexture("Interface\\AddOns\\rTextures\\d3totframe.tga")
      self.bg:SetWidth(256)
      self.bg:SetHeight(128)
      self.bg:SetPoint("CENTER",-2,0)
      self.Health.bg = self.Health:CreateTexture(nil, "BACKGROUND")
      self.Health.bg:SetTexture("Interface\\AddOns\\rTextures\\statusbar.tga")
      self.Health.bg:SetAllPoints(self.Health)
    else
      self.bg = self:CreateTexture(nil, "BACKGROUND")
      self.bg:SetTexture("Interface\\AddOns\\rTextures\\d3totframe.tga")
      self.bg:SetWidth(256)
      self.bg:SetHeight(128)
      self.bg:SetPoint("BOTTOM",-2,-56)
      self.Health.bg = self.Health:CreateTexture(nil, "BACKGROUND")
      self.Health.bg:SetTexture("Interface\\AddOns\\rTextures\\statusbar.tga")
      self.Health.bg:SetAllPoints(self.Health)    
    end  
    self.Health.Smooth = true
    --power    
    self.Power = CreateFrame("StatusBar", nil, self)
    self.Power:SetStatusBarTexture("Interface\\AddOns\\rTextures\\statusbar.tga")
    self.Power:SetHeight(4)
    self.Power:SetWidth(self:GetWidth())
    self.Power:SetPoint("TOP", self.Health, "BOTTOM", 0, 0)
    self.Power.bg = self.Power:CreateTexture(nil, "BACKGROUND")
    self.Power.bg:SetTexture("Interface\\AddOns\\rTextures\\statusbar.tga")
    self.Power.bg:SetAllPoints(self.Power)
    self.Power.Smooth = true
    if unit == "pet" then
      self.Power.frequentUpdates = true
    end
  end
  
  --aura icon func
  local function d3o2_createAuraIcon(self, button, icons, index, debuff)
    button.cd:SetReverse()
    button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    button.count:SetPoint("BOTTOMRIGHT", button, 2, -2)
    button.count:SetTextColor(0.7,0.7,0.7)
    --fix the count on aurawatch, make the count fontsize button size dependend
    button.count:SetFont(d3font,button:GetWidth()/1.5,"THINOUTLINE")
    self.ButtonOverlay = button:CreateTexture(nil, "OVERLAY")
    self.ButtonOverlay:SetTexture("Interface\\AddOns\\rTextures\\gloss2.tga")
    self.ButtonOverlay:SetVertexColor(0.37,0.3,0.3,1);
    self.ButtonOverlay:SetParent(button)
    self.ButtonOverlay:SetPoint("TOPLEFT", -1, 1)
    self.ButtonOverlay:SetPoint("BOTTOMRIGHT", 1, -1)  
    
    local back = button:CreateTexture(nil, "BACKGROUND")
    back:SetPoint("TOPLEFT",button.icon,"TOPLEFT",-4,4)
    back:SetPoint("BOTTOMRIGHT",button.icon,"BOTTOMRIGHT",4,-4)
    back:SetTexture("Interface\\AddOns\\rTextures\\simplesquare_glow")
    back:SetVertexColor(0, 0, 0, 1)
    
  end
  
  --buff func
  local function d3o2_createBuffs(self,unit)
    self.Buffs = CreateFrame("Frame", nil, self)
    self.Buffs.size = 20
    self.Buffs.num = 40
    self.Buffs:SetHeight((self.Buffs.size+5)*3)
    self.Buffs:SetWidth(self:GetWidth())
    self.Buffs:SetPoint("BOTTOMLEFT", self, "TOPRIGHT", 20, 15)
    self.Buffs.initialAnchor = "BOTTOMLEFT"
    self.Buffs["growth-x"] = "RIGHT"
    self.Buffs["growth-y"] = "UP"
    self.Buffs.spacing = 5
  end
  
  --debuff func
  local function d3o2_createDebuffs(self,unit)
    self.Debuffs = CreateFrame("Frame", nil, self)
    if unit == "target" then
      self.Debuffs.size = 20
      self.Debuffs.num = 40
      self.Debuffs:SetHeight((self.Debuffs.size+5)*3)
      self.Debuffs:SetWidth(self:GetWidth())
      self.Debuffs:SetPoint("TOPLEFT", self, "BOTTOMRIGHT", 20, -15)
      self.Debuffs.initialAnchor = "TOPLEFT"
      self.Debuffs["growth-x"] = "RIGHT"
      self.Debuffs["growth-y"] = "DOWN"
      self.Debuffs.spacing = 5
    elseif unit == "targettarget" then
      self.Debuffs.size = 20
      self.Debuffs.num = 8
      self.Debuffs:SetHeight((self.Debuffs.size+5)*1)
      self.Debuffs:SetWidth(self:GetWidth())
      self.Debuffs:SetPoint("TOP", self, "BOTTOM", 0, -15)
      self.Debuffs.initialAnchor = "TOPLEFT"
      self.Debuffs["growth-x"] = "RIGHT"
      self.Debuffs["growth-y"] = "DOWN"
      self.Debuffs.spacing = 5      
    else
      self.Debuffs.size = 34
      self.Debuffs.num = 3
      self.Debuffs:SetHeight((self.Debuffs.size+5)*1)
      self.Debuffs:SetWidth(self:GetWidth())
      self.Debuffs:SetPoint("TOP", self, "BOTTOM", 0, -17)
      self.Debuffs.initialAnchor = "TOPLEFT"
      self.Debuffs["growth-x"] = "RIGHT"
      self.Debuffs["growth-y"] = "DOWN"
      self.Debuffs.spacing = 5      
    end
    self.Debuffs.onlyShowPlayer = false
    self.Debuffs.showDebuffType = false
  end
  
  local function d3o2_createCastbar(self,unit)
    self.Castbar = CreateFrame("StatusBar", nil, UIParent)
    self.Castbar:SetFrameStrata("DIALOG")
    self.Castbar:SetWidth(224)
    self.Castbar:SetHeight(18)
    self.Castbar:SetStatusBarTexture("Interface\\AddOns\\rTextures\\statusbar.tga")
    self.Castbar.bg2 = self.Castbar:CreateTexture(nil, "BACKGROUND")
    self.Castbar.bg2:SetTexture("Interface\\AddOns\\rTextures\\d3_targetframe.tga")
    self.Castbar.bg2:SetWidth(512)
    self.Castbar.bg2:SetHeight(128)
    self.Castbar.bg2:SetPoint("CENTER",-3,0)
    self.Castbar.bg = self.Castbar:CreateTexture(nil, "BORDER")
    self.Castbar.bg:SetTexture("Interface\\AddOns\\rTextures\\statusbar.tga")
    self.Castbar.bg:SetAllPoints(self.Castbar)
    self.Castbar.bg:SetVertexColor(180/255,110/255,30/255,1)
    self.Castbar:SetStatusBarColor(0.15,0.15,0.15,0.9)
    if unit == "player" then
      self.Castbar:SetPoint(tabvalues.frame_positions[13].a1, tabvalues.frame_positions[13].af, tabvalues.frame_positions[13].a2, tabvalues.frame_positions[13].x, tabvalues.frame_positions[13].y)
    elseif unit == "target" then
      self.Castbar:SetPoint(tabvalues.frame_positions[12].a1, tabvalues.frame_positions[12].af, tabvalues.frame_positions[12].a2, tabvalues.frame_positions[12].x, tabvalues.frame_positions[12].y)
    elseif unit == "focus" then
      self.Castbar:SetPoint(tabvalues.frame_positions[14].a1, tabvalues.frame_positions[14].af, tabvalues.frame_positions[14].a2, tabvalues.frame_positions[14].x, tabvalues.frame_positions[14].y)
    end
    
    self.Castbar.Text = SetFontString(self.Castbar, d3font, 14, "THINOUTLINE")
    self.Castbar.Text:SetPoint("LEFT", 2, 0)
    self.Castbar.Time = SetFontString(self.Castbar, d3font, 14, "THINOUTLINE")
    self.Castbar.Time:SetPoint("RIGHT", -2, 0)
    --icon
    self.Castbar.Icon = self.Castbar:CreateTexture(nil, "BORDER")
    self.Castbar.Icon:SetWidth(32)
    self.Castbar.Icon:SetHeight(32)
    self.Castbar.Icon:SetPoint("LEFT", -77, 0)
    self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    
    self.Castbar.IconBack = self.Castbar:CreateTexture(nil, "BACKGROUND")
    self.Castbar.IconBack:SetPoint("TOPLEFT",self.Castbar.Icon,"TOPLEFT",-5,5)
    self.Castbar.IconBack:SetPoint("BOTTOMRIGHT",self.Castbar.Icon,"BOTTOMRIGHT",5,-5)
    self.Castbar.IconBack:SetTexture("Interface\\AddOns\\rTextures\\simplesquare_glow")
    self.Castbar.IconBack:SetVertexColor(0, 0, 0, 1)
    
    self.Castbar.IconOverlay = self.Castbar:CreateTexture(nil, "OVERLAY")
    self.Castbar.IconOverlay:SetTexture("Interface\\AddOns\\rTextures\\gloss2.tga")
    self.Castbar.IconOverlay:SetVertexColor(0.37,0.3,0.3,1);
    self.Castbar.IconOverlay:SetPoint("TOPLEFT", self.Castbar.Icon, "TOPLEFT", -1, 1)
    self.Castbar.IconOverlay:SetPoint("BOTTOMRIGHT", self.Castbar.Icon, "BOTTOMRIGHT", 1, -1)  
    
    
    self.Castbar:SetScale(targetscale)
  
  end
  
  --lowhp func
  local function d3o2_createLowHP(self,unit)
    if unit == "player" then
      self.LowHP = self.Health:CreateTexture(nil, "ARTWORK")
      self.LowHP:SetAllPoints(self.Health)
      self.LowHP:SetTexture("Interface\\AddOns\\rTextures\\orb_lowhp_glow.tga")
      self.LowHP:SetBlendMode("BLEND")
      self.LowHP:SetVertexColor(1, 0, 0, 1)
      self.LowHP:Hide()
    elseif unit == "target" then
      self.LowHP = self.Health:CreateTexture(nil, "ARTWORK")
      self.LowHP:SetWidth(505)
      self.LowHP:SetHeight(115)
      self.LowHP:SetPoint("CENTER",-3,0)
      self.LowHP:SetTexture("Interface\\AddOns\\rTextures\\d3_targetframe_lowhp.tga")
      self.LowHP:SetBlendMode("ADD")
      self.LowHP:SetVertexColor(1, 0, 0, 1)
      self.LowHP:SetAlpha(0.8)
      self.LowHP:Hide()    
    else
      self.LowHP = self.Health:CreateTexture(nil, "ARTWORK")
      self.LowHP:SetWidth(250)
      self.LowHP:SetHeight(115)
      self.LowHP:SetPoint("CENTER",-2,0)
      self.LowHP:SetTexture("Interface\\AddOns\\rTextures\\d3totframe_lowhp.tga")
      self.LowHP:SetBlendMode("ADD")
      self.LowHP:SetVertexColor(1, 0, 0, 1)
      self.LowHP:SetAlpha(0.8)
      self.LowHP:Hide()
    end
  end
  
  local function d3o2_createDebuffGlow(self,unit)
    if unit == "player" then
      self.DebuffHighlight = self:CreateTexture(nil, "BACKGROUND")
      --self.DebuffHighlight:SetAllPoints(self)
      self.DebuffHighlight:SetWidth(self:GetWidth())
      self.DebuffHighlight:SetHeight(self:GetWidth())
      self.DebuffHighlight:SetPoint("CENTER",0,0)
      self.DebuffHighlight:SetBlendMode("BLEND")
      self.DebuffHighlight:SetVertexColor(1, 0, 0, 0) -- set alpha to 0 to hide the texture
      self.DebuffHighlightAlpha = 0.7
      self.DebuffHighlightFilter = false
      self.DebuffHighlight:SetTexture("Interface\\AddOns\\rTextures\\orb_debuff_glow.tga")
    elseif unit == "target" then
      self.DebuffHighlight = self:CreateTexture(nil, "OVERLAY")
      self.DebuffHighlight:SetWidth(302)
      self.DebuffHighlight:SetHeight(self.DebuffHighlight:GetWidth()/4)
      self.DebuffHighlight:SetPoint("CENTER",-3,0)
      self.DebuffHighlight:SetBlendMode("BLEND")
      self.DebuffHighlight:SetVertexColor(1, 0, 0, 0) -- set alpha to 0 to hide the texture
      self.DebuffHighlightAlpha = 0.8
      self.DebuffHighlightFilter = true      
      self.DebuffHighlight:SetTexture("Interface\\AddOns\\rTextures\\d3_nameplate_border_glow.tga")        
    elseif unit == "targettarget" then
      self.DebuffHighlight = self:CreateTexture(nil, "OVERLAY")
      self.DebuffHighlight:SetWidth(256)
      self.DebuffHighlight:SetHeight(self.DebuffHighlight:GetWidth()/2)
      self.DebuffHighlight:SetPoint("CENTER",-2,0)
      self.DebuffHighlight:SetBlendMode("BLEND")
      self.DebuffHighlight:SetVertexColor(1, 0, 0, 0) -- set alpha to 0 to hide the texture
      self.DebuffHighlightAlpha = 0.8
      self.DebuffHighlightFilter = true
      self.DebuffHighlight:SetTexture("Interface\\AddOns\\rTextures\\d3totframe_debuff.tga")
    else
      self.DebuffHighlight = self:CreateTexture(nil, "OVERLAY")
      self.DebuffHighlight:SetWidth(256)
      self.DebuffHighlight:SetHeight(115)
      self.DebuffHighlight:SetPoint("BOTTOM",-2,-50)
      self.DebuffHighlight:SetBlendMode("BLEND")
      self.DebuffHighlight:SetVertexColor(1, 0, 0, 0) -- set alpha to 0 to hide the texture
      self.DebuffHighlightAlpha = 0.8
      self.DebuffHighlightFilter = true
      self.DebuffHighlight:SetTexture("Interface\\AddOns\\rTextures\\d3totframe_debuff.tga")
    end
  end
  
  --create the elite head texture
  local bubblehead
  local function d3o2_createBubbleHead(self,unit)
    local headsize = 100
    local head = self.Health:CreateTexture(nil,"OVERLAY")
    head:SetTexture("Interface\\AddOns\\rTextures\\d3_head_trans")
    head:SetWidth(headsize)
    head:SetHeight(headsize/2)
    head:SetPoint("TOP",0,-6)
    bubblehead = head
    bubblehead:Hide()
  end
  
  --create portraits func
  local function d3o2_createPortraits(self,unit)
    self.Portrait_bgf = CreateFrame("Frame",nil,self)
    self.Portrait_bgf:SetPoint("BOTTOM",self.Health,"TOP",0,14)
    self.Portrait_bgf:SetWidth(self:GetWidth()+10)
    self.Portrait_bgf:SetHeight(self:GetWidth()+10)  
    
    local back = self.Portrait_bgf:CreateTexture(nil, "BACKGROUND")
    back:SetPoint("TOPLEFT",self.Portrait_bgf,"TOPLEFT",-15,15)
    back:SetPoint("BOTTOMRIGHT",self.Portrait_bgf,"BOTTOMRIGHT",15,-15)
    back:SetTexture("Interface\\AddOns\\rTextures\\simplesquare_glow")
    back:SetVertexColor(0, 0, 0, 0.7)
    
    self.Portrait_bgt = self.Portrait_bgf:CreateTexture(nil, "BACKGROUND")
    self.Portrait_bgt:SetAllPoints(self.Portrait_bgf)
    self.Portrait_bgt:SetTexture("Interface\\AddOns\\rTextures\\d3portrait_back2.tga")
    self.Portrait_bgt:SetVertexColor(0.7,0.7,0.7)
  
    if use_3dportraits == 1 and unit ~= "focustarget" then
      self.Portrait = CreateFrame("PlayerModel", nil, self.Portrait_bgf)
      self.Portrait:SetPoint("TOPLEFT",self.Portrait_bgf,"TOPLEFT",4,-4)
      self.Portrait:SetPoint("BOTTOMRIGHT",self.Portrait_bgf,"BOTTOMRIGHT",-4,4)

      self.Portrait_glossf = CreateFrame("Frame",nil,self.Portrait)
      self.Portrait_glossf:SetAllPoints(self.Portrait_bgf)
    else
      self.Portrait = self.Portrait_bgf:CreateTexture(nil, "BORDER")
      self.Portrait:SetPoint("TOPLEFT",self.Portrait_bgf,"TOPLEFT",2,-2)
      self.Portrait:SetPoint("BOTTOMRIGHT",self.Portrait_bgf,"BOTTOMRIGHT",-2,2)

      self.Portrait_glossf = CreateFrame("Frame",nil,self.Portrait_bgf)
      self.Portrait_glossf:SetAllPoints(self.Portrait_bgf)
    end

    self.Portrait_glosst = self.Portrait_glossf:CreateTexture(nil, "ARTWORK")
    self.Portrait_glosst:SetAllPoints(self.Portrait_glossf)
    self.Portrait_glosst:SetTexture("Interface\\AddOns\\rTextures\\simplesquare_roth")
    self.Portrait_glosst:SetVertexColor(0.37,0.3,0.3)

    self.Name:SetPoint("BOTTOM", self.Portrait_bgf, "TOP", 0, 5)
    self.Name:SetFont(d3font,22,"THINOUTLINE")
  end
  
  local function d3o2_createAuraWatch(self,unit)
    --if unit ~= "target" then return end
    -- We only want to create this for the target
    local auras = CreateFrame("Frame", nil, self)
    auras:SetWidth(34)
    auras:SetHeight(34)
    auras:SetPoint("BOTTOMLEFT", self.Health, "TOPRIGHT", 58, -25)
    
    local spellIDs = { 
      48440, --reju
      48443, --regrowth
      48450, --lifebloom
      53249, --wildgrowth
    }
    
    auras.presentAlpha = 1
    auras.missingAlpha = 0
    auras.PostCreateIcon = d3o2_createAuraIcon
    auras.icons = {}
    for i, sid in pairs(spellIDs) do
      local icon = CreateFrame("Frame", nil, auras)
      icon.spellID = sid
      icon:SetWidth(34)
      icon:SetHeight(34)
      icon:SetPoint("RIGHT", auras, "LEFT", 0, 38*i)
      auras.icons[sid] = icon
    end
    self.AuraWatch = auras
  end
  
  --create special icons (raid, leader)
  local function d3o2_createIcons(self,unit)
    if unit == "player" then
      --nothing   
    elseif unit == "target" then
      self.RaidIcon = self:CreateTexture(nil, "OVERLAY")
      self.RaidIcon:SetHeight(24)
      self.RaidIcon:SetWidth(24)
      self.RaidIcon:SetPoint("RIGHT", self.Name, "LEFT", -5, 2)
      self.RaidIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
    else
      self.RaidIcon = self:CreateTexture(nil, "OVERLAY")
      self.RaidIcon:SetHeight(16)
      self.RaidIcon:SetWidth(16)
      self.RaidIcon:SetPoint("RIGHT", self.Name, "LEFT", -2, 2)
      self.RaidIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
    end

    if unit == "player" then
      self.Leader = self:CreateTexture(nil, "OVERLAY")
      self.Leader:SetHeight(16)
      self.Leader:SetWidth(16)
      self.Leader:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
      self.Leader:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")    
    elseif unit == "target" or unit == "targettarget" then 
      -- nothing
    else
      self.Leader = self:CreateTexture(nil, "OVERLAY")
      self.Leader:SetHeight(24)
      self.Leader:SetWidth(24)
      self.Leader:SetPoint("RIGHT", self.Health, "LEFT", -22, 22)
      self.Leader:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")      
    end
  end  
  
  local function d3o2_createComboPoints(self,unit)
    self.CPoints = SetFontString(self.Health, d3font, 24, "THINOUTLINE")
    self.CPoints:SetPoint("LEFT", self.Name, "RIGHT", 5, -1)
    self.CPoints:SetTextColor(1, .5, 0)
    self.CPoints.unit = PlayerFrame.unit
  end
  
  --thanks to p3lim for this one
  --it does fix the vehicle combopoints
  local function updateCPoints(self, event, unit)
  	if(unit == PlayerFrame.unit) and (unit ~= self.CPoints.unit) then
  		self.CPoints.unit = unit
  		--am("ding "..unit)
  	end
  end
  
  
  -----------------------------
  -- CUSTOM TAGS
  -----------------------------
  
  oUF.Tags["[d3o2name]"] = function(unit) 
    local tmpunitname = UnitName(unit)      
    if unit == "target" then
      if tmpunitname:len() > 20 then
        tmpunitname = tmpunitname:sub(1, 20).."..."
      end
    else
      if tmpunitname:len() > 16 then
        tmpunitname = tmpunitname:sub(1, 16).."..."
      end
    end
    return tmpunitname
  end
  
  oUF.Tags["[d3o2misshp]"] = function(unit) 
    local max, min = UnitHealthMax(unit), UnitHealth(unit)
    local v = max-min
    local string = ""
    if UnitIsDeadOrGhost(unit) == 1 then
      string = "dead"
    elseif UnitIsConnected(unit) == nil then
      string = "off"
    elseif v == 0 then
      string = ""
    elseif v > 1000000 then
      string = -(floor((v/1000000)*10)/10).."m"
    elseif v > 1000 then
      string = -(floor((v/1000)*10)/10).."k"
    else
      string = -v
    end  
    return string
  end
  oUF.TagEvents["[d3o2misshp]"] = "UNIT_HEALTH"
  
  oUF.Tags["[d3o2abshp]"] = function(unit) 
    local v = UnitHealth(unit)
    local string = ""
    if UnitIsDeadOrGhost(unit) == 1 then
      string = "dead"
    elseif UnitIsConnected(unit) == nil then
      string = "off"
    elseif v > 1000000 then
      string = (floor((v/1000000)*10)/10).."m"
    elseif v > 1000 then
      string = (floor((v/1000)*10)/10).."k"
    else
      string = v
    end  
    return string
  end
  oUF.TagEvents["[d3o2abshp]"] = "UNIT_HEALTH"
  
  oUF.Tags["[d3o2absmp]"] = function(unit) 
    local v = UnitMana(unit)
    local string = ""
    if v > 1000000 then
      string = (floor((v/1000000)*10)/10).."m"
    elseif v > 1000 then
      string = (floor((v/1000)*10)/10).."k"
    else
      string = v
    end  
    return string
  end
  oUF.TagEvents["[d3o2absmp]"] = "UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_RUNIC_POWER"
  
  oUF.Tags["[d3o2classtext]"] = function(unit) 
    bubblehead:Hide()
    local string, tmpstring, sp = "", "", " "
    if UnitLevel(unit) ~= -1 then
      string = UnitLevel(unit)
    else
      string = "??"
    end    
    string = string..sp
    local unitrace = UnitRace(unit)
    local creatureType = UnitCreatureType(unit)    
    if unitrace and UnitIsPlayer(unit) then
      string = string..unitrace..sp
    end   
    if creatureType and not UnitIsPlayer(unit) then
      string = string..creatureType..sp
    end    
    local unit_classification = UnitClassification(unit)    
    if unit_classification == "worldboss" then
      tmpstring = "Boss"
      bubblehead:Show()
      bubblehead:SetTexture("Interface\\AddOns\\rTextures\\d3_head_skull")
    elseif unit_classification == "rare" or unit_classification == "rareelite" then
      tmpstring = "Rare"
      bubblehead:Show()
      bubblehead:SetTexture("Interface\\AddOns\\rTextures\\d3_head_diablo")
      if unit_classification == "rareelite" then
        tmpstring = tmpstring.." Elite"
      end
    elseif unit_classification == "elite" then
      tmpstring = "Elite"
      bubblehead:Show()
      bubblehead:SetTexture("Interface\\AddOns\\rTextures\\d3_head_garg")
    end    
    if tmpstring ~= "" then
      tmpstring = tmpstring..sp  
    end    
    string = string..tmpstring
    tmpstring = ""    
    local localizedClass, englishClass = UnitClass(unit)
    
    if localizedClass and UnitIsPlayer(unit) then
      string = string..localizedClass..sp
    end
    return string
  end
    
  -----------------------------
  -- CREATE STYLES
  -----------------------------
    
  --create the player style
  local function CreatePlayerStyle(self, unit)
    if use_rbottombarstyler ~= 1 then
      d3o2_setupFrame(self,orbsize,orbsize,"BACKGROUND")  
      d3o2_createOrb(self,"health")
      d3o2_createOrb(self,"power")
      self.HealthValueHolder = CreateFrame("FRAME", nil, self.Health)
      self.HealthValueHolder:SetFrameStrata("LOW")
      self.HealthValueHolder:SetAllPoints(self.Health)
      local hpval1 = SetFontString(self.HealthValueHolder, d3font, 28, "THINOUTLINE")
      hpval1:SetPoint("CENTER", 0, 10)
      local hpval2 = SetFontString(self.HealthValueHolder, d3font, 16, "THINOUTLINE")
      hpval2:SetPoint("CENTER", 0, -10)
      hpval2:SetTextColor(0.6,0.6,0.6)
      self.PowerValueHolder = CreateFrame("FRAME", nil, self.Power)
      self.PowerValueHolder:SetFrameStrata("LOW")
      self.PowerValueHolder:SetAllPoints(self.Power)
      local mpval1 = SetFontString(self.PowerValueHolder, d3font, 28, "THINOUTLINE")
      mpval1:SetPoint("CENTER", 0, 10)
      local mpval2 = SetFontString(self.PowerValueHolder, d3font, 16, "THINOUTLINE")
      mpval2:SetPoint("CENTER", 0, -10)
      mpval2:SetTextColor(0.6,0.6,0.6)
      self:Tag(hpval1, "[perhp]")
      self:Tag(hpval2, "[d3o2abshp]")
      --cannot use custom events with frequentupdates enabled
      --self:Tag(mpval1, "[perpp]")
      --self:Tag(mpval2, "[d3o2absmp]")
      --set the subobjects to be available for the d3o2_updatePlayerPower func
      self.mpval1 = mpval1
      self.mpval2 = mpval2
      self.PostUpdateHealth = d3o2_updatePlayerHealth
      self.PostUpdatePower = d3o2_updatePlayerPower
      d3o2_createLowHP(self,unit)
      d3o2_createDebuffGlow(self,unit)
      d3o2_createIcons(self,unit)
    end
    d3o2_createCastbar(self,unit)
    self:SetScale(playerscale)
  end
  
  --create the target style
  local function CreateTargetStyle(self, unit)
    d3o2_setupFrame(self,224,20,"BACKGROUND")
    d3o2_createHealthPowerFrames(self,unit)
    d3o2_createBuffs(self,unit)
    d3o2_createDebuffs(self,unit)
    d3o2_createBubbleHead(self,unit)
    local name = SetFontString(self, d3font, 20, "THINOUTLINE")
    name:SetPoint("BOTTOM", self, "TOP", 0, 30)
    local hpval = SetFontString(self.Health, d3font, 14, "THINOUTLINE")
    hpval:SetPoint("RIGHT", self, "RIGHT", -2, 2)
    local classtext = SetFontString(self, d3font, 16, "THINOUTLINE")
    classtext:SetPoint("BOTTOM", self, "TOP", 0, 13)
    self.Name = name
    self:Tag(name, "[d3o2name]")
    self:Tag(hpval, "[d3o2abshp] - [perhp]%")
    self:Tag(classtext, "[d3o2classtext]")
    
    d3o2_createCastbar(self,unit)
    d3o2_createLowHP(self,unit)
    d3o2_createDebuffGlow(self,unit)
    d3o2_createIcons(self,unit)
    d3o2_createComboPoints(self,unit)
    self:RegisterEvent('UNIT_COMBO_POINTS', updateCPoints)
    
    self.PostUpdateHealth = d3o2_updateHealth
    self.PostUpdatePower = d3o2_updatePower
    self.PostCreateAuraIcon = d3o2_createAuraIcon
    self:SetScale(targetscale)
  end
  
  --create the tot style
  local function CreateToTStyle(self, unit)
    d3o2_setupFrame(self,110,20,"BACKGROUND")
    d3o2_createHealthPowerFrames(self,unit)
    d3o2_createDebuffs(self,unit)
    local name = SetFontString(self, d3font, 18, "THINOUTLINE")
    name:SetPoint("BOTTOM", self, "TOP", 0, 15)
    local hpval = SetFontString(self.Health, d3font, 14, "THINOUTLINE")
    hpval:SetPoint("RIGHT", self, "RIGHT", -2, 2)
    self.Name = name
    self:Tag(name, "[d3o2name]")
    self:Tag(hpval, "[perhp]%")
    
    d3o2_createLowHP(self,unit)
    d3o2_createDebuffGlow(self,unit)
    d3o2_createIcons(self,unit)
    
    self.PostUpdateHealth = d3o2_updateHealth
    self.PostUpdatePower = d3o2_updatePower
    self.PostCreateAuraIcon = d3o2_createAuraIcon
    self:SetScale(targetscale)
  end
  
  --create the focus, pet and party style
  local function CreateFocusStyle(self, unit)
    d3o2_setupFrame(self,110,200,"BACKGROUND")
    d3o2_createHealthPowerFrames(self,unit)
    d3o2_createDebuffs(self,unit)
    local name = SetFontString(self, d3font, 18, "THINOUTLINE")
    name:SetPoint("BOTTOM", self, "TOP", 0, 15)
    self.Name = name
    self:Tag(name, "[d3o2name]")
    local hpval = SetFontString(self.Health, d3font, 20, "THINOUTLINE")
    hpval:SetPoint("RIGHT", self.Health, "RIGHT", -2, 0)
    self:Tag(hpval, "[d3o2misshp]")
    
    d3o2_createLowHP(self,unit)
    d3o2_createDebuffGlow(self,unit)
    d3o2_createPortraits(self,unit)    
    if unit == "focus" then
      d3o2_createCastbar(self,unit)
    end    
    d3o2_createIcons(self,unit)
    
    if myclass == "DRUID" then
      d3o2_createAuraWatch(self,unit)
    end
    
    self.PostUpdateHealth = d3o2_updateHealth
    self.PostUpdatePower = d3o2_updatePower
    self.PostCreateAuraIcon = d3o2_createAuraIcon
    self:SetScale(focusscale)
    
    if (not unit) then
      self.Range = true
      self.outsideRangeAlpha = 0.6
      self.inRangeAlpha = 1
    end
    
  end
  

  -----------------------------
  -- REGISTER STYLES
  -----------------------------

  oUF:RegisterStyle("oUF_D3Orbs2_player", CreatePlayerStyle)
  oUF:RegisterStyle("oUF_D3Orbs2_target", CreateTargetStyle)
  oUF:RegisterStyle("oUF_D3Orbs2_tot", CreateToTStyle)
  oUF:RegisterStyle("oUF_D3Orbs2_focus", CreateFocusStyle)
  
  -----------------------------
  -- SPAWN UNITS
  -----------------------------
  
  oUF:SetActiveStyle("oUF_D3Orbs2_target")
  oUF:Spawn("target","oUF_D3Orbs2_TargetFrame"):SetPoint(tabvalues.frame_positions[3].a1, tabvalues.frame_positions[3].af, tabvalues.frame_positions[3].a2, tabvalues.frame_positions[3].x, tabvalues.frame_positions[3].y)  
  oUF:SetActiveStyle("oUF_D3Orbs2_player")
  oUF:Spawn("player", "oUF_D3Orbs2_PlayerFrame"):SetPoint(tabvalues.frame_positions[2].a1, tabvalues.frame_positions[2].af, tabvalues.frame_positions[2].a2, tabvalues.frame_positions[2].x, tabvalues.frame_positions[2].y)  
  oUF:SetActiveStyle("oUF_D3Orbs2_tot")
  oUF:Spawn("targettarget","oUF_D3Orbs2_ToT"):SetPoint(tabvalues.frame_positions[4].a1, tabvalues.frame_positions[4].af, tabvalues.frame_positions[4].a2, tabvalues.frame_positions[4].x, tabvalues.frame_positions[4].y)
  oUF:SetActiveStyle("oUF_D3Orbs2_focus")
  oUF:Spawn("focus","oUF_D3Orbs2_focus"):SetPoint(tabvalues.frame_positions[6].a1, tabvalues.frame_positions[6].af, tabvalues.frame_positions[6].a2, tabvalues.frame_positions[6].x, tabvalues.frame_positions[6].y)
  oUF:Spawn("focustarget","ouf_focustot"):SetPoint('CENTER', oUF.units.focus, 'CENTER', 200, 0)
  oUF:Spawn("pet","ouf_pet"):SetPoint('CENTER', oUF.units.focus, 'CENTER', 0, 250)
  
  local party  = oUF:Spawn("header", "oUF_Party")
  party:SetPoint(tabvalues.frame_positions[7].a1, tabvalues.frame_positions[7].af, tabvalues.frame_positions[7].a2, tabvalues.frame_positions[7].x, tabvalues.frame_positions[7].y)
  --party:SetManyAttributes("showParty", true, "xOffset", 10, "point", "RIGHT", "showPlayer", false)
  party:SetManyAttributes("showParty", true, "xOffset", 80, "point", "LEFT", "showPlayer", true)
  
  local arena = {}
  for i = 1, 5 do
  	arena[i] = oUF:Spawn("arena"..i, "oUF_D3Orbs2_Arena"..i)
  	if i == 1 then
  		arena[i]:SetPoint(tabvalues.frame_positions[7].a1, tabvalues.frame_positions[7].af, tabvalues.frame_positions[7].a2, tabvalues.frame_positions[7].x, tabvalues.frame_positions[7].y)
  	else
  		arena[i]:SetPoint("RIGHT", arena[i-1], "LEFT", 80, 0)
  	end
  end
 
  -------------------------------------------------------
  -- TOGGLE PARTY IN RAID (CURRENTLY NO)
  -------------------------------------------------------
  
  local partyToggle = CreateFrame("Frame")
  partyToggle:RegisterEvent("PLAYER_LOGIN")
  partyToggle:RegisterEvent("RAID_ROSTER_UPDATE")
  partyToggle:RegisterEvent("PARTY_LEADER_CHANGED")
  partyToggle:RegisterEvent("PARTY_MEMBER_CHANGED")
  partyToggle:SetScript("OnEvent", function(self)
    if(InCombatLockdown()) then
      self:RegisterEvent("PLAYER_REGEN_ENABLED")
    else
      self:UnregisterEvent("PLAYER_REGEN_ENABLED")
      if(GetNumRaidMembers() > 0) then
        if hidepartyinraid == 1 then
          party:Hide()
        else
          party:Show()
        end
      else
        party:Show()
      end
    end
  end)
  
  -----------------------------
  -- CREATING D3 ART FRAMES
  -----------------------------
  
  if use_rbottombarstyler ~= 1 then
    
    local d3f = CreateFrame("Frame",nil,UIParent)
    d3f:SetFrameStrata("TOOLTIP")
    d3f:SetWidth(320)
    d3f:SetHeight(160)
    d3f:SetPoint(tabvalues.frame_positions[8].a1, tabvalues.frame_positions[8].af, tabvalues.frame_positions[8].a2, tabvalues.frame_positions[8].x, tabvalues.frame_positions[8].y)
    d3f:Show()
    d3f:SetScale(playerscale)
    local d3t = d3f:CreateTexture(nil,"BACKGROUND")
    d3t:SetTexture("Interface\\AddOns\\rTextures\\d3_angel2")
    d3t:SetAllPoints(d3f)
  
    local d3f2 = CreateFrame("Frame",nil,UIParent)
    d3f2:SetFrameStrata("TOOLTIP")
    d3f2:SetWidth(320)
    d3f2:SetHeight(160)
    d3f2:SetPoint(tabvalues.frame_positions[9].a1, tabvalues.frame_positions[9].af, tabvalues.frame_positions[9].a2, tabvalues.frame_positions[9].x, tabvalues.frame_positions[9].y)
    d3f2:Show()
    d3f2:SetScale(playerscale)
    local d3t2 = d3f2:CreateTexture(nil,"BACKGROUND")
    d3t2:SetTexture("Interface\\AddOns\\rTextures\\d3_demon2")
    d3t2:SetAllPoints(d3f2)
    
    local d3f3 = CreateFrame("Frame",nil,UIParent)
    d3f3:SetFrameStrata("TOOLTIP")
    d3f3:SetWidth(500)
    d3f3:SetHeight(112)
    d3f3:SetPoint(tabvalues.frame_positions[10].a1, tabvalues.frame_positions[10].af, tabvalues.frame_positions[10].a2, tabvalues.frame_positions[10].x, tabvalues.frame_positions[10].y)
    d3f3:Show()
    d3f3:SetScale(playerscale)
    local d3t3 = d3f3:CreateTexture(nil,"BACKGROUND")
    d3t3:SetTexture("Interface\\AddOns\\rTextures\\d3_bottom")
    d3t3:SetAllPoints(d3f3)
    
    local d3f4 = CreateFrame("Frame",nil,UIParent)
    d3f4:SetFrameStrata("BACKGROUND")
    d3f4:SetWidth(512)
    d3f4:SetHeight(256)
    d3f4:SetPoint(tabvalues.frame_positions[11].a1, tabvalues.frame_positions[11].af, tabvalues.frame_positions[11].a2, tabvalues.frame_positions[11].x, tabvalues.frame_positions[11].y)
    d3f4:Show()
    d3f4:SetScale(playerscale)
    local d3t4 = d3f4:CreateTexture(nil,"BACKGROUND")
    d3t4:SetAllPoints(d3f4)
  
  
    
    if usebar == 2 then
      d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar1")
    elseif usebar == 3 then
      d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar2")
    elseif usebar == 4 then
      d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar3")
    else
      if MultiBarBottomRight:IsShown() then
        d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar3")
      elseif MultiBarBottomLeft:IsShown() then
        d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar2")
      else
        d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar1")
      end
      MultiBarBottomRight:HookScript("OnShow", function() d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar3") end)
      MultiBarBottomRight:HookScript("OnHide", function() d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar2") end)
      MultiBarBottomLeft:HookScript("OnShow", function() d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar2") end)
      MultiBarBottomLeft:HookScript("OnHide", function() d3t4:SetTexture("Interface\\AddOns\\rTextures\\bar1") end)
    end
  


  end
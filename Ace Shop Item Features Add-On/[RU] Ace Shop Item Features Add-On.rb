#-------------------------------------------------------------------------------
# Yanfly Engine Ace -  Ace Shop Item Features Add-On v0.2
# by MUR (https://github.com/murlab)
# BSD 3-Clause License
# # Свободное использование как для бесплатных, так и коммерческих проектов.
# Небходим плагин Yanfly's Ace Shop Options.
# Расположите этот скрипт после Yanfly's Shop Options
#-------------------------------------------------------------------------------

module YEA
  module SHOP
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ★ Vocab Ex-Parameters
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    EXPARAM = {
      # HIT - HIT rate
      # Chance of a physical attack scoring a hit on a target
      0 => "Меткость",
      
      # EVA - EVAsion rate
      # Chance of evading a physical attack
      1 => "Уклон",
      
      # CRI - CRItical rate
      # Chance of scoring a critical hit
      2 => "Крит.",
      
      # CEV - Critical EVasion rate
      # Chance of preventing a critical hit
      3 => "Крит.уклон",
      
      # MEV - Magic EVasion rate
      # Chance of nullifying a magic attack
      4 => "Маг.уклон",
      
      # MRF - Magic ReFlection rate
      # Chance of reflecting back a magic attack
      5 => "Маг.отражение",
      
      # CNT - Сounterattack rate
      # Chance of a counterattack against a physical attack
      6 => "Контратака",
      
      # HRG - Hp ReGeneration rate
      # Percentage of HP restored at end of each turn
      7 => "Реген. HP",
      
      # MRG - Mp ReGeneration rate
      # Percentage of MP restored at end of each turn
      8 => "Реген. MP",
      
      # TRG - Tp ReGeneration rate
      # Percentage of TP added at end of each turn
      9 => "Реген. TP"
    }
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ★ Vocab Sp-Parameters
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    SPPARAM = {
      # TGR - Probability of being targeted
      # Chance of being a target of an enemy attack
      0 => "Мишень",
      
      # GRD - Defense effectiveness
      # Strength of damage reduction effect of the defense command
      1 => "Оборона",
      
      # REC - Recovery effectiveness
      # Percentage of HP/MP recovery effect received
      2 => "Регенерация",
      
      # PHA - Medicine lore
      # Percentage of HP/MP recovery enhancement by an item
      3 => "Усил.Реген.",
      
      # MCR - MP consumption rate
      # Percentage by which to vary MP consumption by a skill
      4 => "Расход маны",
      
      # TCR - TP charge rate
      # Percentage by which to vary TP charging by a skill/item
      5 => "Заряд TP",
      
      # PDR - Physical damage rate
      # Percentage of physical damage received
      6 => "Физ.Уязвимость",
      
      # MDR - Magic damage rate
      # Percentage of magic damage received
      7 => "Маг.Уязвимость",         
      
      # FDR - Floor damage rate
      # Percentage of damage received from map terrain
      8 => "Урон пола",
      
      # EXR - Experience acquisition rate
      # Percentage at which to vary the amount of experience points acquired
      9 => "Рост опыта"
    }
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ★ Vocab Special slot
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    SPSLOT = {
      # none
      0 => "Нет",
      
      # Dual Wield
      # This enables the equipping of two weapons in exchange for not being
      # able to equip a shield.
      1 => "Двуручное оружие"
    }

    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ★ Vocab Special flag
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    SPFLAG = {
      # Auto Battle
      # Character acts independently without accepting player commands
      0 => "Без контроля",
      
      # Guard
      # Reduces damage taken at a set rate
      1 => "Защищается",
      
      # Substitute
      # Character suffers attack in place of allies with less HP.
      2 => "Охраняет",
      
      # Preserve TP
      # Accumulated TP are retained for the next battle.
      # Without Preserve TP, TP is reset at each combat and TP of each
      # character is set at random when beginning the next battle.  
      3 => "Сберегает TP"
    }
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ★ Vocab Collapse effect
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # Collapse Effect
    # Valid only for enemies. Changes the effect for when they are knocked out
    # to the one that you specify.
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    COLLAPSE_EFFECT = {
      0 => "Босс",                  # Boss
      1 => "Раствориться",          # Instant
      2 => "Не исчезает"            # Not disappear
    }

    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ★ Vocab Party ability
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    PARTY_ABILITY = {
      # Halve Encounters
      # Halves the frequency of encounters while moving on the map.
      0 => "Столкновения реже",     
      
      # Disable Encounters
      # Eliminates the chance of encounters while moving on the map.
      1 => "Нет столкновений",
      
      # Disable Surprise
      # Eliminates the chance of surprises (situations in which only the enemy
      # troop is able to act on the first turn) when battles occur.
      2 => "Обход засад",
      
      # Increase Preemptive Strike Rate
      # Increases the chance of a preemptive strike (only the party is able
      # to act on the first turn) when battles occur.
      3 => "↑Упреждающий удар",
      
      # Double Money Earned
      # Doubles the amount of gold earned when the party wins a battle.
      4 => "↑Деньги x2",

      # Double Item Acquisition Rate
      # Doubles the chance of getting items from enemies when the party wins
      # a battle (only when items have been set for the defeated enemy).
      5 => "↑Находки x2"             
    }

    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ★ Vocab Item Information
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    ITEM_INFO = {
      # Element Rate 
      # Changes damage taken from elemental attacks. Specify the target element
      # and the rate of variability (0 to 1000%). Specifying a rate over 100%
      # results in damage greater than the standard amount, indicating
      # a weakness against the specified element
      :element_rate => "Воздействие «%s» %s%%",
      
      # Debuff Rate
      # Changes the probability at which the use of a skill or item for which
      # the Debuff effect has been set will succeed in debuffing a parameter.
      # Specify the target parameter and the rate of variability (0 to 1000%).
      # A 100% setting means no variability
      :debuff_rate => "«%s» на %s%% меньше",
      
      # State Rate 
      # Changes the probability at which the use of a skill or item for which
      # the Add State effect has been set will succeed in adding a state.
      # Specify the target state and the rate of variability (0 to 1000%).
      # A 100% setting means no variability.
      :state_rate => "Шанс «%s» %s%%",
      
      # State Resist 
      # Negates the specified state. Specifying K.O. results in characters
      # failing to be knocked out even when their HP falls to 0.
      :state_resist => "Иммунитет к «%s»",
      
      # Parameter
      # Rate of increase/decrease for parameters such as max HP and ATK.
      # Specify the target parameter and the rate of variability (0 to 1000%).
      # A 100% setting means no variability.
      :parameter => "Установит «%s» %s%%",
      
      # Ex-Parameter 
      # The rate of increase/decrease for additional parameters such as max
      # accuracy and evasion. Specify the target parameter and the percentage
      # to add on (-100 to 100%). The default value is 0%.
      :ex_parameter => "Изменит «%s» на %s%%",
      
      # Sp-Parameter
      # The rate of increase/decrease for special parameters such as
      # probability of being targeted for attack and defense effectiveness.
      # Specify the target parameter and the rate of variability (0 to 1000%).
      # The default value is 100%.
      :sp_parameter => "Установит «%s» на %s%%",
      
      # Atk Element 
      # Applies an element for normal attacks.
      :atk_element => "Атака «%s»",
      
      # Atk State
      # Applies a state change effect for normal attacks. Specify the target
      # effect and the success variability (0 to 1000%). A 100% setting means
      # no variability.
      :atk_state => "Шанс «%s» %s%%",
      
      # Atk Speed
      # Increases/decreases agility when the player selects a normal attack
      # in battle. Specify a value between -999 and 999.
      :atk_speed => "Скорость атаки %s",
      
      # Atk Times+
      # Increases the number of times a normal attack damages a target.
      # The standard value is 1. Specify the number of times you want to
      # increase it.
      :atk_times => "Дополнительные атаки +%s",
      
      # Add Skill Type
      # Allows the specified skill type to be selected as a command.
      :add_skill_type => "+Тип навыков «%s»",
      
      # Disable Skill Type 
      # Prevents the specified skill type from being selected.
      :disable_skill_type => "-Тип навыков «%s»",
      
      # Add Skill
      # Sets the specified skills as being available for use.
      :add_skill => "+Навык «%s»",
      
      # Disable Skill 
      # Disables the use of the specified skill.
      :disable_skill => "-Навык «%s»",
      
      # Equip Weapon 
      # Enables the equipping of the specified type of weapon.
      :equip_weapon => "Можно взять «%s»",
      
      # Equip Armor
      # Enables the equipping of the specified type of armor.
      :equip_armor => "Можно одеть «%s»",
      
      # Lock Equip
      # Prevents the changing of equipment for the specified equipment slot.
      # Used for instances where you do not want the player changing
      # the equipment of an actor that has been temporarily added to the party.
      :lock_equip => "Заперает слот «%s»",
      
      # Seal Equip
      # Prevents the equipping of equipment for the specified equipment slot.
      # For example, preventing the use of shields for a given weapon makes
      # it a two-handed weapon, and preventing the wearing of a headgear for
      # a given piece of armor results in full body armor.
      :seal_equip => "Блокирует слот «%s»",
      
      # Slot Type
      # Can only be set to Dual Wield. This enables the equipping of two
      # weapons in exchange for not being able to equip a shield.
      :slot_type => "+Слот «%s»",
      
      # Action Times+
      # Increases by one the number of times actions can be taken in battle
      # by the specified probability. When you apply multiple instances of this
      # setting, the game decides whether to increase the number of times
      # actions can be taken individually based on the specified probabilities.
      # For example, entering 50% twice results in the probability of
      # the actions increasing by two and the probability of them not even
      # increasing by one to both be 25% (50% × 50%).
      :action_times => "Шанс доп.хода %s%%",
      
      # Special Flag
      # Applies a feature relating to battle actions.
      :special_flag => "Устанавливает «%s»",

      # Collapse Effect 
      # Valid only for enemies. Changes the effect for when they are knocked
      # out to the one that you specify.
      :collapse_effect => "При смерти «%s»",

      # Party Ability 
      # Applies a feature relating to party actions. It is enabled as a
      # characteristic for the entire party if at least one of the party
      # members has it.
      :party_ability => "Группа «%s»",
    }

    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ★ Colours
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # Colours associated with usefulness.
    # The colours are specified as RGB values
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    COLOURS = {
      :green => [204, 255, 137],    # good usefulness
      :red => [245, 0, 10],         # bad usefulness
      :white => [255, 255, 255],    # not used
      :violet => [197, 122, 255],   # not used
      :orange => [255, 84, 0]       # not used
    }
  end
end

#==============================================================================
# ★ Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================


#==============================================================================
# ■ Scene_Shop
#==============================================================================
class Scene_Shop < Scene_MenuBase

  #--------------------------------------------------------------------------
  # alias method: create_dummy_window
  #--------------------------------------------------------------------------
  def create_dummy_window
    scene_shop_create_dummy_window_aso
    @dummy_window.height = @dummy_window.height -  @gold_window.height
    @dummy_window.opacity = 0
  end
  
  #--------------------------------------------------------------------------
  # alias method: create_gold_window
  #--------------------------------------------------------------------------
  def create_gold_window
    scene_shop_create_gold_window_aso
    @gold_window.width = 160
    @gold_window.create_contents
    @gold_window.refresh
    @gold_window.x = 0
  end
  
  #--------------------------------------------------------------------------
  # new method: relocate_windows
  #--------------------------------------------------------------------------
  def relocate_windows
    
    @gold_window.y = @command_window.y + @command_window.height
    @buy_window.y = @gold_window.y + @gold_window.height
    @sell_window.y = @gold_window.y + @gold_window.height
    
    return unless $imported["YEA-AceMenuEngine"]
    case Menu.help_window_location
    when 0 # Top     
      @command_window.y = @help_window.height
      @gold_window.y = @command_window.y + @command_window.height
      @status_window.y = @gold_window.y + @gold_window.height
      @help_window.y = 0
      @sell_window.y = @gold_window.y + @gold_window.height   

    when 1 # Middle
      @command_window.y = 0
      @gold_window.y = @command_window.y + @command_window.height
      @help_window.y = @gold_window.y + @gold_window.height
      @status_window.y = @help_window.y + @help_window.height      
      @sell_window.y = @status_window.y   
      
    else # Bottom
      @command_window.y = 0
      @gold_window.y = @command_window.y + @command_window.height
      @status_window.y = @gold_window.y + @gold_window.height
      @help_window.y = @status_window.y + @status_window.height
      @sell_window.y = @gold_window.y + @gold_window.height   
    end

    @category_window.y = @command_window.y
    @data_window.y = @command_window.y
    @buy_window.y = @status_window.y
    @number_window.y = @status_window.y
  end
end

class Window_ShopCommand < Window_HorzCommand 
  #--------------------------------------------------------------------------
  # overwrite method: visible_line_number
  #--------------------------------------------------------------------------
  def visible_line_number; return 5; end

end
  
class Window_ShopCategory < Window_Command
  #--------------------------------------------------------------------------
  # visible_line_number
  #--------------------------------------------------------------------------
  def visible_line_number; return 5; end
    
  end
  
class Window_ShopData < Window_Base
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(dx, dy, item_window)
    super(dx, dy, Graphics.width - dx, fitting_height(7))
    @item_window = item_window
    @item = nil
    refresh
  end
  
  #--------------------------------------------------------------------------
  # draw_empty
  #--------------------------------------------------------------------------
  def draw_empty
    colour = Color.new(0, 0, 0, translucent_alpha/2)
    rect = Rect.new(1, 1, 94, 94)
    contents.fill_rect(rect, colour)
    dx = 96; dy = 0
    dw = (contents.width - 96) / 2
    for i in 0...8
      draw_background_box(dx, dy, dw)
      dx = dx >= 96 + dw ? 96 : 96 + dw
      dy += line_height if dx == 96
    end

    dx = 0; dy = 96
    dw = contents.width / 2
    draw_background_box(dx, dy, dw)
    draw_background_box(dx + dw, dy, dw)
    dy += line_height
    draw_background_box(dx, dy , dw)
    draw_background_box(dx + dw, dy, dw)
    dy += line_height
    draw_background_box(dx, dy , dw)
    draw_background_box(dx + dw, dy, dw)
  end
  
  #--------------------------------------------------------------------------
  # draw_item_stats
  #--------------------------------------------------------------------------
  def draw_item_stats
    return unless @item.is_a?(RPG::Weapon) || @item.is_a?(RPG::Armor)
    dx = 96; dy = 0
    dw = (contents.width - 96) / 2
    for i in 0...8
      draw_equip_param(i, dx, dy, dw)
      dx = dx >= 96 + dw ? 96 : 96 + dw
      dy += line_height if dx == 96
    end
    
    dx = 0; dy = 96
    dw = contents.width / 2
    draw_feature_param(0, dx, dy, dw)
    draw_feature_param(1, dx + dw, dy, dw)
    dy += line_height
    draw_feature_param(2, dx, dy , dw)
    draw_feature_param(3, dx + dw, dy, dw)
    dy += line_height
    draw_feature_param(4, dx, dy , dw)
    draw_feature_param(5, dx + dw, dy, dw)
  end
 
  #--------------------------------------------------------------------------
  # draw_feature_param
  #--------------------------------------------------------------------------
  def get_color(color)
    arr = YEA::SHOP::COLOURS[color]
    return Color.new(*arr)
  end
  
  def get_ex_param(param_id)
    return YEA::SHOP::EXPARAM[param_id]
  end
  
  def get_sp_param(param_id)
    return YEA::SHOP::SPPARAM[param_id]
  end

  def get_sp_slot(param_id)
    return YEA::SHOP::SPSLOT[param_id]
  end

  def get_sp_flag(param_id)
    return YEA::SHOP::SPFLAG[param_id]
  end

  def get_collapse_effect(param_id)
    return YEA::SHOP::COLLAPSE_EFFECT[param_id]
  end
  
  def get_party_ability(param_id)
    return YEA::SHOP::PARTY_ABILITY[param_id]
  end
  
  def draw_feature_param(param_id, dx, dy, dw)
    draw_background_box(dx, dy, dw)
    change_color(get_color(:green))
    text = ""
    if @item.features[param_id]
      code = 0
      data_id = 0
      value = 0
      if @item.features[param_id].code
        code = @item.features[param_id].code
      end
      if @item.features[param_id].data_id
        data_id = @item.features[param_id].data_id
      end
      if @item.features[param_id].value
        value = @item.features[param_id].value
      end
      if value < 0
          change_color(get_color(:red))
      end
        
      case code
      when 11                             # Element Rate
        text = YEA::SHOP::ITEM_INFO[:element_rate]
        text %= [$data_system.elements[data_id], (value * 100).to_i.to_s]
         
      when 12                             # Debuff Rate
        change_color(get_color(:red))
        text = YEA::SHOP::ITEM_INFO[:debuff_rate]
        text %= [$data_system.terms.params[data_id], (value * 100).to_i.to_s]
        
      when 13                             # State Rate
        if $data_states[data_id].restriction > 1
          # 0 - none
          # 1 - attack an enemy
          # 2 - attack anyone
          # 3 - attan an ally
          # 4 - cannot move
          change_color(get_color(:red))
        end
        text = YEA::SHOP::ITEM_INFO[:state_rate]
        text %= [$data_states[data_id].name, (value * 100).to_i.to_s]
        
      when 14                           # State Resist
        text = YEA::SHOP::ITEM_INFO[:state_resist]
        text %= $data_states[data_id].name
        
      when 21                           # Parameter
        if value < 1
          change_color(get_color(:red))
        end
        text = YEA::SHOP::ITEM_INFO[:parameter]
        text %= [$data_system.terms.params[data_id], (value * 100).to_i.to_s]
        
      
      when 22                           # Ex-Parameter
        text = YEA::SHOP::ITEM_INFO[:ex_parameter]
        text %= [get_ex_param(data_id), (value * 100).to_i.to_s]
        
      when 23                           # Sp-Parameter
        text = YEA::SHOP::ITEM_INFO[:sp_parameter]
        text %= [get_sp_param(data_id), (value * 100).to_i.to_s]
        
      when 31                           # Atk Element
        text = YEA::SHOP::ITEM_INFO[:atk_element]
        text %= $data_system.elements[data_id]
        
    
      when 32                           # Atk State
        text = YEA::SHOP::ITEM_INFO[:atk_state]
        text %= [$data_states[data_id].name, (value * 100).to_i.to_s]
        
      when 33                           # Atk Speed
        text = YEA::SHOP::ITEM_INFO[:atk_speed]
        text %= value.to_i.to_s
        
      when 34                           # Atk Times+
        text = YEA::SHOP::ITEM_INFO[:atk_times]
        text %= value.to_i.to_s
        
      when 41                           # Add Skill Type
        text = YEA::SHOP::ITEM_INFO[:add_skill_type]
        text %= $data_system.skill_types[data_id]
        
      when 42                           # Disable Skill Type
        change_color(get_color(:red))
        text = YEA::SHOP::ITEM_INFO[:disable_skill_type]
        text %= $data_system.skill_types[data_id]
        
      when 43                           # Add Skill
        text = YEA::SHOP::ITEM_INFO[:add_skill]
        text %= $data_skills[data_id].name
        
      when 44                           # Disable Skill
        change_color(get_color(:red))
        text = YEA::SHOP::ITEM_INFO[:disable_skill]
        text %= $data_skills[data_id].name
        
      when 51                           # Equip Weapon
        text = YEA::SHOP::ITEM_INFO[:equip_weapon]
        text %= $data_system.weapon_types[data_id]
        
      when 52                           # Equip Armor
        text = YEA::SHOP::ITEM_INFO[:equip_armor]
        text %= $data_system.armor_types[data_id]
        
      when 53                           # Lock Equip
        change_color(get_color(:red))
        text = YEA::SHOP::ITEM_INFO[:lock_equip]
        text %= $data_system.terms.etypes[data_id]
        
      when 54                           # Seal Equip
        change_color(get_color(:red))
        text = YEA::SHOP::ITEM_INFO[:seal_equip]
        text %= $data_system.terms.etypes[data_id]
      
      when 55                           # Slot Type
        text = YEA::SHOP::ITEM_INFO[:slot_type]
        text %= get_sp_slot(data_id)
        
      when 61                           # Action Times+
        text = YEA::SHOP::ITEM_INFO[:action_times]
        text %= (value * 100).to_i.to_s

      when 62                           # Special Flag
        text = YEA::SHOP::ITEM_INFO[:special_flag]
        text %= get_sp_flag(data_id)
        
      when 63                           # Collapse Effect
        text = YEA::SHOP::ITEM_INFO[:collapse_effect]
        text %= get_collapse_effect(data_id)

      when 64                           # Party Ability 
        text = YEA::SHOP::ITEM_INFO[:party_ability]
        text %= get_party_ability(data_id)
        
      end
    end
    draw_text(dx+4, dy, dw-8, line_height, text)
  end
  
  #--------------------------------------------------------------------------
  # draw_equip_param ( Name Weapons & Armor )
  #--------------------------------------------------------------------------
  def draw_equip_param(param_id, dx, dy, dw)
    draw_background_box(dx, dy, dw)
    change_color(system_color)
    draw_text(dx+4, dy, dw-8, line_height, Vocab::param(param_id))
    if $imported["YEA-EquipDynamicStats"]
      draw_percentage_param(param_id, dx, dy, dw)
    else
      draw_set_param(param_id, dx, dy, dw)
    end
  end
  
  #--------------------------------------------------------------------------
  # draw_item_effects (Items & Key Items)
  #--------------------------------------------------------------------------
  def draw_item_effects
    return unless @item.is_a?(RPG::Item)
    dx = 96; dy = 0
    dw = (contents.width - 96) / 2
    draw_hp_recover(dx, dy + line_height * 0, dw)
    draw_mp_recover(dx, dy + line_height * 1, dw)
    draw_tp_recover(dx + dw, dy + line_height * 0, dw)
    draw_tp_gain(dx + dw, dy + line_height * 1, dw)
    dw = contents.width - 96
    draw_applies(dx, dy + line_height * 2, dw)
    draw_removes(dx, dy + line_height * 3, dw)
    
    dx = 0; dy = 96
    dw = contents.width / 2
    draw_feature_param(0, dx, dy, dw)
    draw_feature_param(1, dx + dw, dy, dw)
    dy += line_height
    draw_feature_param(2, dx, dy , dw)
    draw_feature_param(3, dx + dw, dy, dw)
    dy += line_height
    draw_feature_param(4, dx, dy , dw)
    draw_feature_param(5, dx + dw, dy, dw)
  end
end

class Window_Base < Window
  #--------------------------------------------------------------------------
  # * Draw Item Name
  #     enabled : Enabled flag. When false, draw semi-transparently.
  #--------------------------------------------------------------------------
  def draw_item_name(item, x, y, enabled = true, width = 202)
    return unless item
    draw_icon(item.icon_index, x, y, enabled)
    # Support Hime Item Rarity
    if $imported[:TH_ItemRarity] == true
      change_color(item.rarity_colour, enabled)
    end
    draw_text(x + 26, y, width, line_height, item.name)
		change_color(normal_color, enabled)
  end
end

class Window_ShopSell < Window_ItemList 
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(dx, dy, dw, dh)
    dw = Graphics.width - (Graphics.width * 2 / 5)
    dh = Graphics.height - SceneManager.scene.command_window.y
    dh -= SceneManager.scene.command_window.height + fitting_height(1)
    super(dx, dy, dw, dh)
  end
end

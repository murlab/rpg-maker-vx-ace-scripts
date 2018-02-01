#-------------------------------------------------------------------------------
# Event Move Speed v1.0
# by MUR (https://github.com/murlab)
# BSD 3-Clause License
# Free for use with both free and commercial RPG Maker games.
#-------------------------------------------------------------------------------

class Game_CharacterBase
  alias mur_game_charbase_init initialize
  def initialize
    mur_game_charbase_init
    @event_speed = 0
  end
  
  def get_event_speed
    return @event_speed
  end
  
  def set_event_speed(speed)
    @event_speed = speed
  end
  
  def real_move_speed  
    @move_speed + @event_speed
  end

end

class Game_Map
  alias mur_game_map_setup setup
  def setup(map_id)
    mur_game_map_setup(map_id)
    set_events_speed
  end
  
  def set_events_speed
    @events.values.each { |e|
      next if !e.list
      if e.list[0].code == 108 && e.list[0].parameters[0] =~ /<speed:(.*)>/
        e.set_event_speed($1.to_f)
        puts e.get_event_speed
      end
    }
  end

end

#-------------------------------------------------------------------------------
# Event Move Speed v1.2b
# by MUR (https://github.com/murlab)
# BSD 3-Clause License
# Free for use with both free and commercial RPG Maker games.
#-------------------------------------------------------------------------------

class Game_CharacterBase
  
  attr_accessor :event_speed
  attr_accessor :next_frame
  
  alias mur_game_charbase_init initialize
  def initialize
    mur_game_charbase_init
    @event_speed = 0
    @next_frame = 1
  end
 
  def real_move_speed  
    @move_speed + @event_speed
  end

  def update_anime_count
    if moving? && @walk_anime
      @anime_count += @next_frame + 0.5
    elsif @step_anime || @pattern != @original_pattern
      @anime_count += @next_frame
    end
  end
  
end

class Game_Map
  alias mur_game_map_setup setup
  def setup(map_id)
    mur_game_map_setup(map_id)

    @events.values.each do |e|
      next if e.list.nil?
      if e.list[0].code == 108
        if e.list[0].parameters[0] =~ /<speed:(.*)>/
          e.event_speed = $1.to_f
        end
        if e.list[0].parameters[0] =~ /<nextframe:(.*)>/
          e.next_frame = $1.to_f
        end
      end
    end
  end

end

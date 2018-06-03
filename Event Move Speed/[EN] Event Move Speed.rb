#-------------------------------------------------------------------------------
# Event Move Speed v1.2b
# by MUR (https://github.com/murlab)
# BSD 3-Clause License
# Free for use with both free and commercial RPG Maker games.
#-------------------------------------------------------------------------------
# Usage, add comment line into event:
#
# <speed: NN> where NN is a floating-point number. 
# The value 0 is the standard speed of movement (taking into event's settings).
# Number to less than zero, the speed will decrease.
# If you increase the value the character will "fly".
#
# <nextframe: NN> where NN is the number that will be added to change
# the next frame. By default, it is 1, but if, for example, you set
# the value to 0.1, it will be very slow.
# And if you specify a number greater than 1, then the opposite is very fast.

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

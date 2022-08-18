require_relative 'board'
require_relative 'position'
require_relative 'move'
require_relative 'player'

class Chess
  attr_reader :gameboard, :current_player

  def initialize
    @gameboard = Board.new
    @current_player = Player.new(:white)
  end

  def play
    loop do
      system 'clear'
      gameboard.draw

      move = get_move
      gameboard.update(move)
    end
  end

  private

  def get_move
    from = start_position
    to = target_position
    Move.new(from, to)
  end

  def start_position
    valid = false
    until valid
      puts 'enter starting position'
      input = gets.chomp
      position = Position.parse(input)

      valid = gameboard.piece_at(position)&.player_color == current_player.color
    end
    position
  end

  def target_position
    valid = false
    until valid
      puts 'enter target position'
      input = gets.chomp
      position = Position.parse(input)

      valid = position.valid? && gameboard.piece_at(position)&.player_color != current_player.color
    end
    position
  end
end

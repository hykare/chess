require_relative 'board'
require_relative 'position'
require_relative 'move'
require_relative 'player'
require_relative 'validation'

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

  # test that it returns a move
  def get_move
    move = nil
    loop do
      from = start_position
      to = target_position
      move = Move.new(from, to)

      valid = Validation.new(gameboard, move, current_player).result
      break if valid
    end
    move
  end

  def start_position
    puts 'enter starting position'
    input = gets.chomp
    Position.parse(input)
  end

  def target_position
    puts 'enter target position'
    input = gets.chomp
    Position.parse(input)
  end
end

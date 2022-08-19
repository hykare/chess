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
    move = nil
    loop do
      print Validation.message(gameboard, move, current_player)
      from = start_position
      to = target_position
      move = Move.new(from, to)

      break if Validation.valid?(gameboard, move, current_player)
    end
    move
  end

  def start_position
    puts 'from:'
    input = gets.chomp
    Position.parse(input)
  end

  def target_position
    puts 'to:'
    input = gets.chomp
    Position.parse(input)
  end
end

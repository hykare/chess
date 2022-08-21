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
      input = gets.chomp
      move = Move.parse(input)

      break if Validation.valid?(gameboard, move, current_player)
    end
    move
  end
end

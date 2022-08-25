class Chess
  attr_reader :gameboard, :current_player

  def initialize
    @gameboard = Board.new
    @current_player = Player.new(:white)
  end

  def play
    until gameboard.check?(current_player)
      system 'clear'
      gameboard.draw

      move = get_move
      ExecuteMove.for(gameboard, move)

      switch_player
    end
    puts "#{current_player.color} won!"
  end

def switch_player
  @current_player = Player.opponent(current_player)
end

  private

  def get_move
    move = nil
    loop do
      print Validation.message(gameboard, move, current_player)
      input = gets.chomp
      move = Move.parse(input)

      break if Validation.passes?(gameboard, move, current_player)
    end
    move
  end
end

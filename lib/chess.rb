class Chess
  attr_reader :gameboard, :current_player

  def initialize
    @gameboard = Board.new
    @current_player = Player.new(:white)
  end

  def play
    until game_over?
      refresh_display
      make_move
      switch_player
    end
    display_game_result
  end

  private

  def display_game_result
    puts "#{Player.opponent(current_player)} won!"
  end

  def refresh_display
    system 'clear'
    gameboard.draw
  end

  def game_over?
    GameResult.new(gameboard, current_player).game_over?
  end

  def switch_player
    @current_player = Player.opponent(current_player)
  end

  def make_move
    move = get_move
    ExecuteMove.for(gameboard, move)
  end

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

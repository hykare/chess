class Chess
  attr_reader :gameboard, :current_player

  include GameMessages
  include Persistence

  def initialize(player1 = Player.new(:white), player2 = Player.new(:black))
    @gameboard = Board.new
    @current_player = player1
    @players = [player1, player2]
  end

  def self.run
    display_options
    input = gets.chomp
    case input
    when '1'
      new.play
    when '2'
      new(Player.new(:white), Player.new(:black, :AI)).play
    when '3'
      load_saved_game.play
    when '4'
      exit
    end
  end

  def self.display_options
    puts '1  two players'
    puts '2  play against AI'
    puts '3  load saved game'
    puts '4  exit'
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
    if GameResult.new(gameboard, current_player).draw?
      draw_message
    else
      win_message
    end
  end

  def refresh_display
    system 'clear'
    gameboard.draw
  end

  def game_over?
    GameResult.new(gameboard, current_player).game_over?
  end

  def switch_player
    @current_player = @players.rotate!.first
  end

  def make_move
    move = get_move
    ExecuteMove.for(gameboard, move)
  end

  def get_move
    if current_player.type == :human
      input_prompt
      loop do
        input = gets.chomp

        if input == 'save'
          save
        else
          move = Move.parse(input)
          return move if Validation.passes?(gameboard, move, current_player)

          print Validation.message(gameboard, move, current_player)
        end
      end
    else
      # find all possible moves
      # choose one at random
      legal_moves = []
      Position.all do |start|
        Position.all do |target|
          move = Move.for(start, target)
          legal_moves << move if Validation.passes?(gameboard, move, current_player)
        end
      end
      legal_moves.sample
    end
  end
end

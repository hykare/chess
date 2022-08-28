module GameMessages
  def input_prompt
    print "enter #{current_player}'s move  (eg 'a4 to c6')\n"
  end

  def win_message
    print "Checkmate! #{Player.opponent(current_player)} wins.\n"
  end

  def draw_message
    print "it's a draw!\n"
  end
end

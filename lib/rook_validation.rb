class RookValidation < Validation
  def piece_move_valid?
    @message = "this piece can't move this way\n"

    move.horizontal? || move.vertical?
  end
end

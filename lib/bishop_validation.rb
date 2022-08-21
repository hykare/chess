class BishopValidation < Validation
  def piece_move_valid?
    @message = "this piece can't move this way\n"

    move.diagonal?
  end
end

class KingValidation < Validation
  def piece_move_valid?
    @message = "this piece can't move this way\n"

    move.distance.one?
  end
end

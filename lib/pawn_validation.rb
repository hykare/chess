class PawnValidation < Validation
  def piece_move_valid?
    @message = "this piece can't move this way"

    true
  end
end

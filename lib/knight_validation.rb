class KnightValidation < Validation
  def piece_move_valid?
    @message = "this piece can't move this way\n"

    [move.horizontal?, move.vertical?, move.diagonal?].none? && move.distance == 2
  end
end

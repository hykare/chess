class RookValidation < Validation
  def piece_move_valid?
    @message = "this piece can't move this way\n"

    # move.from.same_file?(move.to) || move.from.same_rank?(move.to)
    true
  end
end

class PawnValidation < Validation
  def piece_move_valid?
    @message = "this piece can't move this way\n"

    move_one = (move.from.file == move.to.file) && (move.to.rank == move.from.rank + 1)
    move_two = (move.from.file == move.to.file) && (move.from.rank == 2) && (move.to.rank == 4)

    move_one || move_two
  end
end

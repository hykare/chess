class WhitePawn < Pawn
  private

  def forward?(move)
    move.from.rank < move.to.rank
  end

  def starting_rank
    2
  end
end

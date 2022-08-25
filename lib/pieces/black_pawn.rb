class BlackPawn < Pawn
  private

  def forward?(move)
    move.from.rank > move.to.rank
  end

  def starting_rank
    7
  end
end

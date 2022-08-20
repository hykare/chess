class Move
  attr_reader :from, :to

  def initialize(from, to)
    @from = from
    @to = to
  end

  def self.parse(string)
    # string in the form 'd5 to e6'
    moves = string.split('to')
    from = Position.parse(moves.first.strip)
    to = Position.parse(moves.last.strip)
    new(from, to)
  end
end

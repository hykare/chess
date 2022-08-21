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
    self.for(from, to)
  end

  def self.for(from, to)
    if from.rank == to.rank
      MoveHorizontal
    elsif from.file == to.file
      MoveVertical
    elsif (from.file.ord - to.file.ord).abs == (from.rank - to.rank).abs
      MoveDiagonal
    else
      Move
    end.new(from, to)
  end

  def distance
    file_distance = (from.file.ord - to.file.ord).abs
    rank_distance = (from.rank - to.rank).abs
    [file_distance, rank_distance].max
  end

  def path
    []
  end

  def horizontal?
    false
  end

  def vertical?
    false
  end

  def diagonal?
    false
  end
end

class MoveHorizontal < Move
  def path
    rank = from.rank
    path = []
    ([from.file, to.file].min.succ...[from.file, to.file].max).each do |file|
      path.push(Position.new(rank, file))
    end
    path
  end

  def horizontal?
    true
  end

  def vertical?
    false
  end

  def diagonal?
    false
  end
end

class MoveVertical < Move
  def path
    file = from.file
    path = []
    ([from.rank, to.rank].min.succ...[from.rank, to.rank].max).each do |rank|
      path.push(Position.new(rank, file))
    end
    path
  end

  def horizontal?
    false
  end

  def vertical?
    true
  end

  def diagonal?
    false
  end
end

class MoveDiagonal < Move
  def path
    path = []
    files = from.file < to.file ? (from.file.succ...to.file).to_a : (to.file.succ...from.file).to_a.reverse
    ranks = from.rank < to.rank ? (from.rank.succ...to.rank).to_a : (to.rank.succ...from.rank).to_a.reverse

    coordinates = ranks.zip(files)
    coordinates.each do |coordinate|
      path.push(Position.new(coordinate.first, coordinate.last))
    end
    path
  end

  def horizontal?
    false
  end

  def vertical?
    false
  end

  def diagonal?
    true
  end
end

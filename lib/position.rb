class Position
  include Comparable

  attr_reader :rank, :file, :color

  LIGHT_TILE = :light_blue
  DARK_TILE = :blue

  def initialize(rank, file)
    @rank = rank
    @file = file
    @color = color_for(rank, file)
  end

  def self.all
    array = []
    position = first
    loop do
      yield position if block_given?
      array.push position
      break if position.last?

      position = position.successor
    end
    array
  end

  def self.parse(string)
    rank = string[1].to_i
    file = string[0]
    Position.new(rank, file)
  end

  def to_s
    "#{file}#{rank}"
  end

  def eql?(other)
    rank == other.rank && file == other.file
  end

  def ==(other)
    other.is_a?(self.class) && rank == other.rank && file == other.file
  end

  def hash
    "#{file}#{rank}".hash
  end

  def self.first
    new(8, 'a')
  end

  def last?
    rank == 1 && file == 'h'
  end

  def starts_rank?
    file == 'a'
  end

  def ends_rank?
    file == 'h'
  end

  def valid?
    rank.between?(1, 8) && file.between?('a', 'h')
  end

  def successor
    return nil if last?

    successor_rank = ends_rank? ? rank - 1 : rank
    successor_file = ends_rank? ? 'a' : file.succ
    Position.new(successor_rank, successor_file)
  end

  def <=>(other)
    [rank, file] <=> [other.rank, other.file]
  end

  private

  def color_for(rank, file)
    return LIGHT_TILE if 'aceg'.include?(file) && rank.even? || 'bdfh'.include?(file) && rank.odd?

    DARK_TILE
  end
end

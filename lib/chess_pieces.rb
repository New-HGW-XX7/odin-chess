class Piece
  attr_reader :color, :row, :column
  def initialize(color, row, column)
    @color = color
    @row = row
    @column = column
  end

  def is_in_legal?(row, column)
    self.legal_moves.any? { |set, subset| subset.include?([row, column]) }
  end

  def has_legal_moves?
    self.legal_moves.any? { |set, subset| !subset.empty? }
  end
end
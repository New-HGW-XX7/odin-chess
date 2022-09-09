class Piece
  attr_reader :color, :row, :column
  def initialize(color, row, column)
    @color = color
    @row = row
    @column = column
  end
end
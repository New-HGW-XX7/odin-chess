class Piece
  attr_reader :color
  def initialize(color, row, column)
    @color = color
    @row = row
    @column = column
  end
end
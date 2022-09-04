class Piece
  def initialize(color, row, column)
    @color = color
    @row = row
    @column = column
  end
end

class Rook < Piece
  def initialize(color, row, column)
    super
    @type = 'rook'
  end
end
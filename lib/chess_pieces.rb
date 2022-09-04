class Piece
  def initialize(color, row, column)
    @color = color
    @row = row
    @column = column
  end
end

class Rook < Piece
  attr_reader :sign
  def initialize(color, row, column)
    super
    @type = 'rook'
    @sign = color == 'white' ? 'WR' : 'BR'
  end
end
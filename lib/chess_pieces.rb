class Piece
  def initialize(color, row, column)
    @color = color
    @row = row
    @column = column
  end
end

class Rook < Piece
  attr_reader :sign, :legal_moves
  def initialize(color, row, column)
    super
    @type = 'rook'
    @sign = color == 'white' ? 'WR' : 'BR'
    @legal_moves = {
      up: [], # Up meaning lowering row values
      down: [], # Increasing row values
      left: [], # Same row, lower column values
      right: [] # Same row, higher column values
    }
    # @legal_moves[:up] << [column, row] Run respective methods here
  end
end
require './lib/chess_pieces.rb'

class Game

  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
  end

  def test_piece
    p Rook.new('white', 2, 2)
  end

end

game = Game.new
game.test_piece
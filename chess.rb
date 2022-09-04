require './lib/chess_pieces.rb'

class Game

  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
  end

  def print_board
    @board.each do |subarr|
      counter = 0
      subarr.each do |value|
        counter += 1
        if value.nil?
          if counter == 8
            print "[   ]\n"
          else
            print "[   ] "
          end
        else
          if counter == 7
            print "[ #{value.color} ]\n"
          else
            print "[ #{value.color} ] "
          end
        end
      end
    end
  end

  def test_piece
    p Rook.new('white', 2, 2)
  end

end

game = Game.new
game.test_piece
game.print_board
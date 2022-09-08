require './lib/chess_pieces.rb'
require './lib/rook.rb'
require './lib/bishop.rb'
require './lib/queen.rb'
require './lib/knight.rb'

class Game
  attr_accessor :board
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
            print "[  ]\n"
          else
            print "[  ]"
          end
        else
          if counter == 8
            print "[#{value.sign}]\n"
          else
            print "[#{value.sign}]"
          end
        end
      end
    end
  end

  def test_piece
    knight = Knight.new('black', 7, 7)
    knight.find_legal_moves(@board)
    knight
  end

end

game = Game.new

# game.board[1][1] = Rook.new('white', 1, 1)
# game.board[3][1] = Rook.new('white', 3, 1)
# game.board[1][3] = Rook.new('white', 1, 3)
# game.board[3][3] = Rook.new('white', 3, 3)

game.board[6][5] = Rook.new('white', 1, 1)
# game.board[2][0] = Rook.new('black', 2, 0)
# game.board[5][2] = Rook.new('white', 5, 2)
# game.board[2][5] = Rook.new('white', 2, 5)



knight = game.test_piece
game.board[7][7] = knight
game.print_board
p knight
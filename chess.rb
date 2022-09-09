require './lib/chess_pieces.rb'
require './lib/rook.rb'
require './lib/bishop.rb'
require './lib/queen.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/king.rb'

class Game
  attr_accessor :board
  def initialize
    # @board = Array.new(8) { Array.new(8, nil) }
    @board = [
      [Rook.new('black', 0, 0), Knight.new('black', 0, 1), Bishop.new('black', 0, 2), Queen.new('black', 0, 3), King.new('black', 0, 4), Bishop.new('black', 0, 5), Knight.new('black', 0, 6), Rook.new('black', 0, 7)], # Row 0
      [Pawn.new('black', 1, 0), Pawn.new('black', 1, 1), Pawn.new('black', 1, 2), Pawn.new('black', 1, 3), Pawn.new('black', 1, 4), Pawn.new('black', 1, 5), Pawn.new('black', 1, 6), Pawn.new('black', 1, 7)], # Row 1
      [nil, nil, nil, nil, nil, nil, nil, nil], # Row 2
      [nil, nil, nil, nil, nil, nil, nil, nil], # Row 3
      [nil, nil, nil, nil, nil, nil, nil, nil], # Row 4
      [nil, nil, nil, nil, nil, nil, nil, nil], # Row 5
      [Pawn.new('white', 6, 0), Pawn.new('white', 6, 1), Pawn.new('white', 6, 2), Pawn.new('white', 6, 3), Pawn.new('white', 6, 4), Pawn.new('white', 6, 5), Pawn.new('white', 6, 6), Pawn.new('white', 6, 7)], # Row 6
      [Rook.new('white', 7, 0), Knight.new('white', 7, 1), Bishop.new('white', 7, 2), Queen.new('white', 7, 3), King.new('white', 7, 4), Bishop.new('white', 7, 5), Knight.new('white', 7, 6), Rook.new('white', 7, 7)] # Row 7
    ]
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
    king = King.new('black', 2, 2)
    king.find_legal_moves(@board)
    king
  end

  # def play
  #   Set up board with piece objects
  #   Generate legal moves for every piece
  #   Set player_color to white
  #   - Loop
  #   Prompt player with color to select piece #select_piece(player_color)
  #     -> if field nil or piece not own color or has no legal moves* repeat prompt - *if piece is king check if only left -> tie
  #   Assign variable holding piece
  #   Prompt player to select target field #select_targetfield(coords)
  #     1. Check if target is in legal moves of piece -> #is_in_legal?(target coords)
  #     2. Check if move will produce check for self -> either #is_white_king_threatened?(copy of board with move done) or #is_black_king_threatened?(copy)
  #     3. If criteria met perform move -> #move_piece(piece coords, target coords)
  #   Check if enemy is checked -> #is_white/black_king_threatened?(board)
  #     If yes, declare check and evaluate checkmate
  #     #is_checkmate?(board, enemyking)
  #       if king has legal moves -> false
  #       else determine path of attack + attacking pieces coords
  #         -> can any own piece intercept?
  #         if yes -> false
  #         else true
  #   If checkmate true break loop
  #   If checkmate false change player_color
  # end


        

end

game = Game.new
game.print_board


# # game.board[1][1] = Rook.new('white', 1, 1)
# # game.board[3][1] = Rook.new('white', 3, 1)
# game.board[3][2] = Rook.new('white', 3, 2)
# game.board[3][1] = Rook.new('white', 3, 1)
# game.board[3][3] = Rook.new('white', 3, 3)
# # game.board[2][0] = Rook.new('black', 2, 0)
# # game.board[5][2] = Rook.new('white', 5, 2)
# # game.board[2][5] = Rook.new('white', 2, 5)



# king = game.test_piece
# game.board[2][2] = king
# game.print_board
# p king
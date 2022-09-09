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

  def generate_legal_moves_all(board = @board)
    # Need to clear and regenerate movesets each turn
    board.each do |row|
      row.each do |field|
        field.find_legal_moves(board) unless field.nil?
        puts "#{field.sign} at #{field.row} / #{field.column} has moves: #{field.legal_moves}" unless field.nil?
      end
    end
  end

  def print_board
    @board.each do |row|
      counter = 0
      row.each do |field|
        counter += 1
        if field.nil?
          if counter == 8
            print "[  ]\n"
          else
            print "[  ]"
          end
        else
          if counter == 8
            print "[#{field.sign}]\n"
          else
            print "[#{field.sign}]"
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
  
  def select_piece(player_color, board = @board, row = nil, column = nil)
    until !board[row][column].nil? and board[row][column].color == player_color
    puts 'Select row'
    row = gets.chomp.to_i
    puts 'Select column'
    column = gets.chomp.to_i
    end
    # Check for tie
    board[row][column]
  end

  def select_targetfield(piece, player_color = player_color, board = @board, row = nil, column = nil)
    status_legal = false
    until status_legal # Is move legal in principle?
      puts 'Select target row'
      row = gets.chomp.to_i
      puts 'Select target column'
      column = gets.chomp.to_i

      piece.is_in_legal?(row, column) ? status_legal = true : puts 'Illegal move'
    end

    status_noselfcheck = false
    until status_noselfcheck # Will move open up own king? Create temporary new instance of Game with move performed?
      # gets coords
      temp_game = Game.new
      temp_game.move(coords)
      temp_board = temp_game.board
      is_king_threatened?(temp_board, player_color) ? puts 'Illegal. Would selfcheck' : status_noselfcheck = true
    end
  end

  def is_king_threatened?(board, color_of_king)
    board.generate_legal_moves_all
    possible_threats = []
    king_row = nil
    king_column = nil
    board.each do |row|
      row.each do |field|
        king_row = field.row if !field.nil? and field.type == 'king' and field.color == color_of_king
        king_column = field.column if !field.nil? and field.type == 'king' and field.color == color_of_king
        field << possible_threats unless field.nil? or field.color == color_of_king
      end
    end

    possible_threats.any? do |piece|
      piece.legal_moves.any? { |set| set.include?([king_row, king_column]) }
    end
  end



  def play
    generate_legal_moves_all
    player_color = 'white'
    # Start loop
    selected_piece = select_piece(player_color)
    select_targetfield(selected_piece)

  # def play
  #   Set up board with piece objects
  #   Generate legal moves for every piece
  #   Set player_color to white
  #   - Loop
  #   Prompt player with color to select piece #select_piece(player_color)
  #     -> if field nil or piece not own color or has no legal moves* repeat prompt - *if piece is king check if only left -> tie

  #   Assign variable holding piece || selected_piece = return of previous prompt

  #   Prompt player to select target field -> #select_targetfield(selected_piece)
  #     1. Check if target is in legal moves of piece -> #is_in_legal?(target coords) || selected_piece.is_in_legal?(x, y)

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
game.generate_legal_moves_all
p game.board[0][1]
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
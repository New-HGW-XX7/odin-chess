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
      [nil, Knight.new('white', 3, 1), nil, nil, nil, nil, nil, nil], # Row 3
      [nil, nil, nil, nil, nil, nil, nil, nil], # Row 4
      [nil, nil, nil, nil, nil, nil, nil, nil], # Row 5
      [Pawn.new('white', 6, 0), Pawn.new('white', 6, 1), Pawn.new('white', 6, 2), Pawn.new('white', 6, 3), Pawn.new('white', 6, 4), Pawn.new('white', 6, 5), Pawn.new('white', 6, 6), Pawn.new('white', 6, 7)], # Row 6
      [Rook.new('white', 7, 0), Knight.new('white', 7, 1), Bishop.new('white', 7, 2), Queen.new('white', 7, 3), King.new('white', 7, 4), Bishop.new('white', 7, 5), Knight.new('white', 7, 6), Rook.new('white', 7, 7)] # Row 7
    ]
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

  def generate_legal_moves_all
    # Need to clear and regenerate movesets each turn
    self.board.each do |row|
      row.each do |field|
        unless field.nil?
          field.legal_moves.each do |set, subset| 
            until subset.empty?
              subset.pop
            end
          end 
        end

        field.find_legal_moves(self.board) unless field.nil?
        #puts "#{field.sign} at #{field.row} / #{field.column} has moves: #{field.legal_moves}" unless field.nil?
      end
    end
  end

  def test_piece
    king = King.new('black', 2, 2)
    king.find_legal_moves(@board)
    king
  end
  
  def select_piece(player_color, board = @board)
    row = 99
    column = 99
    until !board[row].nil? and !board[row][column].nil? and board[row][column].color == player_color and board[row][column].has_legal_moves?
    puts "Player #{player_color}, select row"
    row = gets.chomp.to_i
    puts 'Select column'
    column = gets.chomp.to_i
    end
    # Check for tie
    board[row][column]
  end
  
  def select_targetfield(piece)
    row = 99
    column = 99
    status_legal = false
    until status_legal
      puts "Player #{piece.color}, select target row"
      row = gets.chomp.to_i
      puts 'Select target column'
      column = gets.chomp.to_i
      
      # Setting up second condition
      temp_game = Game.new
      copy_of_mainboard = Marshal.load( Marshal.dump(@board) )
      temp_game.board = copy_of_mainboard
      # puts 'Instance of Game created'
      # puts "mainboard: #{self.board}"
      # puts "\n\n"
      # puts "tempboard: #{temp_game.board}"
      temp_game.move(piece.row, piece.column, row, column)

      if (piece.is_in_legal?(row, column) == true) and (temp_game.is_king_threatened?(piece.color) == false) # Checking own king
        status_legal = true
      else 
        puts 'Illegal move' # Need to go back to piece selection
        return false
      end
    end
    [row, column]
  end
  
  def move(origin_row, origin_column, target_row, target_column)
    self.board[target_row][target_column] = board[origin_row][origin_column]
    self.board[origin_row][origin_column] = nil

    #Updating the piece
    self.board[target_row][target_column].row = target_row
    self.board[target_row][target_column].column = target_column
    #self.board[target_row][target_column].legal_moves
  end

  def is_king_threatened?(color_of_king)
    self.generate_legal_moves_all
    possible_threats = []
    king_row = nil
    king_column = nil
    self.board.each do |row|
      row.each do |field|
        king_row = field.row if !field.nil? and field.type == 'king' and field.color == color_of_king
        king_column = field.column if !field.nil? and field.type == 'king' and field.color == color_of_king
        possible_threats << field unless field.nil? or field.color == color_of_king
      end
    end

    possible_threats.any? do |piece|
      piece.legal_moves.any? { |set, subset| subset.include?([king_row, king_column]) }
    end
  end

  def is_checkmate?(color_of_king)
    #self.generate_legal_moves_all
    pieces_of_defender = []
    king_row = nil
    king_column = nil
    king = nil
    self.board.each do |row|
      row.each do |field|
        pieces_of_defender << field if !field.nil? and field.color == color_of_king and field.type != 'king' # Gets all pieces except king
        pieces_of_defender.unshift(field) if !field.nil? and field.color == color_of_king and field.type == 'king' # Sets king on position array.first
        king_row = pieces_of_defender.first.row
        king_column = pieces_of_defender.first.column
      end
    end

    evaluation_array = []
    pieces_of_defender.each do |piece|
      piece.legal_moves.each do |set, subset|
        subset.each do |move|
          temp_game = Game.new
          copy_of_mainboard = Marshal.load( Marshal.dump(@board) )
          temp_game.board = copy_of_mainboard
          temp_game.move(piece.row, piece.column, move.first, move.last)

          evaluation_array << temp_game.is_king_threatened?(color_of_king)
        end
      end
    end
    evaluation_array.include?(false) ? false : true
  end

    # Simulate each interception and check if king is still threatened -> if still threatened, checkmate

  def play
    game_over = false
    checkmate = false
    player_color = 'white'
    enemy_color = 'black'
    until checkmate # Start loop 
    self.generate_legal_moves_all
    self.print_board
    selected_piece = select_piece(player_color)
    selected_coordinates = select_targetfield(selected_piece)
    next if selected_coordinates == false
    self.move(selected_piece.row, selected_piece.column, selected_coordinates[0], selected_coordinates[1])

    # Evaluate check and checkmate
    if self.is_king_threatened?(enemy_color)
      puts 'CHECK'

      if self.is_checkmate?(enemy_color)
        puts 'CHECKMATE'
        # checkmate = true
        # Exit loop, remember to print board one last time
      end
    end

    # if self.is_king_threatened(enemy_color) returns false check for tie

    puts "\n"
    #self.print_board
    case player_color
    when 'white'
      player_color = 'black'
      enemy_color = 'white'
    when 'black'
      player_color = 'white'
      enemy_color = 'black'
    end
    end
  end


        

end

game = Game.new
game.play
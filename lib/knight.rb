require './lib/chess_pieces.rb'

class Knight < Piece
  attr_reader :sign, :legal_moves
  def initialize(color, row, column)
    super
    @type = 'knight'
    @sign = color == 'white' ? 'WK' : 'BK'
    @legal_moves = { # Have to be cleared on every new assessment
      up_left_short: [], # Up meaning lowering row values
      up_left_long: [], # Up meaning lowering row values / Left meaning lower column values
      up_right_short: [], # Increasing row values
      up_right_long: [], # Same row, lower column values
      down_left_short: [],
      down_left_long: [],
      down_right_short: [],
      down_right_long: []
    }
    # @legal_moves[:up] << [column, row] Run respective methods here
  end

  def find_legal_moves(board)
    current_row = @row
    current_col = @column

    # Going up
    until (current_row - 1) < 0 || (!board[current_row - 1].nil? and !board[current_row - 1][current_col].nil?)
      current_row -= 1
      self.legal_moves[:up] << [current_row, current_col]
    end
    unless (current_row - 1) < 0 #|| board[current_row - 1][current_col].nil?
      self.legal_moves[:up] << [current_row - 1, current_col] if board[current_row - 1][current_col].color != self.color
    end

    current_row = @row
    current_col = @column
    # Going down
    until (current_row + 1) > 7 || (!board[current_row + 1].nil? and !board[current_row + 1][current_col].nil?)
      current_row += 1
      self.legal_moves[:down] << [current_row, current_col]
    end
    unless (current_row + 1) > 7 #|| board[current_row + 1][current_col].nil?
      self.legal_moves[:down] << [current_row + 1, current_col] if !board[current_row + 1].nil? and board[current_row + 1][current_col].color != self.color
    end

    current_row = @row
    current_col = @column
    # Going left
    until (current_col - 1) < 0 || !board[current_row][current_col - 1].nil?
      current_col -= 1
      self.legal_moves[:left] << [current_row, current_col]
    end
    unless (current_col - 1) < 0
      self.legal_moves[:left] << [current_row, current_col - 1] if board[current_row][current_col - 1].color != self.color
    end
    
    current_row = @row
    current_col = @column
    # Going right
    until (current_col + 1) > 7 || !board[current_row][current_col + 1].nil?
      current_col += 1
      self.legal_moves[:right] << [current_row, current_col]
    end
    unless (current_col + 1) > 7
      self.legal_moves[:right] << [current_row, current_col + 1] if !board[current_row][current_col + 1].nil? and board[current_row][current_col + 1].color != self.color
    end
  end
end
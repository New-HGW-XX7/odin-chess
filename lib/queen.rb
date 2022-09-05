require './lib/chess_pieces.rb'

class Queen < Piece
  attr_reader :sign, :legal_moves
  def initialize(color, row, column)
    super
    @type = 'queen'
    @sign = color == 'white' ? 'WQ' : 'BQ'
    @legal_moves = { # Have to be cleared on every new assessment
      up: [], # Up meaning lowering row values
      down: [], # Increasing row values
      left: [], # Same row, lower column values
      right: [], # Same row, higher column values
      up_left: [], # Up meaning lowering row values / Left meaning lower column values
      up_right: [], 
      down_left: [], # Increasing row values
      down_right: []
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

    current_row = @row
    current_col = @column

    # Going up left
    until ((current_row - 1) < 0 or (current_col - 1) < 0) || (!board[current_row - 1].nil? and !board[current_row - 1][current_col - 1].nil?)
      current_row -= 1
      current_col -= 1
      self.legal_moves[:up_left] << [current_row, current_col]
    end
    unless (current_row - 1) < 0 || (current_col - 1) < 0
      self.legal_moves[:up_left] << [current_row - 1, current_col - 1] if board[current_row - 1][current_col - 1].color != self.color
    end

    current_row = @row
    current_col = @column

    # Going up right
    until ((current_row - 1) < 0 or (current_col + 1) > 7) || (!board[current_row - 1].nil? and !board[current_row - 1][current_col + 1].nil?)
      current_row -= 1
      current_col += 1
      self.legal_moves[:up_right] << [current_row, current_col]
    end
    unless (current_row - 1) < 0 || (current_col + 1) > 7
      self.legal_moves[:up_right] << [current_row - 1, current_col + 1] if board[current_row - 1][current_col + 1].color != self.color
    end

    current_row = @row
    current_col = @column

    
    # Going down left
    until ((current_row + 1) > 7 or (current_col - 1) < 0) || (!board[current_row + 1].nil? and !board[current_row + 1][current_col - 1].nil?)
      current_row += 1
      current_col -= 1
      self.legal_moves[:down_left] << [current_row, current_col]
    end
    unless (current_row + 1) > 7 || (current_col - 1) < 0
      self.legal_moves[:down_left] << [current_row + 1, current_col - 1] if board[current_row + 1][current_col - 1].color != self.color
    end

    current_row = @row
    current_col = @column

    # Going down right
    until ((current_row + 1) > 7 or (current_col + 1) > 7) || (!board[current_row + 1].nil? and !board[current_row + 1][current_col + 1].nil?)
      current_row += 1
      current_col += 1
      self.legal_moves[:down_right] << [current_row, current_col]
    end
    unless (current_row + 1) > 7 || (current_col + 1) > 7
      self.legal_moves[:down_right] << [current_row + 1, current_col + 1] if board[current_row + 1][current_col + 1].color != self.color
    end
  end
end
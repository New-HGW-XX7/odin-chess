require './lib/chess_pieces.rb'

class King < Piece
  attr_reader :sign, :legal_moves
  def initialize(color, row, column)
    super
    @type = 'king'
    @sign = color == 'white' ? 'WS' : 'BS' # S for Shah
    @legal_moves = { # Have to be cleared on every new assessment
      up: [], # Up meaning lowering row values
      down: [], # Increasing row values
      left: [], # Same row, lower column values
      right: [], # Same row, higher column values
      up_left: [], 
      up_right: [], 
      down_left: [], 
      down_right: []
    }
    # @legal_moves[:up] << [column, row] Run respective methods here
  end

  def find_legal_moves(board)
    current_row = @row
    current_col = @column

    # Going up
    unless (current_row - 1) < 0 #|| board[current_row - 1][current_col].nil?
      self.legal_moves[:up] << [current_row - 1, current_col] if board[current_row - 1][current_col].nil? or board[current_row - 1][current_col].color != self.color
    end

    # Going down
    unless (current_row + 1) > 7 #|| board[current_row + 1][current_col].nil?
      self.legal_moves[:down] << [current_row + 1, current_col] if board[current_row + 1][current_col].nil? or board[current_row + 1][current_col].color != self.color
    end

    # Going left
    unless (current_col - 1) < 0
      self.legal_moves[:left] << [current_row, current_col - 1] if board[current_row][current_col - 1].nil? or board[current_row][current_col - 1].color != self.color
    end

    # Going right
    unless (current_col + 1) > 7
      self.legal_moves[:right] << [current_row, current_col + 1] if board[current_row][current_col + 1].nil? or board[current_row][current_col + 1].color != self.color
    end

    # Going up left
    unless (current_row - 1) < 0 || (current_col - 1) < 0
      self.legal_moves[:up_left] << [current_row - 1, current_col - 1] if board[current_row - 1][current_col - 1].nil? or board[current_row - 1][current_col - 1].color != self.color
    end

    # Going up right
    unless (current_row - 1) < 0 || (current_col + 1) > 7
      self.legal_moves[:up_right] << [current_row - 1, current_col + 1] if board[current_row - 1][current_col + 1].nil? or board[current_row - 1][current_col + 1].color != self.color
    end

    # Going down left
    unless (current_row + 1) > 7 || (current_col - 1) < 0
      self.legal_moves[:down_left] << [current_row + 1, current_col - 1] if board[current_row + 1][current_col - 1].nil? or board[current_row + 1][current_col - 1].color != self.color
    end

    # Going down right
    unless (current_row + 1) > 7 || (current_col + 1) > 7
      self.legal_moves[:down_right] << [current_row + 1, current_col + 1] if board[current_row + 1][current_col + 1].nil? or board[current_row + 1][current_col + 1].color != self.color
    end
  end
end
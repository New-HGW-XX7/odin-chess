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

    # Going up left short
    unless (current_row - 1) < 0 || (current_col - 2) < 0
      self.legal_moves[:up_left_short] << [current_row - 1, current_col - 2] if board[current_row - 1][current_col - 2].nil? or board[current_row - 1][current_col - 2].color != self.color
    end

    # Going up left long
    unless (current_row - 2) < 0 || (current_col - 1) < 0
      self.legal_moves[:up_left_long] << [current_row - 2, current_col - 1] if board[current_row - 2][current_col - 1].nil? or board[current_row - 2][current_col - 1].color != self.color
    end

    # Going up right short
    unless (current_row - 1) < 0 || (current_col + 2) > 7
      self.legal_moves[:up_right_short] << [current_row - 1, current_col + 2] if board[current_row - 1][current_col + 2].nil? or board[current_row - 1][current_col + 2].color != self.color
    end

    # Going up right long
    unless (current_row - 2) < 0 || (current_col + 1) > 7
      self.legal_moves[:up_right_long] << [current_row - 2, current_col + 1] if board[current_row - 2][current_col + 1].nil? or board[current_row - 2][current_col + 1].color != self.color
    end

    # Going down left short
    unless (current_row + 1) > 7 || (current_col - 2) < 0
      self.legal_moves[:down_left_short] << [current_row + 1, current_col - 2] if board[current_row + 1][current_col - 2].nil? or board[current_row + 1][current_col - 2].color != self.color
    end

    # Going down left long
    unless (current_row + 2) > 7 || (current_col - 1) < 0
      self.legal_moves[:down_left_long] << [current_row + 2, current_col - 1] if board[current_row + 2][current_col - 1].nil? or board[current_row + 2][current_col - 1].color != self.color
    end

    # Going down right short
    unless (current_row + 1) > 7 || (current_col + 2) > 7
      self.legal_moves[:down_right_short] << [current_row + 1, current_col + 2] if board[current_row + 1][current_col + 2].nil? or board[current_row + 1][current_col + 2].color != self.color
    end

    # Going down right long
    unless (current_row + 2) > 7 || (current_col + 1) > 7
      self.legal_moves[:down_right_long] << [current_row + 2, current_col + 1] if board[current_row + 2][current_col + 1].nil? or board[current_row + 2][current_col + 1].color != self.color
    end
  end
end
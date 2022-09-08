require './lib/chess_pieces.rb'

class Pawn < Piece
  attr_reader :sign, :legal_moves
  def initialize(color, row, column)
    super
    @type = 'pawn'
    @sign = color == 'white' ? 'WP' : 'BP'
    @legal_moves = { # Have to be cleared on every new assessment
      forward: [], # Up meaning lowering row values
      strike: [], # Up meaning lowering row values / Left meaning lower column values
    }
    # @legal_moves[:up] << [column, row] Run respective methods here
  end

  def find_legal_moves(board)
    current_row = @row
    current_col = @column

    case self.sign
    when 'WP'
      unless (current_row - 1) < 0
        self.legal_moves[:forward] << [current_row - 1, current_col] if board[current_row - 1][current_col].nil?
        self.legal_moves[:strike] << [current_row - 1, current_col - 1] if !board[current_row - 1][current_col - 1].nil? and board[current_row - 1][current_col - 1].color != self.color
        self.legal_moves[:strike] << [current_row - 1, current_col + 1] if !board[current_row - 1][current_col + 1].nil? and board[current_row - 1][current_col + 1].color != self.color
      end
    
    when 'BP'
      unless (current_row + 1) > 7
        self.legal_moves[:forward] << [current_row + 1, current_col] if board[current_row + 1][current_col].nil?
        self.legal_moves[:strike] << [current_row + 1, current_col - 1] if !board[current_row + 1][current_col - 1].nil? and board[current_row + 1][current_col - 1].color != self.color
        self.legal_moves[:strike] << [current_row + 1, current_col + 1] if !board[current_row + 1][current_col + 1].nil? and board[current_row + 1][current_col + 1].color != self.color
      end
    end
  end
end
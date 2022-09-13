require './chess.rb'

describe Game do
  subject(:game) { described_class.new }
  describe '#initialize' do
    it 'creates a 2D-array with 8 rows' do # Array size will be changed later
      expect(game.board.size).to eq(8)
    end

    it 'creates a 2D-array with 8 columns' do
      expect(game.board.all? { |subarray| subarray.size == 8 }).to be true
    end

    it 'sets player color to white and enemy color to black' do
      expect(game.player_color).to eq('white')
      expect(game.enemy_color).to eq('black')
    end
  end
end
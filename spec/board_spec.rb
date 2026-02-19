#spec/board_spec.rb

require_relative 'spec_helper'
require_relative '../lib/connect_four/board'

RSpec.describe ConnectFour::Board do
  describe '#initialize' do
    it 'creates a 6x7 grid' do
      board = described_class.new
      expect(board.grid.length).to eq(6)
      expect(board.grid.first.length).to eq(7)
    end
  end
end
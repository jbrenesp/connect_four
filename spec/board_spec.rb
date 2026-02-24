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

  describe '#token_drop' do
    let(:board) { described_class.new }

    context 'when the column is empty' do
      it 'places a token in the bottom row of an empty column' do
        board.token_drop(0, :X)  # drop :X in column 0
        # bottom row = last element in grid
        expect(board.grid.last[0]).to eq(:X)
      end
    end

    context 'when the column already has a token' do
      it 'places the next token above the existing one' do
        board.token_drop(3, :X)
        board.token_drop(3, :O)

        expect(board.grid[5][3]).to eq(:X)
        expect(board.grid[4][3]).to eq(:O)
      end
    end
  end
end

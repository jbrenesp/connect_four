#spec/player_spec.rb

require_relative 'spec_helper'
require_relative '../lib/connect_four/player'
require_relative '../lib/connect_four/board'

RSpec.describe ConnectFour::Player do
  let(:player) {described_class.new("Jose", "X")}
  let(:board) {ConnectFour::Board.new}


  describe '#initialize' do
    it 'stores the player name and token' do
      player = described_class.new("Jose", "X")
      expect(player.name).to eq ("Jose")
      expect(player.token).to eq ("X")
    end
  end
  describe '#choose column' do 
    context 'when the player enters a valid column' do
      it 'returns the valid column as an integer' do
        allow(player).to receive(:gets).and_return("3")
        expect(player.choose_column(board)).to eq(3)
      end
    end
    
    context 'when the player inputs an invalid column number' do 
      it 'keeps asking until a valid column number is entered' do
        allow(player).to receive(:gets).and_return("7", "-1", "2")
        expect(player.choose_column(board)).to eq(2)
      end
    end

    context 'when the player selects a full column' do
      it 'keeps asking until a non-full column is entered' do
        6.times { board.token_drop(0, "X") }
        allow(player).to receive(:gets).and_return("0", "1")
        expect(player.choose_column(board)).to eq(1)
      end
    end
  end
end

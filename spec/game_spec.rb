#spec/game_spec.rb

require_relative 'spec_helper'
require_relative '../lib/connect_four/game'
require_relative '../lib/connect_four/board'
require_relative '../lib/connect_four/player'

RSpec.describe ConnectFour::Game do
  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'creates a board' do
      expect(game.board).to be_a(ConnectFour::Board)
    end

    it 'creates two players' do
      expect(game.players.length).to eq(2)
    end
  end

  describe '#current_player' do
    it 'returns player 1 first' do
      expect(game.current_player).to eq(game.players[0])
    end
  end

  describe '#switch_turn' do
    it 'switches the current player' do
      first_player = game.current_player
      game.switch_turn
      expect(game.current_player).not_to eq(first_player)
    end
  end
end
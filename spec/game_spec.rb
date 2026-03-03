# spec/game_spec.rb

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

  describe '#play_turn' do
    before do
      # Ensure board is empty for each test
      game.board.grid.each { |row| row.map! { nil } }
    end

    it 'drops the current player token in the chosen column' do
      allow(game.current_player).to receive(:choose_column).and_return(0)
      game.play_turn
      expect(game.board.grid.last[0]).to eq("X")
    end

    it 'switches the turn after playing' do
      allow(game.current_player).to receive(:choose_column).and_return(0)
      first_player = game.current_player
      game.play_turn
      game.switch_turn
      expect(game.current_player).not_to eq(first_player)
    end
  end

  describe '#winner?' do
    it 'returns true if the current player has four in a row' do
      4.times { |col| game.board.token_drop(col, "X") }
      expect(game.winner?).to be true
    end

    it 'returns false if there is no winner' do
      game.board.token_drop(0, "X")
      expect(game.winner?).to be false
    end
  end

  describe '#play_turn' do
    context 'when the current player wins' do
      it 'does not switch turn after winning' do
        3.times { |col| game.board.token_drop(col, "X") }
        allow(game.current_player).to receive(:choose_column).and_return(3)
        first_player = game.current_player
        game.play_turn
        expect(game.winner?).to be true
        expect(game.current_player).to eq(first_player)
      end
    end
  end

  describe '#play' do
    it 'detects a win' do
      allow(game.players[0]).to receive(:choose_column).and_return(0,1,2,3)
      allow(game.players[1]).to receive(:choose_column).and_return(0,1,2)
      expect { game.play }.to output(/Player 1 wins!/).to_stdout
    end
  end
  
  describe '#play detects a draw' do
    it 'prints "It\'s a tie!" when the board is full with no winner' do
      
      pattern = [
        ["X","O","X","O","X","O","X"],
        ["X","O","X","O","X","O","X"],
        ["O","X","O","X","O","X","O"],
        ["O","X","O","X","O","X","O"],
        ["O","X","O","X","O","X","O"],
        ["X","O","X","O","X","O","X"]
      ]
      
      pattern.transpose.each_with_index do |col_tokens, col_index|
        col_tokens.reverse.each do |token|
          game.board.token_drop(col_index, token)
        end
      end
      
      expect(game.draw?).to be true
      allow(game.current_player).to receive(:choose_column).and_return(0)
      expect { game.play }.to output(/It's a tie!/).to_stdout
    end
  end
end
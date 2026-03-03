#lib/game.rb

require_relative 'board'
require_relative 'player'

module ConnectFour
  class Game
    attr_reader :board, :players

    def initialize
      @board = Board.new
      @players = [
        Player.new("Player 1", "X"),
        Player.new("Player 2", "O")
      ]
      @current_player_index = 0
    end
    
    def current_player
      players[@current_player_index]
    end
    
    def switch_turn
      @current_player_index = 1 - @current_player_index
    end
    
    def play_turn
      column = current_player.choose_column(board)
      board.token_drop(column, current_player.token)
      switch_turn
    end
    
    def winner?
      board.four_in_a_row?(current_player.token)
    end
  end
end
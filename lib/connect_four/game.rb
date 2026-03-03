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
    end
    
    def winner?
      board.four_in_a_row?(current_player.token)
    end
    
    def draw?
      board_full = board.grid.flatten.none?(&:nil?)
      no_winner = !board.four_in_a_row?("X") && !board.four_in_a_row?("O")
      board_full && no_winner
    end
    
    def play
      loop do
        board.render  # show the current board
        puts "#{current_player.name}'s turn (#{current_player.token}):"
        play_turn  # this should ask the player for a column and drop the token
        
        if winner?
          board.render
          puts "#{current_player.name} wins!"
          break
        
        elsif draw?
          board.render
          puts "It's a tie!"
          break
        else
          switch_turn
        end
      end
    end
  end
end
# lib/connect_four/player.rb

module ConnectFour
  class Player
    attr_reader :name, :token

    def initialize(name, token)
      @name = name
      @token = token  
    end

    def choose_column(board)
      loop do 
        input = gets.chomp
        column = input.to_i

        next unless column.between?(0, 6)
        next if board.full_column?(column)

        return column
      end
    end 
  end
end
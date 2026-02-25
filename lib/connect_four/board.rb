
module ConnectFour 
  
  class Board
    attr_reader :grid
    ROWS = (0..5).to_a
    COLUMNS = (0..6).to_a
    
    def initialize 
      @grid = Array.new(ROWS.size) {Array.new(COLUMNS.size)}
    end

    def render
      grid.each do |row|
        puts row.map { |cell| cell.nil? ? "." : cell }.join(" ")
      end
      puts "0 1 2 3 4 5 6"
    end

    def token_drop(column, token)
      return false if full_column?(column)
      (ROWS.size - 1).downto(0) do |row|
        if grid[row][column].nil?
          grid[row][column] = token
          break
        end
      end
    end

    def full_column?(column)
      grid[0][column] != nil
    end

    def full_row?

    end

    def full_diagonal?

    end
  end
end

board = ConnectFour::Board.new
board.token_drop(0, "X")
board.token_drop(0, "O")
board.render



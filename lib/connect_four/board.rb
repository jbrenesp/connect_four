
module ConnectFour 
  
  class Board
    attr_reader :grid
    ROWS = (0..5).to_a
    COLUMNS = (0..6).to_a
    
    def initialize 
      @grid = Array.new(ROWS.size) {Array.new(COLUMNS.size)}
    end

    def token_drop(column, token)
      (ROWS.size - 1).downto(0) do |row|
        if grid[row][column].nil?
          grid[row][column] = token
          break
        end
      end
    end

    def full_column?

    end

    def full_row?

    end

    def full_diagonal?

    end
  end
end



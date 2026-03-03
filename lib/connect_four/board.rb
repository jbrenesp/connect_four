
module ConnectFour 
  
  class Board
    attr_reader :grid
    attr_accessor :grid
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

    def horizontal_win?(token)
      grid.each do |row|
        count = 0
        row.each do |cell|
          if cell == token
            count += 1
            return true if count == 4
          else
            count =0
          end
        end
      end
      false
    end

    def vertical_win?(token)
      (0..6).each do |column|
        count = 0
        (0..5).each do |row|
          if grid[row][column] == token
            count += 1
            return true if count == 4
          else
            count = 0
          end
        end
      end
      false
    end
    
    
           

    def diagonal_win?(token)
      (3..5).each do |row|
        (0..3).each do |col|
          if (0..3).all? { |i| grid[row - i][col + i] == token }
            return true
          end
        end
      end

      (0..2).each do |row|
        (0..3).each do |col|
          if (0..3).all? { |i| grid[row + i][col + i] == token }
            return true
          end
        end
      end
      false  
    end


    def four_in_a_row?(token)
      horizontal_win?(token) || vertical_win?(token) || diagonal_win?(token)
    end
  end
end

board = ConnectFour::Board.new
board.token_drop(0, "O")
board.token_drop(1, "O")
board.token_drop(2, "O")
board.token_drop(3, "O")



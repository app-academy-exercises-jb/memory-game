require_relative 'board.rb'

class MemoryGame
  def initialize(x,y)
    unless x.is_a?(Integer) && y.is_a?(Integer)
      raise "both arguments must be integers" 
    end


    @x, @y = x, y
    @x.freeze; @y.freeze

    @board = Board.new(x,y)

    
    self.play until over?
    p "you win!"
  end

  def play
    @board.print_board
    
    first_position = guess_position(get_position)
    second_position = guess_position(get_position)

    unless first_position.name == second_position.name
      first_position.hide unless first_position.revealed
      second_position.hide unless second_position.revealed
    else
      first_position.revealed = true
      second_position.revealed = true
    end
  end

  def guess_position(position)
    pos = @board.board[position[0].to_i][position[1].to_i]
    pos.reveal
    @board.print_board
    pos
  end

  def get_position
    p "please enter a position like this: 0,0"
    position = gets.chomp.split(",")

    unless position.all? { |i| i.to_i >= 0 } && 
        position[0].to_i <= @x && 
        position[1].to_i <= @y
      return position = get_position
    end

    return position
  end

  def over?
    @board.board.flatten.select { |ele| ele.name == " " }.length == 0
  end
end
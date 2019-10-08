require "pry"
class TicTacToe
  
  def initialize
    @board = Array.new(9, " ")
  end
  
    WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    
    [0,3,6],
    [1,4,7],
    [2,5,8],
    
    [0,4,8],
    [2,4,6]
    ]
    
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(string)
    input = string.to_i
    input - 1
  end
  
  def move(index, token="X")
    @board[index] = token
  end
  
  def position_taken?(index)
    if @board[index] == "X" || @board[index] == "O"
      true
    else
      false
    end
  end
  
  def valid_move?(position)
    if @board[position] == " "
      true
    else
      false
    end
  end
  
  def turn_count
    counter = 0
    @board.each do |position|
      if position == "X" || position == "O"
        counter += 1
      end
    end
    counter
  end
  
  def current_player
    if self.turn_count == 0 || self.turn_count.even?
      "X"
    else
      "O"
    end
  end
  
  def turn
    input = gets.strip
    x = input_to_index(input)
    y = valid_move?(x)
    z = self.current_player
    
    if x != -1 && x < 9 && y == true
      self.move(x, z)
      display_board
    else
      puts "Invalid move"
      self.turn
    end
  end
  
  def won?
    counter = 0
    compare_x = []
    compare_y = []
    winning_combo = nil
    
    @board.each_with_index do |x, y|
      compare_x.push(y) if x == "X"
      compare_y.push(y) if x == "O"
    end
    
    WIN_COMBINATIONS.each do |combination|
      combination.each do |number|
        if compare_x.include?(number)
          counter += 1
          if counter == 3
            winning_combo = combination
          end
        end
      end
      counter = 0
    end
      
    WIN_COMBINATIONS.each do |combination|
      combination.each do |number|
        if compare_y.include?(number)
          counter += 1
          if counter == 3
            winning_combo = combination
          end
        end
      end
      counter = 0
    end
        
    winning_combo
  end
  
  def full?
    if @board.include?(" ")
      false
    else
      true
    end
  end
  
  def draw?
    if self.full? && !(self.won?)
      true
    else
      false
    end
  end
  
  def over?
    if self.draw? || self.won?
      true
    else
      false
    end
  end
  
  def winner
    winner = nil
    counter_x = 0
    counter_y = 0
    
    if self.won? != nil
      winning_combo = self.won?
    
      @board.each_with_index do |player, index|
        if player == "X" && winning_combo.include?(index)
          counter_x += 1
        elsif player == "O" && winning_combo.include?(index)
          counter_y += 1
        end
      end
    
      if counter_x == 3
       winner = "X"
      elsif counter_y == 3
       winner = "O"
      else
       winner
      end
      
    end
  end
  
  
def play
   until self.over?
      self.turn
    end
    
    if self.won?
      puts "Congratulations #{self.winner}!"
    elsif self.draw?
      puts "Cat's Game!"
    end
  end

  

  
  
  
  
end
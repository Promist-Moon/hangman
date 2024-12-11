require 'yaml'

class Game
  def initialize
    @computer = Computer.new
    @computer.generate_word
    @word = @computer.word
    @board = Array.new(@word.length, 0)
    @solved = false
    @guesses_left = 5  
  end

  def show_hidden_word
    puts "Computer's secret word: #{@word}"
  end

  def display_board
    puts @board.map { |char| char == 0 ? '__ ' : char}.join(' ')
  end

  def win?
    @solved || @board.all? { |tile| tile != 0 }
  end
  
  def solved=(value)
    @solved = value
  end

  attr_accessor :board, :guesses_left
  attr_reader :word


  def save_game
    File.open("hangman_game.yaml", "w") { |file| file.write(YAML.dump(self)) }
    puts "Game saved successfully!"
    exit
  end

  def self.load_game
    if File.exist?("hangman_game.yaml")
      serialized_game = File.read("hangman_game.yaml")
      game = YAML.safe_load(serialized_game, permitted_classes: [Game, Computer])
      puts "Game loaded successfully!"
      return game
    else
      puts "No saved game found."
      return nil
    end
  end

  def delete_game
    if File.exist?("hangman_game.yaml")
      File.delete("hangman_game.yaml")
    end
  end
end
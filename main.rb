require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/computer'

puts "Welcome to HANGMAN!"
puts "You have 5 guesses to input a letter and guess the word."
puts "If you feel like you know the answer, type SOLVE"
puts "This game is also saveable! Type SAVE to save the game for later"
puts "No swears!"

if File.exist?('hangman_game.yaml')
  puts "Do you want to load the previous game? (y/n)"
  answer = gets.chomp.downcase
  if answer == 'y'
    game = Game.load_game
    puts "Game loaded!"
  else
    game = Game.new
  end
else
  game = Game.new
end

player = Player.new(game)

while game.guesses_left > 0
  puts "You have #{game.guesses_left} guesses left"
  game.display_board

  if player.guess_letter(game.board)
    game.instance_variable_set(:@guesses_left, game.guesses_left - 1)  # Decrease guess count directly on the game object
  end

  if game.win?
    puts "----------------------------"
    puts "Congratulations! You've guessed the word"
    game.show_hidden_word
    puts "----------------------------"
    game.delete_game
    exit
  elsif game.guesses_left == 0
    puts "----------------------------"
    puts "Sorry, you have ran out of guesses! The code was: "
    game.show_hidden_word
    puts "----------------------------"
    game.delete_game
    exit
  end
end
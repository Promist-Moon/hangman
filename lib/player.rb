class Player
  def initialize(game)
    @game = game
  end

  def guess_letter(so_far)
    print "Guess a letter: "
    $stdout.flush
    letter = gets.chomp.downcase
    if letter == "solve"
      return guess_word
    elsif letter == "save"
      return @game.save_game()
    elsif !letter.match?(/[a-zA-Z]/) 
      puts "Not a letter - try again!"
      false
    elsif letter.length != 1
      puts "Please input only one letter!"
      false
    elsif so_far.include?(letter)
      puts "You have guessed this letter before! Try again."
      false
    elsif @game.word.include?(letter)
      puts "You're correct! #{letter} is in the word!"
      indices = find_position(@game.word, letter)
      indices.each do |i|
        so_far[i] = letter
      end
      false
    else 
      puts "Incorrect!"
      true
    end
  end

  def find_position(actual, letter)
    return actual.chars.each_with_index.select { |el, idx| el == letter }.map(&:last)
  end

  def guess_word
    puts "So you know the answer! Input your guess here: "
    $stdout.flush
    guess = gets.chomp.downcase
    if guess == @game.word
      puts "Congratulations! You've guessed the word!"
      @game.solved = true
      return true 
    else 
      puts "Incorrect! The word is not '#{guess}'."
      return false
    end
  end
end
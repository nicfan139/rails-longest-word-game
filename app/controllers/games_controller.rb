require 'net/http'

class GamesController < ApplicationController
  def new
  end

  def score
    @word = params[:longest_word]
    @grid = params[:grid]
    @result = result(@word, @grid)
  end

  # validates whether the word is in the grid of letters
  def grid_valid(attempt, grid)
    attempt_array = attempt.split("")
    attempt_array.each do |letter|
      if grid.include? letter.upcase
        grid.delete(letter.upcase)
      else
        return false
      end
    end
    return true
  end

  # validates whether the attempt is an actual word
  def word_valid(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    validity = JSON.parse(response)
    return validity["found"]
  end

  # creates the result based on the attempt for longest_word
  def result(attempt, grid)
    if attempt == ""
      return "Sorry, you need to enter an answer!"
    elsif word_valid(attempt) == false
      return "Sorry, #{attempt} is not an English word"
    elsif grid_valid(attempt, grid) == false
      return "Sorry, #{attempt} is not in the grid"
    else
      return "Well done!"
    end
  end
end

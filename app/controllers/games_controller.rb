require 'json'
require 'open-uri'

class GamesController < ApplicationController
URL = "https://wagon-dictionary.herokuapp.com/"
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    guesses = params[:word].downcase
    # guesses_ary = guesses.split('')
    grid = params[:letters]
    words = grid.split('');
    if in_grid?(words, guesses)
      word_url = URL + guesses
      found = JSON.parse(open(word_url).read)["found"]
      if found == true
        @result = "#{guesses.upcase} is a valid English word!"
      else
        @result = "Sorry but #{guesses.upcase} does not seem to be a valid English word.."
      end
    else
      @result = "Sorry but #{guesses.upcase} can't be built out of #{grid.upcase}! "
    end
  end

  def in_grid?(grid, attempt)
    in_grid = true
    attempt_array = attempt.split("")
    attempt_array.each do |letter|
      return in_grid = false if attempt_array.count("#{letter}") > grid.count("#{letter}")
    end
  end
end

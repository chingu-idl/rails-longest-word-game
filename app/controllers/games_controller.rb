require "open-uri"

class GamesController < ApplicationController

  def new
  array = ('a'..'z').to_a
  @letters = array.sample(10)
  end

  def score
  @guess = params[:guess]
  @letters = params[:letters].split
  @include = @guess.chars.all?{|letter| @letters.include?(letter)}
    if @include 
      if check_word?(@guess)
        @score = "CONGRATULATIONS! #{@guess} is a valid English word"
      else
        @score = "Sorry but #{@guess} does not seem to be a valid English word"
      end
    else
      @score = "Sorry but #{@guess} can't be built out of #{@letters}"
    end
  end

 def check_word?(word)
  response = URI.open"https://wagon-dictionary.herokuapp.com/#{word}"
  json = JSON.parse(response.read)
  json["found"]
 end

end

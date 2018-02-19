require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    vowels = %w(A E I O U)
    play_vowels = vowels.sample(4)
    consonants = Array.new(('A'..'Z').to_a - vowels).sample(6)
    @letters = (consonants + play_vowels).shuffle
  end

  def score
    letters = params[:letters].split
    answer = params[:answer].upcase.chars
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    dictionary_serialized = open(url).read
    dictionary = JSON.parse(dictionary_serialized)
    if answer.all? { |letter| answer.count(letter) <= letters.count(letter) }
      if dictionary["found"]
        @score = params[:answer].length
        session[:total_score] += @score
        @total_score = session[:total_score]
        @result = "Congratulations! #{params[:answer].upcase} is a valid English word! And your score is #{@total_score}."
      else
        @result = "Sorry but #{params[:answer].upcase} does not seem to be a valid English word"
      end
    else
      @result =  "Sorry, #{params[:answer].upcase} can't be built out of #{params[:letters]}"
    end
  end

end

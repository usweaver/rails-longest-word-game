require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times {@letters << ("A".."Z").to_a.sample()}
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    if !included?(@word, @letters)
      @answer = "Sorry but <b>#{@word}</b> can't be built out of #{@letters}.".html_safe
    elsif !check_dictionary(@word)
      @answer = "Sorry but <b>#{@word}</b> does not seem to be a valid English word...".html_safe
    else
      @answer = "Congratulations! <b>#{@word}</b> is a valid English word! You won #{@word.length} points!".html_safe
      if session[:score].nil?
        session[:score] = @word.length
      else
        session[:score] += @word.length
      end
    end
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter.upcase) <= letters.count(letter.upcase) }
  end

  def check_dictionary(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response_serialized = URI.parse(url).read
    JSON.parse(response_serialized)["found"]
  end

end

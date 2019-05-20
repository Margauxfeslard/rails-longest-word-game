require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    15.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def score
    @grid = params['grid']
    answer = answer_user
    counter = answer['word'].upcase.split('')
    @result = { score: 0, message: '' }
    if !answer['found'] then @result[:message] = 'Not an english word'
    elsif counter.all? { |letter| counter.count(letter) <= @grid.count(letter) }
      @result[:score] = answer['word'].length
      @result[:message] = 'Well Done!'
    else @result[:message] = ' Not in the grid'
    end
  end

  private

  def answer_user
    @answer = params['answer']
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    user_answer = open(url).read
    JSON.parse(user_answer)
  end
end

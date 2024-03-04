require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = Array('a'..'z')
    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    @letters = params[:letters].split('')
    @word = params[:word]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)['found']

    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) } && word
      @result = 'Gagné !'
    else
      @result = "C'est pas bon du tout..."
    end
  end
end

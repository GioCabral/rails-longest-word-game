require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
    @new_aphabet = alphabet.sample(10)
    return @new_aphabet
  end

  def score
    @word = params[:word]
    @new_aphabet = params[:new_aphabet]
    if include_all?(@new_aphabet, @word)
      @english_word = english_word?(@word)
    else
      @english_word = "ta roubando?"
    end
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    ret = URI.open(url)
    body = JSON.parse(ret.read)
    @english_word = body['found']
  end

  def include_all?(alphabet, word)
    new_word = word.split('')
    validate = new_word.map do |letter|
      alphabet.include?(letter)
    end
    validate.include?(false) ? false : true
  end
end

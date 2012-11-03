require 'json'
require "#{File.dirname(__FILE__)}/../engine"


class Sentimentalizer

  def initialize
    @analyser = Analyser.new
    @analyser.train_positive "#{File.dirname(__FILE__)}/../data/positive"
    @analyser.train_negative "#{File.dirname(__FILE__)}/../data/negative"
    puts @analyser.inspect
  end

  def analyze(sentence)
    @analyser.analyse(sentence).to_json
  end

end
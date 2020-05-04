require_relative 'Emoji_unicode.rb'

class Emoji
  # game emoji_codes
  attr_reader :codes
  
  def initialize(codes)
    @codes = codes
  end
end

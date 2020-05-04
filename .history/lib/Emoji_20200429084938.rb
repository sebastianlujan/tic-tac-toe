require_relative 'Emoji_unicode.rb'

class Emoji
  # game emoji_codes
  attr_accessor :codes

  def initialize(codes)
    @codes = codes
  end
end

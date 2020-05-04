require_relative 'Emoji_unicode.rb'

class Emoji
  # game emoji_codes
  attr_accessor :codes, :vali

  def initialize(codes)
    @codes = codes
    value = ''
  end
end

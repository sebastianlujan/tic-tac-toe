class Emoji
  attr_accessor :codes
  def initialize
    @codes = {
      box: 0x20e3,
      emoji_style: 0xfe0f,
      x: 0x274c,
      o: 0x1f535
    }
  end

  # TODO: create a gem: iremoji.gem
  # the compose variants are a supperset of the old standard
  # https://www.unicode.org/charts/PDF/U1F600.pdf
  # the new standard: non available for older terminals
  # https://unicode.org/Public/emoji/13.0/emoji-sequences.txt
  # for a reference with 16 glyphes or 15 glyphes variation
  # https://en.wikipedia.org/wiki/Variation_Selectors_(Unicode_block)
  # Simple encoding for emojis without variations  is Variations = 0
  # Emoji variation sequences that contains VS16 (U+FE0F),represent :colors
  # Emoji variation sequences that contains VS15 (U+FE0E),represent monocrome !:colors
  # emoji_codes = { box: 0x20e3, emoji_style: 0xfe0f, x: 0x247c, o: 0x1f535 }

  # Explanation of a compose variants: ie: [9]
  # ordinal: " \u{0039} -> base"
  # emoji: \u{fe0f} -> emoji_variant"
  # box: \u{20e3} -> variant"

  def to_emoji(*args)
    if args.size == 1
      [args[0].to_i].pack('U')
    else
      [args[0], args[1], args[2]].pack('U*') unless args[0].nil?
    end
  end

  def check_simple_emoji(base, variant, item)
    unless base.nil? && base.to_i < 49 && base.to_i > 57
      item = " #{to_emoji(base)} " if variant.nil?
    end
    item
  end
end
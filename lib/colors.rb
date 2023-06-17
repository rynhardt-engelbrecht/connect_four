# frozen_string_literal: true

# module to stylize visual output
module Colors
  def token_color(number)
    {
      1 => "\e[91m\u25CF \e[0m",
      2 => "\e[92m\u25CF \e[0m",
      3 => "\e[93m\u25CF \e[0m",
      4 => "\e[94m\u25CF \e[0m",
      5 => "\e[95m\u25CF \e[0m",
      6 => "\e[96m\u25CF \e[0m"
    }[number]
  end
end

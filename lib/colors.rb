# frozen_string_literal: true

# module to stylize visual output
module Colors
  def token_color(number)
    {
      0 => "\e[37m\u25CB\e[0m",
      1 => "\e[91m\u25CF\e[0m",
      2 => "\e[92m\u25CF\e[0m",
      3 => "\e[94m\u25CF\e[0m",
      4 => "\e[95m\u25CF\e[0m",
      5 => "\e[96m\u25CF\e[0m",
      6 => "\e[97m\u25CF\e[0m"
    }[number]
  end

  def colorize(text, color)
    {
      'red' => "\e[91m#{text}\e[0m",
      'green' => "\e[92m#{text}\e[0m",
      'yellow' => "\e[93m#{text}\e[0m",
      'blue' => "\e[94m#{text}\e[0m"
    }[color]
  end
end

module MortgageCalc
  module Formatter
    def percentage(num)
      num = (num * 100).round(2)
      "#{num}%"
    end

    def number_to_currency(num)
      "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
    end
  end
end


require_relative 'formatter'

module MortgageCalc
  class Loan
    include MortgageCalc::Formatter

    attr_reader :loan_amount

    def initialize(loan_amount, base_rate, increment, fortnightly)
      @loan_amount = loan_amount.to_f
      @base_rate = base_rate.to_f / 100
      @increment = increment.to_f / 100
      @fortnightly = fortnightly
    end

    def base_rate
      percentage(@base_rate)
    end

    def increment
      percentage(@increment)
    end

    def interest
      rates.map do |rate|
        OpenStruct.new(rate: percentage(rate),
                       annual: annual_interest(rate).round(2),
                       fortnight: fortnightly_interest(rate).round(2),
                       diff: fortnightly_diff(rate).round(2))
      end
    end

    private

    def fortnightly_diff(rate)
      @fortnightly - fortnightly_interest(rate)
    end

    def rates
      (1..8).map do |n|
        @base_rate + (@increment * n)
      end.unshift(@base_rate)
    end

    def annual_interest(rate)
      (@loan_amount * rate).round(2)
    end

    def fortnightly_interest(rate)
      (annual_interest(rate) / 26).round(2)
    end
  end
end

module MortgageCalc
  class Income
    attr_reader :income, :expense

    def initialize(income, expense)
      @income = income.to_f
      @expense = expense.to_f
    end

    def annual_income
      (income - expense).round(2)
    end

    def fortnightly_income
      (annual_income / 26).round(2)
    end
  end
end

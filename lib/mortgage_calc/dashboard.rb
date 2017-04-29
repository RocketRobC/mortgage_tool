module MortgageCalc
  class Dashboard
    attr_accessor :loan_data, :income_data

    def initialize(opts = {})
      @income_data = new_income(opts[:income], opts[:expense])
      @loan_data = new_loan(opts[:amount],
                            opts[:base_rate],
                            opts[:increment])
    end

    def self.loan_methods(*names)
      names.each do |name|
        define_method(name) do
          loan_data.send(name)
        end
      end
    end
    loan_methods(:loan_amount, :base_rate, :increment, :interest)

    def self.income_methods(*names)
      names.each do |name|
        define_method(name) do
          income_data.send(name)
        end
      end
    end
    income_methods(:fortnightly_income, :annual_income, :income, :expense)

    private

    def new_income(income, expense)
      MortgageCalc::Income.new(income, expense)
    end

    def new_loan(amount, base_rate, increment)
      MortgageCalc::Loan.new(amount, base_rate, increment, fortnightly_income)
    end
  end
end

class CashRegister

  Cash_Dictionary =  [["ONEHUNDRED ", 100],
                      ["TWENTY ", 20],
                      ["TEN ", 10],
                      ["FIVE ", 5],
                      ["ONE ", 1],
                      ["QUARTER ", 0.25],
                      ["DIME ", 0.10],
                      ["NICKEL ", 0.05],
                      ["PENNY ", 0.01 ]].freeze

  def self.checkCashRegister(price, cash, cashInDrawer)
    changeFromPurchase = cash - price
    return GetChange(changeFromPurchase) if ChangeNeeded(price, cash, cashInDrawer) < TotalCashRegisterSum(price, cash, cashInDrawer)
    return 'Closed' if ChangeNeeded(price, cash, cashInDrawer) == TotalCashRegisterSum(price, cash, cashInDrawer)
    return 'Insuficient Funds' if ChangeNeeded(price, cash, cashInDrawer) > TotalCashRegisterSum(price, cash, cashInDrawer)
  end


  private

  def self.TotalCashRegisterSum(price, cash, cashInDrawer)
    cashInDrawer.inject(0){|sum,(name, number)| sum + number}.round(2)
  end

  def self.ChangeNeeded(itemPrice,cashOnHand,cashInDrawer)
    (cashOnHand - itemPrice).round(2)
  end

  # def self.GetChange(cal)
  #   val = 0
  #   Cash_Dictionary.each_with_object({}) do |(name, number), output|
  #       (cal / number).to_i.times do
  #       (output[name] ||= 0)
  #       (output[name] += number)
  #       (cal -= number)
  #     end
  #   end.to_a
  # end
  #
  # def self.GetChange(cal)
  #   return_amount = []
  #   total = 0
  #   Cash_Dictionary.each do |k, v|
  #     while cal >= v
  #       return_amount <<  v * (cal / v)
  #       cal -= v * (cal / v)
  #     end
  #
  #   end
  #   return_amount
  # end

  # def self.GetChange(cal)
  #   return_amount = []
  #   total = 0
  #   Cash_Dictionary.sort.reverse.each do |k, v|
  #     while cal >= v
  #       amount = v * (cal / v)
  #       return_amount << amount
  #       cal -= v * (cal / v)
  #     end
  #   end
  #   return_amount.to_a
  # end



  def self.GetChange(calculate)
    output = {}
    cal = calculate
    Cash_Dictionary.map do |nameOfNumber, number|
       while cal >= number
        (output[nameOfNumber] ||= 0)
        (output[nameOfNumber] += number)
        (cal -= number)
      end
    end
    output.to_a
  end


end

class CashRegister

  Cash_Dictionary =  [["OneHundred ", 100.00],
                      ["Twenty ", 20.00],
                      ["Ten ", 10.00],
                      ["Five ", 5.00],
                      ["One ", 1.00],
                      ["Quarter ", 0.25],
                      ["Dime ", 0.10],
                      ["Nickel ", 0.05],
                      ["Penny ", 0.01 ]].freeze

  def self.checkCashRegister(price, cash, cashInDrawer)
    changeFromPurchase = cash - price
    return GetChange(changeFromPurchase) if ChangeNeeded(price, cash, cashInDrawer) < TotalCashRegisterSum(price, cash, cashInDrawer)
    return 'Closed' if ChangeNeeded(price, cash, cashInDrawer) == TotalCashRegisterSum(price, cash, cashInDrawer)
    return 'Insuficient Funds' if ChangeNeeded(price, cash, cashInDrawer) > TotalCashRegisterSum(price, cash, cashInDrawer)
  end


  private

  def self.CountCashRegister(price, cash, cashInDrawer)
    @customersChange = ChangeNeeded(price, cash, cashInDrawer)
    @changeAvailable = TotalCashRegisterSum(price, cash, cashInDrawer)
  end

  def self.TotalCashRegisterSum(price, cash, cashInDrawer)
    cashInDrawer.inject(0){|sum,num| sum + num[1]}.round(2)
  end

  def self.ChangeNeeded(itemPrice,cashOnHand,cashInDrawer)
    (cashOnHand - itemPrice).round(2)
  end

  def self.GetChange(calculate)
    output = []
    cal = calculate
    Cash_Dictionary.each do |nameOfNumber,number|
      while (cal >= number)
        (output <<  number) && (output << nameOfNumber)
        (cal -= number)
      end
    end
    output
  end

end

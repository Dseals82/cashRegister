class CashRegister

  Cash_Dictionary =  [["ONEHUNDRED ", 100.00],
                      ["TWENTY ", 20.00],
                      ["TEN ", 10.00],
                      ["FIVE ", 5.00],
                      ["ONE ", 1.00],
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

  def self.GetChange(cal)
   output = {}
   Cash_Dictionary.each do |nameOfNumber,number|
     while (cal >= number)
       output[nameOfNumber] ||= 0
       (output[nameOfNumber] += number)
       (cal -= number)
     end
   end
   output.to_a
 end

end

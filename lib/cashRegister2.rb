# require 'bigdecimal'
#
# class CashRegister
#
#   sum = BigDecimal.new('0')
#
#   Cash_Dictionary =  [["ONEHUNDRED ", 100],
#                       ["TWENTY ", 20],
#                       ["TEN ", 10],
#                       ["FIVE ", 5],
#                       ["ONE ", 1],
#                       ["QUARTER ", 0.25],
#                       ["DIME ", 0.10],
#                       ["NICKEL ", 0.05],
#                       ["PENNY ", 0.01 ]].freeze
#
#   def self.checkCashRegister(price, cash, cashInDrawer)
#     changeFromPurchase = cash - price
#     return GetChange(changeFromPurchase) if ChangeNeeded(price, cash, cashInDrawer) < TotalCashRegisterSum(price, cash, cashInDrawer)
#     return 'Closed' if ChangeNeeded(price, cash, cashInDrawer) == TotalCashRegisterSum(price, cash, cashInDrawer)
#     return 'Insuficient Funds' if ChangeNeeded(price, cash, cashInDrawer) > TotalCashRegisterSum(price, cash, cashInDrawer)
#   end
#
#
#   private
#
#   def self.TotalCashRegisterSum(price, cash, cashInDrawer)
#     cashInDrawer.reduce(0){|sum,(name, number)| sum + number}.round(2)
#   end
#
#   def self.ChangeNeeded(itemPrice,cashOnHand,cashInDrawer)
#     (cashOnHand - itemPrice).round(2)
#   end
#
#   def self.GetChange(calculate)
#     output = {}
#     change = calculate
#     Cash_Dictionary.map do |nameOfNumber, number|
#
#        while change >= number
#         (output[nameOfNumber] ||= 0)
#         (output[nameOfNumber] += number)
#         (change -= number)
#       end
#     end
#     output.to_a
#   end
#
#
# end

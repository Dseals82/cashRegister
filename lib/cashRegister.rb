
class CashRegister
  CASH_DICTIONARY = {"ONE HUNDRED" => 100,
                     "TWENTY" => 20,
                     "TEN" => 10,
                     "FIVE" => 5,
                     "ONE" => 1,
                     "QUARTER" => 0.25,
                     "DIME" => 0.10,
                     "NICKEL" => 0.05,
                     "PENNY" => 0.01}.freeze

  def self.check_cash_register(price, cash, cashInDrawer)
    change_from_purchase = (cash - price).round(2)
    total_up = cashInDrawer.reduce(0) { |sum, (name, number)| sum + number }.round(2)
    return "Closed" if change_from_purchase == total_up
    cid = cashInDrawer.reverse
    correct_output = {}
    self.get_change(change_from_purchase)

    cid.each do |currency|
      currency_type = currency[0]
      currency_value = currency[1]
      compared_value_type = CASH_DICTIONARY[currency_type]
      accumulated_value = 0
      change_from_purchase = correct_amount_given(accumulated_value, change_from_purchase,
        compared_value_type, currency_type, currency_value, correct_output)
    end

    return correct_output.to_a if change_from_purchase == 0
    'Insufficient Funds'
  end

  private

  def self.correct_amount_given(accumulated_value, change_from_purchase, compared_value_type, currency_type, currency_value, output)
    until !(change_from_purchase >= compared_value_type && accumulated_value + compared_value_type <= currency_value)
      (output[currency_type] ||= 0)
      (output[currency_type] += compared_value_type)
      (change_from_purchase -= compared_value_type)
      (change_from_purchase = change_from_purchase.round(2))
      (accumulated_value += compared_value_type)
    end
    change_from_purchase
  end

  def self.get_change(change_amount)
    correctOutput = {}
    change = change_amount
    CASH_DICTIONARY.map do |currencyType, currencyValue|
      while change >= currencyValue
        (correctOutput[currencyType] ||= 0)
        (correctOutput[currencyType] += currencyValue)
        (change -= currencyValue)
        (change = change.round(2))
      end
    end
    correctOutput.to_a
  end
end


class CashRegister
  CASH_DICTIONARY = {
                     "ONE HUNDRED" => 100,
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
    cid = cashInDrawer.reverse
    return "Closed" if change_from_purchase == total_up
    

    output = {}
    self.get_change(change_from_purchase)

    cid.each do |pair|
      name_of_number = pair[0]
      number = pair[1]
      individual_value = CASH_DICTIONARY[name_of_number]
      accumulated = 0

      while (change_from_purchase >= individual_value && accumulated + individual_value <= number)
        (output[name_of_number] ||= 0)
        (output[name_of_number] += individual_value)
        (change_from_purchase -= individual_value)
        (change_from_purchase = change_from_purchase.round(2))
        accumulated += individual_value
      end
    end

    return output.to_a if change_from_purchase == 0
    'Insuficient Funds'
  end

  private

  def self.total_cash_register_sum(price, cash, cashInDrawer)
    cashInDrawer.reduce(0) { |sum, (name, number)| sum + number }.round(2)
  end

  def self.change_needed(itemPrice, cashOnHand, cashInDrawer)
    (cashOnHand - itemPrice).round(2)
  end

  def self.get_change(calculate)
    output = {}
    change = calculate
    CASH_DICTIONARY.map do |nameOfNumber, number|
      while change >= number
        (output[nameOfNumber] ||= 0)
        (output[nameOfNumber] += number)
        (change -= number)
        change = change.round(2)
      end
    end
    output.to_a
  end
end

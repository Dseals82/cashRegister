

class CashRegister



  CASH_DICTIONARY =   {"ONEHUNDRED "=> 100.00,
                       "TWENTY "=> 20.00,
                       "TEN "=> 10.00,
                       "FIVE "=> 5.00,
                       "ONE "=> 1.00,
                       "QUARTER "=> 0.25,
                       "DIME "=> 0.10,
                       "NICKEL "=> 0.05,
                       "PENNY "=> 0.01 }.freeze

  def self.check_cash_register(price, cash, cashInDrawer)
    change_from_purchase = (cash - price).round(2)
    total_up = cashInDrawer.reduce(0){|sum,(name, number)| sum + number}.round(2)
    cid = cashInDrawer.reverse
    return 'Closed' if change_from_purchase == total_up
    return 'Insuficient Funds' if change_from_purchase > total_up


    output = {}

    cid.each do |nameOfNumber, number|

        while (change_from_purchase >= number) && number.include?(FALSE)

          (output[nameOfNumber] ||= 0)
          (output[nameOfNumber] += number)
          (change_from_purchase -= number)
          (change_from_purchase = change_from_purchase.round(2))


        end


     end





    return output.to_a if change_from_purchase < total_up




  end


  private

  def self.total_cash_register_sum(price, cash, cashInDrawer)
    cashInDrawer.reduce(0){|sum,(name, number)| sum + number}.round(2)
  end

  def self.change_needed(itemPrice,cashOnHand,cashInDrawer)
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

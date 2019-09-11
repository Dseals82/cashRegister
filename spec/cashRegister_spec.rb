require_relative '../lib/cash_register'

RSpec.describe 'checkCashRegister' do
  context 'returns appropriate status' do
    it "should return Insufficient Funds if change due is greater than change available" do
      expect(CashRegister.check_cash_register(19.50, 20.00, [["PENNY", 0.01], ["NICKEL", 0], ["DIME", 0], ["QUARTER", 0], ["ONE", 0], ["FIVE", 0], ["TEN", 0], ["TWENTY", 0], ["ONE HUNDRED", 0]])).to eq('Insufficient Funds')
    end
    it "should return Insufficient Funds if available bills are too large to give change, ie. change is 0.50 but there is only One Hundred dollar bill in cash register" do
      expect(CashRegister.check_cash_register(19.50, 20.00, [["PENNY", 0], ["NICKEL", 0], ["DIME", 0], ["QUARTER", 0], ["ONE", 0], ["FIVE", 0], ["TEN", 0], ["TWENTY", 0], ["ONE HUNDRED", 100.00]])).to eq('Insufficient Funds')
    end
    it "should return Closed if change due is equal to change available" do
      expect(CashRegister.check_cash_register(19.50, 19.51, [["PENNY", 0.01], ["NICKEL", 0], ["DIME", 0], ["QUARTER", 0], ["ONE", 0], ["FIVE", 0], ["TEN", 0], ["TWENTY", 0], ["ONE HUNDRED", 0]])).to eq('Closed')
    end
    it "should return amount of 0.50 cents" do
      expect(CashRegister.check_cash_register(19.50, 20.00, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.10], ["QUARTER", 4.25], ["ONE", 90.00], ["FIVE", 55.00], ["TEN", 20.00], ["TWENTY", 60.00], ["ONE HUNDRED", 100.00]])).to eq( [["QUARTER", 0.5]] )
    end
    it "should return amount of $29.50" do
      expect(CashRegister.check_cash_register(20.50, 50.00, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.10], ["QUARTER", 4.25], ["ONE", 90.00], ["FIVE", 55.00], ["TEN", 20.00], ["TWENTY", 60.00], ["ONE HUNDRED", 100.00]])).to eq( [["TWENTY", 20], ["FIVE", 5], ["ONE", 4], ["QUARTER", 0.5]] )
    end
    it "should return correct change when paying one hundred for three dollars and twenty six cents, amount should be $96.74" do
      expect(CashRegister.check_cash_register(3.26, 100.00, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.10], ["QUARTER", 4.25], ["ONE", 90.00], ["FIVE", 55.00], ["TEN", 20.00], ["TWENTY", 60.00], ["ONE HUNDRED", 100.00]])).to eq([["TWENTY", 60], ["TEN", 20], ["FIVE", 15], ["ONE", 1], ["QUARTER", 0.5], ["DIME", 0.2], ["PENNY", 0.04]])
    end
  end
end
describe 'getChange' do
  context 'converts change to appropriate output based off of max amount that can be taken from cash register' do
    it 'should return correct output' do
      expect(CashRegister.get_change(100.25)).to eq( [["ONE HUNDRED", 100], ["QUARTER", 0.25]] )
    end
    it 'should return correct output' do
      expect(CashRegister.get_change(200.53)).to eq( [["ONE HUNDRED", 200], ["QUARTER", 0.5], ["PENNY", 0.03]] )
    end
    it 'should return correct output' do
      expect(CashRegister.get_change(96.74)).to eq( [["TWENTY", 80], ["TEN", 10], ["FIVE", 5], ["ONE", 1.0], ["QUARTER", 0.5], ["DIME", 0.2], ["PENNY", 0.04]] )
    end
  end
end

require_relative '../lib/cashRegister'

RSpec.describe 'CountCashRegister' do
  context 'adds up all of the change in cash register' do
    it 'should return 335.41' do
      expect(CashRegister.CountCashRegister(19.50, 20.00, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.10], ["QUARTER", 4.25], ["ONE", 90.00], ["FIVE", 55.00], ["TEN", 20.00], ["TWENTY", 60.00], ["ONE HUNDRED", 100.00]])).to eq(335.41)
    end
    it 'should return return 0.01"' do
      expect(CashRegister.CountCashRegister(19.50, 20.00, [["PENNY", 0.01], ["NICKEL", 0], ["DIME", 0], ["QUARTER", 0], ["ONE", 0], ["FIVE", 0], ["TEN", 0], ["TWENTY", 0], ["ONE HUNDRED", 0]])).to eq(0.01)
    end
  end

  describe 'ChangeNeeded' do
    context 'subtracts cash amount from item price ' do
      it 'should return correct customer change = 0.5' do
        expect(CashRegister.ChangeNeeded(19.50, 20.00, [["PENNY", 0.01], ["NICKEL", 0], ["DIME", 0], ["QUARTER", 0], ["ONE", 0], ["FIVE", 0], ["TEN", 0], ["TWENTY", 0], ["ONE HUNDRED", 0]])).to eq(0.5)
      end
      it 'should return correct customer change = 29.5' do
        expect(CashRegister.ChangeNeeded(19.50, 50.00, [["PENNY", 0.01], ["NICKEL", 0], ["DIME", 0], ["QUARTER", 0], ["ONE", 0], ["FIVE", 0], ["TEN", 0], ["TWENTY", 0], ["ONE HUNDRED", 0]])).to eq(30.5)
      end
    end
  end

  describe 'getChange' do
    context 'converts change to appropriate output' do
      it 'should return correct output' do
        expect(CashRegister.GetChange(100.25)).to eq( [["ONEHUNDRED ", 100.0], ["QUARTER ", 0.25]] )
      end
      it 'should return correct output' do
        expect(CashRegister.GetChange(200.53)).to eq( [["ONEHUNDRED ", 200.0], ["QUARTER ", 0.5], ["PENNY ", 0.03]] )
      end
    end
  end

  describe 'checkCashRegister' do
    context 'returns appropriate status' do
      it "should return Insuficient Funds if change due is greater than change available" do
        expect(CashRegister.checkCashRegister(19.50, 20.00, [["PENNY", 0.01], ["NICKEL", 0], ["DIME", 0], ["QUARTER", 0], ["ONE", 0], ["FIVE", 0], ["TEN", 0], ["TWENTY", 0], ["ONE HUNDRED", 0]])).to eq('Insuficient Funds')
      end
      it "should return Closed if change due is equal to change available" do
        expect(CashRegister.checkCashRegister(19.50, 19.51, [["PENNY", 0.01], ["NICKEL", 0], ["DIME", 0], ["QUARTER", 0], ["ONE", 0], ["FIVE", 0], ["TEN", 0], ["TWENTY", 0], ["ONE HUNDRED", 0]])).to eq('Closed')
      end
      it "should return amount if change available is greater than change due" do
        expect(CashRegister.checkCashRegister(19.50, 20.00, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.10], ["QUARTER", 4.25], ["ONE", 90.00], ["FIVE", 55.00], ["TEN", 20.00], ["TWENTY", 60.00], ["ONE HUNDRED", 100.00]])).to eq( [["QUARTER ", 0.5]] )
      end
      it "should return amount if change available is greater than change due" do
        expect(CashRegister.checkCashRegister(20.50, 50.00, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.10], ["QUARTER", 4.25], ["ONE", 90.00], ["FIVE", 55.00], ["TEN", 20.00], ["TWENTY", 60.00], ["ONE HUNDRED", 100.00]])).to eq( [["TWENTY ", 20.0], ["FIVE ", 5.0], ["ONE ", 4.0], ["QUARTER ", 0.5]] )
      end
      it "should correct change when paying one hundred for three dollars and twenty six cents" do
        expect(CashRegister.checkCashRegister(3.26, 100.00, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.10], ["QUARTER", 4.25], ["ONE", 90.00], ["FIVE", 55.00], ["TEN", 20.00], ["TWENTY", 60.00], ["ONE HUNDRED", 100.00]])).to eq([["TWENTY", 60], ["TEN", 20], ["FIVE", 15], ["ONE", 1], ["QUARTER", 0.5], ["DIME", 0.2], ["PENNY", 0.04]])
      end
    end
  end

  describe 'TotalCashRegisterSum' do
    it "should total up some in cash register" do
      expect(CashRegister.TotalCashRegisterSum(20.50, 50.00, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.10], ["QUARTER", 4.25], ["ONE", 90.00], ["FIVE", 55.00], ["TEN", 20.00], ["TWENTY", 60.00], ["ONE HUNDRED", 100.00]])).to eq(335.41)
    end
  end
end

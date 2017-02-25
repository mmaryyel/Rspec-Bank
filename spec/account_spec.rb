require 'account'

describe Account do
  let(:account) { Account.new("0123456789") }
  let(:account2) { Account.new("1234561110", 100) }
  let(:account3) { Account.new("1234565590", 1) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Account" do
        # o = Object.new
        expect(account).to be_an_instance_of Account
      end
    end

    context "with invalid input" do
      it "throws an InvalidAccountNumberError when acct_number has less than 10 digits" do
        expect { Account.new("012345678") }.to raise_error(InvalidAccountNumberError)
      end
    end
  end

  context "when using default starting_balance" do
    describe "#transactions" do


      it "returns the default starting_balance" do
        expect(account.transactions).to eq([0])
      end
    end

    describe "#balance" do
      it "is 0" do
        expect(account.balance).to eq(0)
      end
    end
  end

  context "when initialized with a starting_balance" do

    describe "#transactions" do
      it "returns the specified balance" do
        expect(account2.transactions).to eq([100])
        expect(account3.transactions).to eq([1])
      end
    end

    describe "#balance" do
      it "is the specified balance" do
        expect(account2.balance).to eq(100)
        expect(account3.balance).to eq(1)
      end
    end

    describe "#withdraw!" do
      it "decreases the balance" do
        expect(account2.withdraw!(-90)).to eq(10)
        expect(account3.withdraw!(1)).to eq(0)
      end

      it "substracts positive amounts" do
        expect(account2.withdraw!(-90)).to eq(10)
      end
    end
  end

  describe "#account_number" do
    it "masks the number of the account" do
      expect(account2.acct_number).to eq("******1110")
      expect(account.acct_number).to eq("******6789")
    end
  end

  describe "deposit!" do
    it "requires a positive amount" do
      expect { account3.deposit!(-100) }.to raise_error(NegativeDepositError )
    end

    it "increases the balance of the account" do
      expect(account.deposit!(10)).to eq(10)
    end
  end

  describe "#withdraw!" do
    it "throws an OverdraftError when withdraw amount is bigger than balance" do
      expect { account2.withdraw!(101) }.to raise_error(OverdraftError)
      expect { account3.withdraw!(2) }.to raise_error(OverdraftError)
    end
  end
end

require_relative '../credit_card'
require 'minitest/autorun'

describe 'Test hashing requirements' do
  before do
    # Feel free to replace the contents of cards with data from your own yaml file
    @card_details = [
      { num: '4916603231464963', exp: 'Mar-30-2020', name: 'Soumya Ray', net: 'Visa' },
      { num: '6011580789725897', exp: 'Sep-30-2020', name: 'Nick Danks', net: 'Visa' },
      { num: '5423661657234057', exp: 'Feb-30-2020', name: 'Lee Chen', net: 'Mastercard' }
    ]
    @cards = @card_details.map { |c| CreditCard.new(c[:num], c[:exp], c[:name], c[:net]) }

  end

  describe 'Test regular hashing' do
    it 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      @cards.each do |c|
        assert_equal c.hash, CreditCard.new(c.number, c.expiration_date, c.owner, c.credit_network).hash
        c.hash.wont_be_nil
      end
    end

    it 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
        combination = @cards.combination(3).to_a
        combination.each { |comb| comb[0].hash.wont_equal comb[1].hash }
    end
  end

  describe 'Test cryptographic hashing' do
    it 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      @cards.each do |c|
        c.hash_secure.must_equal CreditCard.new(c.number, c.expiration_date, c.owner, c.credit_network).hash_secure
        c.hash_secure.wont_be_nil
      end
    end

    it 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      combination = @cards.combination(3).to_a
      combination.each { |comb| comb[0].hash_secure.wont_equal comb[1].hash_secure }
    end

    it 'Check regular hash not same as cryptographic hash' do
      # TODO: Check that each card's hash is different from its hash_secure
      @cards.each { |c| c.hash.wont_equal c.hash_secure  }
    end
  end
end

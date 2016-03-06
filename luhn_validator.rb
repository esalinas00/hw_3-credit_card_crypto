module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)[0..-2]

    if nums_a.length & 1 != 0
      # odd
      puts "Odd length : #{nums_a.length}"
      pos_mul_2 = nums_a.each_with_index.map{ |d, i| i & 1 != 0 ? d : d << 1 }
    else
      # even
      puts "Even length : #{nums_a.length}"
      pos_mul_2 = nums_a.each_with_index.map{ |d, i| i & 1 != 0 ? d << 1 : d }
    end
    number.to_s.chars.map(&:to_i).pop == 10 - (pos_mul_2.map{ |d| d > 9 ? d - 10 + 1 : d }.inject(0, :+) % 10)
  end
end

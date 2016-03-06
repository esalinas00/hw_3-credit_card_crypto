module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)[0..-2]
    if nums_a.length & 1 != 0
      pos_mul_2 = nums_a.each_with_index.map{ |d, i| i & 1 != 0 ? d : d << 1 }
    else
      pos_mul_2 = nums_a.each_with_index.map{ |d, i| i & 1 != 0 ? d << 1 : d }
    end
    digit_might_be_2 = 10 - (pos_mul_2.map{ |d| d > 9 ? d - 10 + 1 : d }.inject(0, :+) % 10)
    digit_might_be_2 == 10 ? next_check_digit = 0 : next_check_digit = digit_might_be_2
    number.to_s.chars.map(&:to_i).pop == next_check_digit
  end
end

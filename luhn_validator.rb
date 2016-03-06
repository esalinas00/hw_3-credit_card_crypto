module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    popped_last_nums_a = nums_a[0..-2]

    if popped_last_nums_a.length.even?
      pos_mul_2 = popped_last_nums_a.each_with_index.map{ |d, i| i.even? ? d : d << 1 }
    else
      pos_mul_2 = popped_last_nums_a.each_with_index.map{ |d, i| i.even? ? d << 1 : d }
    end

    digit_might_be_2 = 10 - (pos_mul_2.map{ |d| d > 9 ? d - 10 + 1 : d }.reduce(:+) % 10)
    digit_might_be_2 == 10 ? next_check_digit = 0 : next_check_digit = digit_might_be_2
    nums_a.last == next_check_digit
  end
end

module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    last_digit = nums_a.slice!(-1)
    sum = 0

    if nums_a.length.even?
      nums_a.each_with_index.map do |d, i|
        if i.even?
          if d > 9
            sum += (d - 9)
          else
            sum += d
          end
        else
          d <<= 1
          if d > 9
            sum += (d - 9)
          else
            sum += d
          end
        end
      end
    else
      nums_a.each_with_index.map do |d, i|
        if i.even?
          d <<= 1
          if d > 9
            sum += (d - 9)
          else
            sum += d
          end
        else
          if d > 9
            sum += (d - 9)
          else
            sum += d
          end
        end
      end
    end

    digit_might_be_2 = 10 - (sum % 10)

    if digit_might_be_2 == 10
      last_digit == 0
    else
      last_digit == digit_might_be_2
    end

    # Here is clean and readable solution but slow
    # nums_a = number.to_s.chars.map(&:to_i)
    # last_digit = nums_a.slice!(-1)
    #
    # if nums_a.length.even?
    #   pos_mul_2 = nums_a.each_with_index.map{ |d, i| i.even? ? d : d << 1 }
    # else
    #   pos_mul_2 = nums_a.each_with_index.map{ |d, i| i.even? ? d << 1 : d }
    # end
    #
    # digit_might_be_2 = 10 - (pos_mul_2.map{ |d| d > 9 ? d - 10 + 1 : d }.reduce(:+) % 10)
    # digit_might_be_2 == 10 ? next_check_digit = 0 : next_check_digit = digit_might_be_2
    # last_digit == next_check_digit
  end
end

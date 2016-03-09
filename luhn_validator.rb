module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    check_digit = nums_a.pop
    nums_a.reverse!.map!.with_index do |n,i|
  	  if i%2 == 0 
	    n2 = n*2
	    ((n2%10)+(n2/10))
  	  else
  	    n
  	  end
  	end
  	
  	mod = nums_a.reduce(&:+)%10
  	if mod == 0
      mod == check_digit
  	else
  	  10 - mod == check_digit
  	end
  end
end

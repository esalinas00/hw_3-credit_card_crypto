class Array
  def unshuffle(random:)
    transformed_order = (0...length).to_a.shuffle!(random: random)
    sort_by.with_index{|_, i| transformed_order[i]}
  end
end

module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    
    array_a = create_matrix(document)
    #shuffle the array
    array_a.shuffle!(random: Random.new(key))
    array_a.each { |row| row.shuffle!(random: Random.new(key)) }
    array_a.join("")
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    array_a = create_matrix(ciphertext)    
    array_a.map! { |row| row.unshuffle(random: Random.new(key)) }
    array_a = array_a.unshuffle(random: Random.new(key))
    array_a.join("")
  end

  def self.create_matrix(document)
    document = document.to_s.chars
    a_len = (document.length ** 0.5).ceil
    array_a = Array.new(a_len) do |i| 
      i = Array.new(a_len) do |j|  
        document[0] == nil ? ('a'..'z').to_a[rand(26)] : document.shift
      end
    end
  end
end

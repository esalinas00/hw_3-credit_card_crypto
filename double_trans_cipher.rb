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
    array_a.each { |row| row.shuffle!(random: Random.new(key)) }.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    array_a = create_matrix(ciphertext)
    array_a.map! { |row| row.unshuffle(random: Random.new(key)) }
    array_a.unshuffle(random: Random.new(key)).join
  end

  def self.create_matrix(document)
    matrix_size = (document.to_s.length ** 0.5).ceil

    rows, cols = matrix_size, matrix_size
    # create 2d array with value nil
    grid = Array.new(rows) { Array.new(cols) }
    # fill in array with garbage value 'a'
    grid.map! { |row| row.map { |e| e = 'a' } }

    document.to_s.chars.each_with_index.map do |c, i|
      x, y = i.divmod(11)
      grid[x][y] = c
    end
    grid
  end
end

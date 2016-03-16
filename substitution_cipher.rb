module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher

      # readable version
      # document.to_s.chars.map do |c|
      #   if c.ord + key > 126
      #     new_ord = 31 + (c.ord + key) - 126
      #   else
      #     new_ord = c.ord + key
      #   end
      # end

      document
        .to_s
        .chars
        .map{ |c| c.ord + key > 126 ? 31 + (c.ord + key) - 126 : c.ord + key }
        .map{ |o| o.chr }
        .join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher

      # readable version
      # document.to_s.chars.map do |c|
      #   if c.ord - key < 32
      #     new_ord = 126 + (c.ord - key) - 31
      #   else
      #     new_ord = c.ord - key
      #   end
      # end

      document
        .to_s
        .chars
        .map{ |c| c.ord - key < 32 ? 126 + (c.ord - key) - 31 : c.ord - key }
        .map{ |o| o.chr }
        .join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      all_ascii_ord = [*32..126]

      new_ord = all_ascii_ord.shuffle(random: Random.new(key))

      all_ascii_to_new_ord = Hash[all_ascii_ord.zip(new_ord)]

      document
        .to_s
        .chars
        .map{ |c| all_ascii_to_new_ord[c.ord] }
        .map{ |o| o.chr }
        .join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      all_ascii_ord = [*32..126]

      new_ord = all_ascii_ord.shuffle(random: Random.new(key))

      new_ord_to_all_ascii = Hash[new_ord.zip(all_ascii_ord)]

      document
        .to_s
        .chars
        .map{ |c| new_ord_to_all_ascii[c.ord] }
        .map{ |o| o.chr }
        .join
    end
  end
end

require 'openssl'
require 'json'
require 'base64'

def puts_bytes(description, str_utf8)
  puts "#{description} (ascii): #{str_utf8.inspect}"
  padding = ' ' * (description.length + 3)
  puts padding + "(dec): #{str_utf8.bytes.join(' ')}"
  puts padding + "(hex): #{str_utf8.unpack("H*").first}"
  puts padding + "(b64): #{Base64.strict_encode64(str_utf8)}"
  puts
end

module AesCipher
  def self.encrypt(document, key)
    # TODO: Return JSON string of array: [iv, ciphertext]
    #       where iv is the random intialization vector used in AES
    #       and ciphertext is the output of AES encryption
    # NOTE: Use base64 for ciphertext so that it is screen printable
    #       Use cipher block chaining mode only!
    plaintext = document.to_s
    cipher = OpenSSL::Cipher::AES.new(256, :CBC).encrypt
    # key = cipher.random_key
    iv = cipher.random_iv
    # puts_bytes('key', key)
    # puts_bytes('IV', iv)

    cipher.key = Digest::SHA256.hexdigest(key.to_s)
    encrypted = cipher.update(plaintext) + cipher.final
    # puts_bytes('encrypted', encrypted)

    ret = [iv.unpack('H*'), encrypted.unpack('H*')]
    ret.to_json
  end

  def self.decrypt(aes_crypt, key)
    # TODO: decrypt from JSON output (aes_crypt) of encrypt method above
    aes_crypt_array = JSON.parse(aes_crypt)

    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = Digest::SHA256.hexdigest(key.to_s)

    decipher.iv = aes_crypt_array.first.pack('H*')
    ciphertext = aes_crypt_array.last.pack('H*')

    original = decipher.update(ciphertext) + decipher.final
    original
  end
end

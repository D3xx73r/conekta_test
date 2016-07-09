class Cipher
  def initialize(pass)
    @cipher = Gibberish::AES.new(pass)
  end

  def encrypt(data)
    cipher.encrypt(data)
  end

  def decrypt(data)
    cipher.decrypt(data)
  end

  private

  attr_reader :cipher
end

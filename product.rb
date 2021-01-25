class Product
  attr_accessor :name, :price, :signed_on

  def initialize(name, price)
    @name = name
    @price = price
  end

  def contract
    raise NotImplementedError
  end

  def delayed_revenue
    # 即時に売上全額を収益認識
    price - contract
  end
end

class SpreadSheet < Product
  def contract
    # 即時に2/3を収益認識
    (price / 3) * 2
  end
end

class WordProcessor < Product
  def contract
    # 即時に売上全額を収益認識
    price
  end
end

class Database < Product
  def contract
    # 即時に1/3を収益認識
    price / 3
  end
end


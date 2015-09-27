class ShopDetective # reopen ShopDetective
  class Errors < StandardError
    # http://stackoverflow.com/questions/21122691/attr-accessor-on-class-variables
    class << self
      attr_reader :code
    end 

    def code
      self.class.code
    end
  end
end
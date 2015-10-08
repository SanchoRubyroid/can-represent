module GlobalMenu
  class Item
    attr_reader :name, :path

    def initialize(name, path)
      @name = name
      @path = path
    end
  end
end
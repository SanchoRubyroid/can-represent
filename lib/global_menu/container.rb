module GlobalMenu
  class Container

    attr_reader :lookup, :caption, :path

    def initialize(name, path = nil)
      @lookup = underscored_name(name)
      @caption = humanized_name(name)
      @path = (path || 'javascript:void(0)')

      @items = []
    end

    def add_item(item_name, item_path)
      unless @items.detect{ |stored_item| stored_item.is?(item_name) }
        @items << GlobalMenu::Item.new(item_name, item_path)
      end
    end

    def <<(item)
      fail 'Not an instance of GlobalMenu::Item' unless item.is_a?(GlobalMenu::Item)
      @items << item
    end

    def each_item
      @items.each { |item| yield item}
    end

    def is?(name)
      lookup == underscored_name(name)
    end

    private

    def humanized_name(name)
      normalize_name(name).humanize
    end

    def underscored_name(name)
      normalize_name(name).underscore
    end

    def normalize_name(name)
      fail 'Not an instance of String' unless name.is_a?(String)

      name.gsub(/[[:space:]]+/, '_')
    end
  end
end
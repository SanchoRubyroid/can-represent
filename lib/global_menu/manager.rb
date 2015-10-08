module GlobalMenu
  class Manager

    def initialize
      @containers = []
    end

    def for_container(name, path = nil)
      container = @containers.detect { |stored_container| stored_container.is?(name) }
      container ||= add_container(name, path)

      yield container
    end

    def add_container(name, path)
      @containers << GlobalMenu::Container.new(name, path)

      @containers.last
    end

    def each_container
      @containers.each { |container| yield container }
    end

  end
end
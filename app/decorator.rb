class Decorator
  attr_reader :object

  def self.decorate(original_objects)
    original_objects.map { |object| new object  }
  end

  def initialize(object)
    @object = object
  end

  def method_missing(method, *args)
    object.send method, *args
  end
end

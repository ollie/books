# View suger helpers for database models
class Decorator
  attr_reader :object

  # Decorator.decorate [ 1, 2, 3, 4 ]
  # Decorator.decorate 1
  def self.decorate(original_object_or_collection)
    if original_object_or_collection.respond_to? :map
      original_object_or_collection.lazy.map do |original_object|
        new original_object
      end
    else
      new original_object_or_collection
    end
  end

  def initialize(object)
    @object = object
  end

  # We build a proxy. If the decorated object responnd
  def method_missing(method, *args)
    super unless object.respond_to? method

    # We want to define it on the singleton class, not the whole Decorator
    # class, otherwise it would grow continually across all decorators.
    define_singleton_method method do
      object.send method, *args
    end

    send method, *args
  end
end

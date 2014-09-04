module Sequel
  module Plugins
    module Decorated
      # Per-instance methods.
      module InstanceMethods
        def decorate(decorator)
          decorator.decorate self
        end
      end

      # Dataset extension methods.
      module DatasetMethods
        def decorate_each(decorator)
          decorator.decorate self
        end
      end
    end
  end
end

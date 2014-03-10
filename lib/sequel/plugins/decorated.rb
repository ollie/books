module Sequel
  module Plugins
    module Decorated

      module InstanceMethods
        def decorate(decorator)
          decorator.decorate self
        end
      end

      module DatasetMethods
        def decorate_each(decorator)
          decorator.decorate self
        end
      end

    end
  end
end

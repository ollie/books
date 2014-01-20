class BookDecorator < Decorator
  def percentage_in_parenthesis
    percentage = object.percentage
    percentage = percentage.round 1 if percentage.is_a? Float
    percentage = percentage.to_i if percentage % 1 == 0
    "(#{ percentage } %)"
  end
end

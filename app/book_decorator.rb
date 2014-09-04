# View sugar helpers for a book model
class BookDecorator < Decorator
  def rounded_percentage
    percentage = object.percentage
    percentage = percentage.round 1 if percentage.is_a? Float
    percentage = percentage.to_i if percentage % 1 == 0
    percentage
  end

  def progress_bar_type
    case object.percentage.to_i
    when 0..9
      'progress-bar-danger'
    when 10..19
      'progress-bar-warning'
    when 20..59
      'progress-bar-info'
    else
      'progress-bar-success'
    end
  end
end

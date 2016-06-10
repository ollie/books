# Database model for a single book
class Book < Sequel::Model
  plugin :decorated
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  dataset_module do
    def state_reading
      exclude(read: true)
        .where { page > 0 }
        .order(Sequel.desc(:percentage), Sequel.desc(:created_at))
    end

    def state_new
      exclude(read: true)
        .where(page: 0)
        .order(Sequel.desc(:percentage), Sequel.desc(:created_at))
    end

    def state_read
      where(read: true).order(Sequel.desc(:created_at))
    end

    def list
      order(:created_at)
    end
  end

  private

  def validate
    super

    validates_presence [:name, :path, :page, :pages]
    validates_integer [:page, :pages]
    validates_includes((0..pages), :page) if pages
  end

  def before_validation
    set_percentage
    set_read

    super
  end

  def set_percentage
    return if page.nil? || pages.nil?

    self.percentage =
      if page.zero?
        0
      else
        page.to_f / pages * 100
      end
  end

  def set_read
    return if page.nil? || pages.nil?
    self.read = page == pages
  end
end

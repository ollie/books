class Book < Sequel::Model
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  def self.list
    order(:read, Sequel.desc(:percentage), :created_at)
  end

  def before_validation
    if page.zero?
      self.percentage = 0
    else
      self.percentage = page.to_f / pages * 100
    end

    self.read = page == pages
    super
  end

  def validate
    super
    validates_presence [ :name, :path, :page, :pages ]
    validates_integer  [ :page, :pages ]
  end
end

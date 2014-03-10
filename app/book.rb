class Book < Sequel::Model
  plugin :decorated
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  def self.list
    order(:read, Sequel.desc(:percentage), :created_at)
  end

  def before_validation
    set_percentage
    set_read
    super
  end

  def set_percentage
    return if page.nil? || pages.nil?
    if page.zero?
      self.percentage = 0
    else
      self.percentage = page.to_f / pages * 100
    end
  end

  def set_read
    return if page.nil? || pages.nil?
    self.read = page == pages
  end


  def validate
    super
    validates_presence [ :name, :path, :page, :pages ]
    validates_integer  [ :page, :pages ]
    validates_includes (0..pages), :page if pages
  end
end

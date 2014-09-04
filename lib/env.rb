require 'logger'

class Env
  @settings = {}

  def self.configure(*environments, &block)
    return unless environments.empty? || environments.include?(ENV['RACK_ENV'].to_sym)
    instance_eval &block
  end

  def self.set(key, value)
    @settings[key] = value

    self.class.instance_eval do
      define_method key do
        @settings[key]
      end unless method_defined? key
    end
  end

  def self.load_translations
    I18n.load_path = Dir[ root.join('config/locales/**/*.{rb,yml}') ]
    I18n.backend.load_translations
    I18n.enforce_available_locales = true # TODO: Shows deprecation warning if not set, check back later.
  end

  def self.require_app_files
    require root.join('lib', 'sequel', 'plugins', 'decorated')
    require root.join('app', 'book')
    require root.join('app', 'decorator')
    require root.join('app', 'book_decorator')

    db.disconnect # Prevent errors when forking in Passenger
  end

  def self.production?
    ENV['RACK_ENV'] == 'production'
  end

  configure do
    set :root, Pathname.new( File.expand_path('../..', __FILE__) )
    set :db_name, "books_#{ ENV['RACK_ENV'] }"
    set :db_path, "postgres://localhost/#{ db_name }"

    load_translations
  end

  configure :production do
    set :db_logger, Logger.new(root.join('log', 'production.log'))
  end

  configure :development do
    set :db_logger, Logger.new($stdout)
  end

  configure do
    set :db, Sequel.connect(db_path, logger: db_logger)
  end
end

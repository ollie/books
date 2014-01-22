require 'logger'

class Env
  ROOT    = Pathname.new( File.expand_path('../..', __FILE__) )
  DB_NAME = 'books_development'
  DB_PATH = "postgres://localhost/#{ DB_NAME }"

  def self.root
    ROOT
  end

  def self.db_name
    DB_NAME
  end

  def self.db_path
    DB_PATH
  end

  def self.production?
    ENV['RACK_ENV'] == 'production'
  end

  def self.db_logger
    file = if production?
      root.join('log', 'production.log')
    else
      $stdout
    end

     Logger.new file
  end

  DB = Sequel.connect(DB_PATH, logger: db_logger)

  def self.db
    DB
  end

  def self.require_app_files
    require root.join('app', 'book')
    require root.join('app', 'decorator')
    require root.join('app', 'book_decorator')

    db.disconnect # Prevent errors when forking in Passenger
  end
end

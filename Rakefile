require 'bundler'
Bundler.require :default, :development

ENV['RACK_ENV'] ||= 'development'

class String
  def unindent(number_of_chars = nil)
    number_of_chars = lines.first.index(/[^ ]/) unless number_of_chars

    joined = lines.map do |line|
      line.gsub(%r{^ {#{ number_of_chars }}}, '')
    end.join

    joined
  end
end

task :environment do
  require File.expand_path( File.join('..', 'lib', 'env'), __FILE__ )
  Env.require_app_files
end

task :setup do
  require File.expand_path( File.join('..', 'lib', 'env'), __FILE__ )
end

task models: :setup do
  require File.expand_path( File.join('..', 'lib', 'sequel', 'plugins', 'decorated'), __FILE__ )
  require File.expand_path( File.join('..', 'app', 'book'), __FILE__ )
end

namespace :db do
  desc 'Create database'
  task create: :setup do
    sh "createdb #{ Env.db_name }"
  end

  desc 'Drop database'
  task drop: :setup do
    sh "dropdb #{ Env.db_name }"
  end

  desc 'Migrate database'
  task migrate: :setup do
    sh "sequel -E -m db/migrations #{ Env.db_path }"
  end

  desc 'Empty database'
  task empty: :setup do
    Env.db[:books].delete
  end

  desc 'Dump database as Ruby file'
  task dump: :models do
    abort if Book.count.zero?
    file = Env.root.join("books_#{ ENV['RACK_ENV'] }.rb")
    puts "Dumping to #{ file }"

    File.open(file, 'w') do |file|
      file << "BOOKS = [\n"

      Book.list.each do |book|
        file << <<-END.unindent(8)
          {
            name:   #{ book.name.inspect },
            author: #{ book.author.inspect },
            path:   #{ book.path.inspect },
            page:   #{ book.page.inspect },
            pages:  #{ book.pages.inspect },
          },
        END
      end

      file << "]\n"
    end
  end

  desc 'Load books into the database'
  task load: [ :models, :empty ] do
    require Env.root.join("books_#{ ENV['RACK_ENV'] }.rb")
    abort if BOOKS.empty?

    BOOKS.each do |book|
      Book.create(book)
    end
  end

  desc 'Dump database'
  task dump_as_sql: :setup do
    sh "pg_dump #{ Env.db_path } > books_development.sql"
  end
end

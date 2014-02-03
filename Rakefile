require 'bundler'
Bundler.require :default, :development

task :environment do
  require File.expand_path( File.join('..', 'lib', 'env'), __FILE__ )
  Env.require_app_files
end

task :setup do
  require File.expand_path( File.join('..', 'lib', 'env'), __FILE__ )
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

  desc 'Dump database'
  task dump: :setup do
    sh "pg_dump #{ Env.db_path } > books_development.sql"
  end

  desc 'Seed database'
  task seed: :environment do
    Book.create({
      name:   'PMI-80 (Assembly)',
      author: 'Ing. Jaroslav Vlach',
      path:   'pmi80_kniha.pdf',
      page:   1,
      pages:  108,
    })

    Book.create({
      name:   'Haskell',
      author: 'Wikibooks.org',
      path:   'Haskell.pdf',
      page:   166,
      pages:  597,
    })

    Book.create({
      name:   '21st Century C',
      author: 'Ben Klemens',
      path:   '21st_century_c.pdf',
      page:   39,
      pages:  298,
    })

    Book.create({
      name:   'The C Programming Language 2nd Edition',
      author: 'Brian W. Kernighan & Dennis M. Ritchie',
      path:   'Ritchie-Kernighan-The_C_Programming_Language_2_ed_.pdf',
      page:   54,
      pages:  288,
    })

    Book.create({
      name:   'Programming Erlang',
      author: 'Joe Armstrong',
      path:   'Programming_Erlang.pdf',
      page:   66,
      pages:  526,
    })

    Book.create({
      name:   'Erlang Programming',
      author: 'Francesco Cesarini & Simon Thompson',
      path:   'erlang_programming.pdf',
      page:   139,
      pages:  496,
    })

    Book.create({
      name:   'Introducing Erlang',
      author: 'Simon St. Laurent',
      path:   'introducing_erlang.pdf',
      page:   201,
      pages:  201,
    })

    Book.create({
      name:   'Learning Cocoa with Objective-C',
      author: 'Paris Buttfield-Addison & Jonathon Manning',
      path:   'learning_cocoa_with_objective-c_3rd_edition.pdf',
      page:   35,
      pages:  360,
    })

    Book.create({
      name:   'Learning Java 4th Edition',
      author: 'Patrick Niemeyer & Daniel Leuck',
      path:   'learning_java_fourth_edition.pdf',
      page:   393,
      pages:  1010,
    })

    Book.create({
      name:   'Learning Python 4th Edition',
      author: 'Mark Lutz',
      path:   'learning_python_fourth_edition.pdf',
      page:   1213,
      pages:  1213,
    })

    Book.create({
      name:   'Learning Python 5th Edition',
      author: 'Mark Lutz',
      path:   'learning_python_fifth_edition.pdf',
      page:   186,
      pages:  1594,
    })

    Book.create({
      name:   'Programming Python 4th Edition',
      author: 'Mark Lutz',
      path:   'programming_python_4th_edition.pdf',
      page:   216,
      pages:  1628,
    })

    Book.create({
      name:   'Clean Code',
      author: 'Robert C. Martin',
      path:   'Clean_Code_-_A_Handbook_of_Agile_Software_Craftsmanship.pdf',
      page:   114,
      pages:  462,
    })

    Book.create({
      name:   'The Art of Assembly Language 2nd Edition',
      author: 'Randall Hyde',
      path:   'the_art_of_assembly_language_2nd_edition.pdf',
      page:   0,
      pages:  764,
    })

    Book.create({
      name:   'Write Great Code',
      author: 'Randall Hyde',
      path:   'write_great_code_volume_1.pdf',
      page:   0,
      pages:  461,
    })

    Book.create({
      name:   'Mobile First',
      author: 'Luke Wroblewski',
      path:   'mobile_first.pdf',
      page:   0,
      pages:  138,
    })

    Book.create({
      name:   'Responsive Web Design',
      author: 'Ethan Marcotte',
      path:   'responsive_web_design.pdf',
      page:   0,
      pages:  157,
    })
  end
end

require 'sinatra/form_helpers'
require File.expand_path( File.join('..', '..', 'lib', 'env'), __FILE__ )
require File.expand_path( File.join('..', '..', 'lib', 'sequel', 'plugins', 'decorated'), __FILE__ )

Env.require_app_files

class App < Sinatra::Base
  register Sinatra::Partial
  register Sinatra::Flash

  helpers Sinatra::FormHelpers
  use Rack::Deflater

  enable :sessions # Flash needs this
  enable :partial_underscores
  set :partial_template_engine, :slim
  set :slim, layout: :'layouts/application', pretty: !production?

  get '/' do
    @books = Book.list
    slim :index
  end

  get '/books/new' do
    @book = Book.new
    slim :new
  end

  post '/books' do
    @book = Book.new params[:book]

    if @book.valid?
      @book.save
      flash.next[:success] = I18n.t('book_created')
      redirect url('/')
    else
      flash.now[:danger] = I18n.t('could_not_save_book')
      slim :new
    end
  end

  get '/books/:id/edit' do
    @book = Book.first!(id: params[:id])
    slim :edit
  end

  post '/books/:id' do
    @book = Book.first!(id: params[:id])
    @book.set params[:book]

    if @book.valid?
      @book.save
      flash.next[:success] = I18n.t('book_updated')
      redirect url('/')
    else
      flash.now[:danger] = I18n.t('could_not_save_book')
      slim :edit
    end
  end

  get '/books/:id/delete' do
    @book = Book.first!(id: params[:id])
    @book.destroy
    flash.next[:success] = I18n.t('book_destroyed')
    redirect url('/')
  end

  # get '/books/:id/page/:page' do
  #   @book = Book.first!(id: params[:id])
  #   @book.page = params[:page]
  #   @book.save if @book.valid?
  #   redirect url('/')
  # end

  # get '/books/:id/plus' do
  #   @book = Book.first!(id: params[:id])
  #   @book.page += 1
  #   @book.save if @book.valid?
  #   redirect url('/')
  # end

  # get '/books/:id/minus' do
  #   @book = Book.first!(id: params[:id])
  #   @book.page -= 1
  #   @book.save if @book.valid?
  #   redirect url('/')
  # end
end

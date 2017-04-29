$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
require 'sinatra/base'
require 'mortgage_calc'

class Calc < Sinatra::Base
  configure do
    enable :sessions
    set :server,  :puma
    set :public_folder, File.join(File.dirname(__FILE__), '../public')
    set :views, File.join(File.dirname(__FILE__), '../views')
    set :bind, '0.0.0.0'
  end

  get '/' do
    @data = session[:data] || MortgageCalc::Dashboard.new
    haml :index
  end

  post '/calculate' do
    session[:data] = MortgageCalc::Dashboard.new(params_data)
    redirect back
  end

  def params_data
    {
      amount: params[:amount],
      base_rate: params[:base_rate],
      increment: params[:increment],
      income: params[:income],
      expense: params[:expense]
    }
  end

  run! if app_file == $PROGRAM_NAME
end

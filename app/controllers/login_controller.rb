class LoginController < ApplicationController
  def index
    render "new"
  end
  def show
    render "new"
  end

  def create
    puts "craete"
    user = User.find_by_name params[:name]
    puts user
    if user && user.authenticate(params[:pass])
      # セッションのキー:user_idへユーザーのIDを登録
      session[:user_id] = user.id
      redirect_to root_path
    else
      # flash変数にメッセージをセット
      flash.now.alert = "もう一度入力してください。"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :controller => 'login', :action => 'index'
  end
end

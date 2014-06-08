class MessageController < ApplicationController
  before_action :require_login
  def require_login
    unless logged_in?
      redirect_to :controller => 'top'
    end
  end
  def logged_in?
    session[:user_id]
  end
  def to_json_array(ms)
		Jbuilder.encode do |json|
			json.messages ms do |m|
				json.(m, :id, :body, :finished)
			end
		end
  end

	def index
		if @messages == nil then
			@messages = User.find(session[:user_id]).messages.where('finished is null or finished = false')
			respond_to do |format|
    		format.html
    		format.json {render :json => @messages}
  		end
		end
  end
  def all
  	@messages = User.find(session[:user_id]).messages
		render 'index'
  end
  def show
  	@message = Message.find(params[:id])
  end
  def create
  	attr = params.require(:message).permit(:body)
  	@message = Message.new(attr)
  	@message.user_id = session[:user_id]
  	@message.save
		redirect_to :action => 'index'
	end
  def new
  	@message = Message.new
	end
	def edit
		@message = Message.find(params[:id])
	end
	def update
  	attr = params.require(:message).permit(:body)
    @message = Message.find(params[:id])  
    @message.attributes = attr
  	@message.save
		redirect_to :action => 'index'
	end
	def unfinish
		@message = Message.find(params[:id])
		@message.finished = false
		@message.save
		redirect_to :back
	end
	def destroy
		@message = Message.find(params[:id])
		@message.destroy
		redirect_to :back
	end
	def finish
		@message = Message.find(params[:id])
		@message.finished = true
		@message.save
		redirect_to :back
	end
	def rand_str(n)
		chars = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
		result = ""
		n.times do
  		result << chars[rand(chars.length)]
		end
		result
	end
end

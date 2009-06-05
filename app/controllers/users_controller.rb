class UsersController < ApplicationController
  layout proc{ |controller| controller.current_user ? "common" : "login" }
  before_filter :authorize, :except => :login

  def index
    @users = User.find(:all)
  end

  def logout
    reset_session
    flash[:notice] = 'Вы вышли из системы'
    redirect_to :action => :login
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        
        uri = session[:original_uri]
        session[:original_uri] = nil

        redirect_to ( uri || { :controller => :works, :action => :index })
      else
        #TODO change to redirect or flash.now and check this

        flash[:notice] = 'Неверная комбинация email-пароль...'
        render :layout => "login"
      end
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'Пользователь добавлен'
      redirect_to :action => :index
    else
      render :action => :new 
    end
  end

  def update
    @user = User.find(params[:id])

    @user.groups.clear if params[:id][:project_ids].nil?

    if @user.update_attributes(params[:user])
      flash[:notice] = 'Пользователь обновлен'
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end
end

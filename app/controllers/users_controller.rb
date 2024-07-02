class UsersController < ApplicationController
    def index
      @users = User.all
      render json: @users
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    def filter
      campaign_names = params[:campaign_names].split(',')
      @users = User.where("JSON_CONTAINS(campaigns_list, ?)", campaign_names.map { |name| { campaign_name: name }.to_json }.to_json)
      render json: @users
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, campaigns_list: [])
    end
  end
  
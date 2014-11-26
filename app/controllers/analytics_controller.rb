class AnalyticsController < ApplicationController
  before_filter :authenticate

  def dashboard
    if @access == true
      @recipes_count = Recipe.all.count
      @recipes_shared_count = Recipe.where(:shared => true).count
      @users = User.all.order(created_at: :desc)

      @users_with_one = []
      @users.each do |user|
        if Recipe.where(:user_id => user.id).count == 1
          @users_with_one.push(user)
        end
      end
      @users_with_one_count = @users_with_one.count

      @users_with_many = []
      @users.each do |user|
        if Recipe.where(:user_id => user.id).count > 1
          @users_with_many.push(user)
        end
      end
      @users_with_many_count = @users_with_many.count

      @users_with_none = []
      @users.each do |user|
        if Recipe.where(:user_id => user.id).count == 0
          @users_with_none.push(user)
        end
      end
      @users_with_none_count = @users_with_none.count
    end
  end

  def shared_recipes
    if @access == true
      @recipes = Recipe.where(:shared => true).order(created_at: :desc)
    end
  end

  def all_users
    if @access == true
      @users = User.all.order(created_at: :desc)
    end
  end

  def marketable
    if @access == true
      @users = User.all.order(created_at: :desc)
    end
  end

  private
    def authenticate
      if current_user && (current_user.id == 1 || current_user.id == 23)
        @access = true
      else
        @access = false
        flash[:danger] = "Sorry, you can't look at that page."
        redirect_to root_url
      end
    end
end

class GroceriesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :set_grocery, only: %i[update destroy]
  before_action :authenticate_user!, unless: :completion?
  before_action -> { hey_thats_my @grocery if defined?(@grocery) && !completion? }

  # GET /groceries
  def index
    @groceries = current_user.groceries.active.as_json
  end

  # GET /groceries/new
  def new; end

  # POST /groceries
  def create
    @grocery = Grocery.new(grocery_params.merge(user: current_user))

    if @grocery.save
      unless request.xhr?
        flash[:success] = 'Item added.'
        redirect_to groceries_url
      end
    else
      render :new
    end
  end

  # PATCH/PUT /groceries/1
  def update
    if @grocery.update(grocery_params)
      flash[:success] = 'Item saved.' unless @grocery.previous_changes[:completed_at]
      redirect_to groceries_url
    else
      render :show
    end
  end

  # DELETE /todos/1
  def destroy
    @grocery.destroy
    head :no_content
  end

  # GET /groceries/past
  def past
    @groceries = current_user.groceries.past.as_json
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_grocery
    @grocery = Grocery.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def grocery_params
    params.require(:grocery).permit(:name, :completed_at)
  end

  def completion?
    return unless params[:action] == 'update'
    params[:grocery] ? params[:grocery].keys.include?('completed_at') : false
  end
end

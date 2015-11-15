class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_filter :set_admin, only: [:index, :show]
  before_filter :set_admin_and_redirect, only: [:new, :create, :edit, :update, :destroy]

  include ApplicationHelper
  include TextHelper

  # GET /announcements
  def index
    @announcements = Announcement.all.order(created_at: :desc)
  end

  # GET /announcements/1
  def show
    @remove_grey_bg = true
    @recents = Announcement.all.order(created_at: :desc).where(["id != #{@announcement.id}"]).limit(3)
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
    render :edit
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /announcements
  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.body_rendered = markdown(@announcement.body)

    if @announcement.save
      flash[:success] = 'Posted!'
      redirect_to @announcement
    else
      render :new
    end
  end

  # PATCH/PUT /announcements/1
  def update
    if @announcement.update(announcement_params)
      @announcement.body_rendered = markdown(@announcement.body)
      @announcement.save
      flash[:success] = 'Announcement updated!'
      redirect_to @announcement
    else
      render :edit
    end
  end

  # DELETE /announcements/1
  def destroy
    @announcement.destroy
    flash[:danger] = 'Farewell, accidental announcement.'
    redirect_to announcements_url
  end

  def unsubscribe
    user = User.find(params[:user_id])
    user.want_newsletter = false
    user.save
    flash[:success] = 'Okay, you\'ve unsubscribed.'
    redirect_to root_url
  end

  private

  def admin_decision
    user_signed_in? && current_user.id == 1
  end

  def set_admin
    @admin = admin_decision
  end

  def admin?
    admin_decision
  end

  def set_admin_and_redirect
    redirect_to root_url unless admin?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def announcement_params
    params.require(:announcement).permit(:title, :body, :body_rendered, :author_id)
  end
end

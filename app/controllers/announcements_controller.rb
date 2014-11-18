class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_filter :check_admin, only: [:new, :edit, :update, :destroy]

  # GET /announcements
  def index
    check_admin
    @announcements = Announcement.all.reverse
  end

  # GET /announcements/1
  def show
    check_admin
  end

  # GET /announcements/new
  def new
    if @admin == true
      @announcement = Announcement.new
      render :new
    end
  end

  # GET /announcements/1/edit
  def edit
    if @admin == true
      render :edit
    end
  end

  # POST /announcements
  def create
    if @admin == true
      @announcement = Announcement.new(announcement_params)
      @announcement.body_rendered = markdown(@announcement.body)

      if @announcement.save
        flash[:success] = 'Posted!'
        redirect_to @announcement
      else
        render :new
      end
    end
  end

  # PATCH/PUT /announcements/1
  def update
    if @admin == true
      @announcement.body_rendered = markdown(@announcement.body)

      if @announcement.update(announcement_params)
        flash[:success] = 'Announcement updated!'
        redirect_to @announcement
      else
        render :edit
      end
    end
  end

  # DELETE /announcements/1
  def destroy
    if @admin == true
      @announcement.destroy
      flash[:danger] = 'Announcement deleted.'
      redirect_to announcements_url
    end
  end

  private
    def check_admin
      if current_user && (current_user.id == 1 || current_user.id == 23)
        @admin = true
      else
        @admin = false
        flash[:danger] = "Sorry, you can't access that page."
        redirect_to root_url
      end
    end

    def markdown(str)
      md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, space_after_headers: true, strikethrough: true)
      return md.render(str)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def announcement_params
      params.require(:announcement).permit(:title, :body, :body_rendered, :author_id, :mail)
    end
end

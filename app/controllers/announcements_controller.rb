class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  # GET /announcements
  def index
    @announcements = Announcement.all.reverse
    check_admin
  end

  # GET /announcements/1
  def show
    check_admin
  end

  # GET /announcements/new
  def new
    check_admin
    if @admin == true
      @announcement = Announcement.new
    else
      flash[:danger] = 'Only members of the Noodles team can write on the blog.'
      redirect_to root_url
    end
  end

  # GET /announcements/1/edit
  def edit
    check_admin
    if @admin == true
      render :edit
    else
      flash[:danger] = 'Only members of the Noodles team can write on the blog.'
      redirect_to root_url
    end
  end

  # POST /announcements
  def create
    check_admin
    if @admin == true
      @announcement = Announcement.new(announcement_params)
      @announcement.body_rendered = markdown(@announcement.body)

      if @announcement.save
        flash[:success] = 'Posted!'
        redirect_to @announcement
      else
        render :new
      end
    else
      flash[:danger] = 'Only members of the Noodles team can write on the blog.'
      redirect_to root_url
    end
  end

  # PATCH/PUT /announcements/1
  def update
    check_admin
    if @admin == true
      @announcement.body_rendered = markdown(@announcement.body)

      if @announcement.update(announcement_params)
        flash[:success] = 'Announcement updated!'
        redirect_to @announcement
      else
        render :edit
      end
    else
      flash[:danger] = 'Only members of the Noodles team can write on the blog.'
      redirect_to root_url
    end
  end

  # DELETE /announcements/1
  def destroy
    check_admin
    if @admin == true
      @announcement.destroy
      flash[:danger] = 'Announcement deleted.'
      redirect_to announcements_url
    else
      flash[:danger] = 'Only members of the Noodles team can delete posts on the blog.'
      redirect_to root_url
    end
  end

  private
    def check_admin
      if current_user && (current_user.id == 1 || current_user.id == 4)
        @admin = true
      else
        @admin = false
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

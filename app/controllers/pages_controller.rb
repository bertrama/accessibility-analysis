class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def new
  end

  def create
    @page = Page.new(page_params)
    @page.save
    redirect_to @page
  end

  def show
    @page = page_id
  end

  def edit
    @page = page_id
  end

  def update
    @page = page_id
    @page.update(page_params)
    redirect_to @page
  end

  def analyses
    @page = page_id
  end

  private
  def page_params
    params.require(:page).permit(:url)
  end

  def page_id
    Page.find(params[:id])
  end
end

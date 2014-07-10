class PagesController < ApplicationController
  layout "admin"
  def new
    @subjects = Subject.sorted
    @page = Page.new
    @page_count = Page.count + 1
  end

  def create
    @page = Page.new(page_params)
    if @page.save
    flash[:notice]="Page successfully created"
    redirect_to(:action =>'index')
    else
      @subjects = Subject.sorted
      @page_count = Page.count + 1
      render('new')
    end
  end

  def show
    @page = Page.find(params[:id])
  end

  def index
    @pages = Page.all
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    if @page.destroy
      flash[:notice] = "page #{@page.name} successfully deleted"
      redirect_to(:action => 'index', :id => @page.id)
    else
      redirect_to(:action => 'delete', :id => @page.id)
    end
  end


  def edit
     @subjects = Subject.all
     @page = Page.find(params[:id])
     @page_count = Page.count
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "page successfully updated"
      redirect_to(:action => 'show', :id => @page.id)
    else
      @subjects = Subject.all
      @page_count = Page.count
      render('edit')
    end
  end

  private
  def page_params
    params.require(:page).permit(:name, :position, :subject_id, :visible, :permalink)
  end
end

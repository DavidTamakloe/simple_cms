class SectionsController < ApplicationController
  layout "admin"
  def new
    @section = Section.new
    @section_count = Section.count + 1
    @pages = Page.all
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "section successfully created"
      redirect_to(:action => 'index')
    else
      @pages = Page.all
      @section_count = Section.count + 1
      render('new')
    end
  end

  def show
    @section= Section.find(params[:id]) 
  end

  def index
    @sections = Section.all
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    if @section.destroy
      flash[:notice] = "Section #{@section.name} successfully updated"
       redirect_to(:action => 'index', :id => @section.id)
    else
      redirect_to(:action => 'edit', :id => @section.id)
    end
  end

  def edit
    @pages = Page.all
    @section = Section.find(params[:id])
    @section_count = Section.count
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
       flash[:notice] = "Section successfully updated"
       redirect_to(:action => 'show', :id => @section.id)
    else
      @pages = Page.all
      @section_count = Section.count
      render('new')
    end

  end

private 
def section_params
  params.require(:section).permit(:name,:position,:page_id,:visible, :content_type, :content)
end

end

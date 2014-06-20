class DemoController < ApplicationController
  
  layout false

  def index
  	render("index.html.erb")
  end

  def hello
  	@array = [1, 2, 3, 4, 5]
  	@id = params[:id].to_i
  	@page = params["page"].to_i
  	render("hello.html.erb")

  end

  def other_hello
    redirect_to(:controller => 'demo', :action => 'index')
  end

end

class ContactController < ApplicationController

  def new
  end

  def create
    @name = params[:name]
    # render plain: "Thank you #{params[:name]} for contacting us"
    redirect_to contact_path({ name: params[:name] })
  end

end

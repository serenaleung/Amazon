class TagsController < ApplicationController
  def show
    @tag = Tag.find params[:id]
    @c = Tag.find @tag.id
  end
end

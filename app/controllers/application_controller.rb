class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def find_tags
    @tags = Tag.all
  end

  def find_post_by method
    @post = Post.available_for(current_user).send("by_#{method}", params)

    redirect_to root_path, alert: 'Post not find!' unless @post
  end
end

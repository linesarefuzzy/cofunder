class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_wordpress_template
    WordpressTemplate.update
    redirect_to root_path
  end
end

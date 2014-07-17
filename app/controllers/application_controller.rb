class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_template
    WordpressTemplate.update
    redirect_to root_path
  end
end

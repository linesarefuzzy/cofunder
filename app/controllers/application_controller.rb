class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_template
    WordpressTemplate.update(get_division_from_url)
    redirect_to root_path
  end

  def get_division_from_url
    @get_division_from_url ||= Rails.configuration.wordpress_template[:request_urls].select { |key, val| 
      request.url.match val 
    }.keys.first
  end
  helper_method :get_division_from_url

  def wordpress_layout
    "layouts/wordpress-#{get_division_from_url}"
  end
end

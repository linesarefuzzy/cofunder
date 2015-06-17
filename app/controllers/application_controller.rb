class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_template
    WordpressTemplate.update(get_division_from_url)
    redirect_to root_path
  end

  ## I18n
  LOCALE_MAP = {
    'theworkingworld.org' => :en,
    'labase.org' => 'es-AR',
  }

  before_filter :set_locale
  def set_locale
    I18n.locale = get_locale_from_domain || I18n.default_locale
  end

  def get_locale_from_domain
    LOCALE_MAP[request.host] || LOCALE_MAP.select { |host, locale| request.host.include? host }.values.first
  end
  ##
  
  def get_division_from_url
    @get_division_from_url ||= Rails.configuration.request_urls.select { |key, val| request.url.match val }.keys.first
  end
  helper_method :get_division_from_url

  def wordpress_layout
    "layouts/wordpress-#{get_division_from_url}"
  end
end

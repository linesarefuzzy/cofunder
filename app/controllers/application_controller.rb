class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_template
    WordpressTemplate.update
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
    LOCALE_MAP.select { |host, locale| request.host.include? host }.values.first
  end
  ##
end

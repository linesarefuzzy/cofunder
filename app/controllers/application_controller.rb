class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_template
    WordpressTemplate.update
    redirect_to root_path
  end

  ## I18n
  before_filter :set_locale

  def set_locale
    I18n.locale = get_locale_from_domain || I18n.default_locale
  end

  # Get locale from top-level domain or return nil if such locale is not available
  def get_locale_from_domain
    default_locale_map = {
      /theworkingworld\.org/ => :en,
      /labase\.org/ => :es,
    }
    default_locale = nil
    default_locale_map.each do |key, val|
      if request.host =~ key
        default_locale = val
        break
      end
    end
    default_locale
  end
  ##
end

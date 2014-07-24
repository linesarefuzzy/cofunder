module WordpressTemplate
  def self.update
    url = 'http://cfdev.theworkingworld.org/rails'
    file = File.join(Rails.root, 'app', 'views', 'layouts', 'wordpress.html.erb')
    substitutions = {
      '[rails_template]' => '<%= yield :title %>',
      '<!--[rails_head]-->' => '<%= yield :head %>',
      /<div [^>]*?post-content[^>]*?>.*?\[rails_content\].*?<\/div>/m => '<%= yield :content %>',
    }

    require 'open-uri'
    html = URI.parse(url).read
    substitutions.each do |key, val|
      html.gsub! key, val
    end

    File.open(file, 'w') { |f| f.write(html) }
  end
end

module WordpressTemplate
  def self.update
    url = 'http://cfdev.theworkingworld.org/rails'
    file = File.join(Rails.root, 'app', 'views', 'layouts', 'wordpress.html.erb')
    additional_substitutions = [
      [/<div class="post-content">(.*?)<\/div>/m, '\1']
    ]

    require 'open-uri'
    html = URI.parse(url).read
    html.gsub!(
      /(<!--\s*)?\[rails_(?<section>\w+?)\](.*\[\/rails_\k<section>\])?(\s*-->)?/m,
      '<%= yield :\k<section> %>'
    )
    additional_substitutions.each { |sub| html.gsub! *sub }
    File.open(file, 'w') { |f| f.write(html) }
  end
end

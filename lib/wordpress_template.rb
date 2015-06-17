module WordpressTemplate
  MAP = {
    development: {
      us: {
        # request_url: 'http://localhost:3000',
        template_url: 'http://localhost:8888/us-dev/rails',
      },
    },
    production: {
      us: {
        # request_url: 'http://cofunder.theworkingworld.org',
        template_url: 'http://www.theworkingworld.org/rails'
      },
      argentina: {
        template_url: 'http://labase.org/rails'
      },
    }
  }
  
  def self.update(division)
    template_url = MAP[Rails.env.to_sym][division][:template_url]
    file = File.join(Rails.root, 'app', 'views', 'layouts', "wordpress-#{division}.html.erb")
    additional_substitutions = [
      [/<div class="post-content">(.*?)<p>(.*?)<\/p>(.*?)<\/div>/m, '\1\2\3']
    ]

    require 'open-uri'
    html = URI.parse(template_url).read
    html.gsub!(
      /(<!--\s*)?\[rails_(?<section>[\w\-]+?)\](.*\[\/rails_\k<section>\])?(\s*-->)?/m,
      '<%= yield :\k<section> %>'
    )
    additional_substitutions.each { |sub| html.gsub! *sub }
    File.open(file, 'w') { |f| f.write(html) }
  end
end

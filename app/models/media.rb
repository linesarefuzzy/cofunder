class Media < ActiveRecord::Base
  include Legacy
  attr_accessible :ContextID, :ContextTable, :Description, :MediaPath, :MemberID, :Priority

  ImageRegex = /(jpe?g|gif|png|\]|\))$/i
  VideoRegex = /(mov|avi|wmv|mp4)$/i
  scope :type, ->(type) {
    case type
      when 'image'
        where("MediaPath REGEXP ?", ImageRegex.source)
      when 'video'
        where("MediaPath REGEXP ?", VideoRegex.source)
      when 'other'
        where("MediaPath NOT REGEXP ? AND MediaPath NOT REGEXP ?", ImageRegex.source, VideoRegex.source)
    end
  }
  def type
    if self.media_path =~ ImageRegex then 'image'
    elsif self.media_path =~ VideoRegex then 'video'
    else 'other' end
  end

  def path
    base_url = "http://www.theworkingworld.org/"
    return base_url + self.media_path
  end

  def paths
    path = self.path
    # insert various things into file name
    return {
      thumb: path.sub(/(\.[^.]+)$/, '.thumb\1'),
      small: path.sub(/(\.[^.]+)$/, '.small\1'),
      medium: path.sub(/(\.[^.]+)$/, '.medium\1'),
      large: path.sub(/(\.[^.]+)$/, '.large\1')
    }
  end
end

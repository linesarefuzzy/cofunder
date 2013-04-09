module MediaModule
  def get_picture_paths(table_name, id, limit=1, order_by='Priority, MediaPath')
    base_url = "http://www.theworkingworld.org/"
    
    images = Media.where(:ContextTable => table_name, :ContextID => id).order(order_by).limit(limit)
    return if images.empty?
    
    image_paths = []
    images.each do |image|
      path = base_url + image.MediaPath

      # insert various things into file name
      thumb = path.sub(/(\.[^.]+)$/, '.thumb\1')
      small = path.sub(/(\.[^.]+)$/, '.small\1')
      medium = path.sub(/(\.[^.]+)$/, '.medium\1')
      large = path.sub(/(\.[^.]+)$/, '.large\1')
      
      image_paths << {
        :full => path,
        :thumb => thumb,
        :small => small,
        :medium => medium,
        :large => large
      }
    end
    
    return image_paths
  end
end
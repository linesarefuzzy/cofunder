module MediaModule
  def get_picture_paths(table_name, id, order_by='Priority, MediaPath')
    base_url = "http://www.theworkingworld.org/"
    
    image = Media.where(:ContextTable => table_name, :ContextID => id).order(order_by).first
    return if !image
    path = base_url + image.MediaPath
    
    # insert various things into file name
    thumb = path.sub(/(\.[^.]+)$/, '.thumb\1')
    small = path.sub(/(\.[^.]+)$/, '.small\1')
    medium = path.sub(/(\.[^.]+)$/, '.medium\1')
    large = path.sub(/(\.[^.]+)$/, '.large\1')
    
    return {
      :full => path,
      :thumb => thumb,
      :small => small,
      :medium => medium,
      :large => large
    }
  end
end
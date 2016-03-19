module Admin::ItemsHelper
  def item_title
    action_name == "new" ? "新增商品" : "編輯商品"
  end

  def item_photo(photo, size = "large")    
    if photo.present?
      image_url = photo.image.send(size).url
    else
      case size
      when :large
        volume = "600x600"
      when :medium
        volume = "300x300"
      else
        volume = "150x150"
      end

      image_url = "http://placehold.it/#{volume}&text=No Pic"
    end

    image_tag(image_url, :class => "thumbnail")
  end
end
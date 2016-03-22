module Admin::ItemsHelper
  def item_title
    action_name == "new" ? "新增商品" : "編輯商品"
  end

  def item_photo(photo, size = nil)
    if photo.present?
      image_url = photo.image.send(size).url
    else
      case size
      when :large
        volume = "600x600"
      when :medium
        volume = "400x400"
      else
        volume = "150x150"
      end

      image_url = "http://placehold.it/#{volume}&text=No Pic"
    end

    image_tag(image_url, :class => "thumbnail")
  end

  def spec_photo(spec)
    if spec.style_pic.present?
      image_url = spec.style_pic.url
    else
      # case size
      # when :medium
      #   volume = "400x400"
      # else
      #   volume = "150x150"
      # end

      image_url = "http://placehold.it/150x150&text=No Pic"
    end

    image_tag(image_url, :class => "thumbnail")
  end

  def show_item_stock(amount)
    amount == 0 ? "無庫存" : amount
  end
end
module ApplicationHelper
   include Pagy::Frontend

   def link_to_image(image_path, target_link, image_options={}, options={})
    link_to(image_tag(image_path, image_options), target_link, options)
  end

end

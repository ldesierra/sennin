ActiveAdmin.register Product do
  permit_params :name, :description, :stock, :price,
                photos_attributes: [:id, :image, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :stock
    actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :description
      row :stock
      row :photos do |product|
        if product.photos.present?
          product.photos.each do |image|
            image_tag(image.image_url(:thumb), height: 100) if image.url.present?
          end
        else
          content_tag(:span, I18n.t('admin.products.no_portrait'))
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Product' do
      input :name
      input :description
      input :stock
      input :price
      f.has_many :photos, allow_destroy: true do |image_form, image_count|
        image_form.input :image,
                         as: :file,
                         hint:
                           if product.photos.present?
                             image_tag(product.photos[image_count - 1].image.url,
                                       height: 100)
                           else
                             content_tag(:span, I18n.t('admin.products.no_images'))
                           end

      end
    end
    actions
  end
end

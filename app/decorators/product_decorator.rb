class ProductDecorator < Draper::Decorator
  delegate_all

  def package_tag
    h.content_tag :span, h.fa_icon('plus-square-o'), rel: :tooltip, title: package_label, class: 'btn btn-sm btn-info package-price' if has_package_price?
  end

  def package_label
    "multiples of #{package_quantity}, #{h.number_to_currency package_price} each" if has_package_price?
  end

  def has_package_price?
    package_quantity && package_price
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end

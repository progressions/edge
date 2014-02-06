module CategoriesFromXml
  include ActiveSupport::Concern

  def category_names
    categories.pluck(:name)
  end

  def categories_from_xml=(values)
    values = Array(values)
    values.each do |value|
      category = Category.where(name: value).first || Category.new(name: value)
      categories << category unless categories.include?(category)
    end
  end
end

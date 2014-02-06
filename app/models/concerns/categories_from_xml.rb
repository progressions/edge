module CategoriesFromXml
  include ActiveSupport::Concern

  def categories_from_xml=(values)
    values = Array(values)
    values.each do |value|
      category = Category.where(name: value).first || Category.new(name: value)
      categories << category
    end
  end
end

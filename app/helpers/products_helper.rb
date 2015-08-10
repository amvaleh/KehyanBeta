module ProductsHelper

  def nested_children_product(cat)
    products = cat.products.includes(:default_image, :product_categories, :variants).root.active
    puts "***********************************************************************"
    puts cat.name.to_s
    if cat.children.any?
      cat.children.each do |ch|
       nested_children_product(ch)
      end
    end
    return render(:template =>"shared/_product_list.html.haml", :locals => { :products => products }).html_safe
  end
end

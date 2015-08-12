class ApplicationController < ActionController::Base
  require 'net/http'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def send_sms(to,message)
    result = Net::HTTP.get(URI.parse(URI.encode("http://ip.sms.ir/SendMessage.ashx?user=09361130770&pass=smspassword&lineNo=30004568976420&to=#{to}&text=#{message}")))
    return result
  end
  # Returns the active order for this session
  def current_order
    @current_order ||= begin
      if has_order?
        @current_order
      else
        order = Shoppe::Order.create(:ip_address => request.ip, :billing_country => Shoppe::Country.where(:name => "United Kingdom").first)
        session[:order_id] = order.id
        order
      end
    end
  end

  # Has an active order?
  def has_order?
    session[:order_id] && @current_order = Shoppe::Order.includes(:order_items => :ordered_item).find_by_id(session[:order_id])
  end

  helper_method :current_order, :has_order?

end

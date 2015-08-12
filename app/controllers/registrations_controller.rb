class RegistrationsController < Devise::RegistrationsController
  after_filter :send_welcome_sms , :only => :create

  protected

  def send_welcome_sms
    if resource.persisted? # user is created successfuly
      send_sms(resource.phone_number,"به سامانه قاصدک خوش آمدید.")
    end
 end
end

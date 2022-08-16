class ApplicationController < ActionController::Base

#before_action :authenticate_admin!

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      customers_my_page_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
        new_admin_session_path
    elsif resource == :customer
        root_path
    end
  end
end

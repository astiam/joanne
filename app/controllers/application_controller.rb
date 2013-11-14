class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_filter :configure_permitted_parameters, if: :devise_controller?

    def search_patients
       @p = Patient.search :load => true do
           query do
               string "Diego Peralta"
           end
       end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :firstname, :lastname, :email, :password, :password_confirmation, :remember_me) }
    end
end

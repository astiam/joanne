class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def search_patients
      @p = Patient.search :load => true do
          query do
              string "Diego Peralta"
          end
      end
  end
end

Joanette::Application.routes.draw do
    devise_for :users

    authenticate :user do
        root :to => "main#index", :as => "authenticated_root"

        get "users", :to => "users#index"
    end

    get 'main/autocomplete_patient_firstname'

    resources :patients do
        collection do
            delete 'bulk_action'
            post 'add_clinical_history'
        end
    end

    resources :reports
end

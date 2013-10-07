Joanette::Application.routes.draw do
    devise_for :users

    authenticate :user do
        root :to => "main#index", :as => "authenticated_root"

        get "users", :to => "users#index"
    end

    resources :patients do
        collection do
            delete 'bulk_action'
        end
    end
end

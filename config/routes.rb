Rails.application.routes.draw do
  scope '(:locale)', locale: /en|es/ do
    get 'home/greatings'
    namespace :v1, defaults: { format: 'json' } do
      resources :users, only: %i[create]
    end
  end
end

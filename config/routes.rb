Rails.application.routes.draw do
  scope '(:locale)', locale: /en|es/ do
    get 'home/greatings'
  end
end

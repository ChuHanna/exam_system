Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    devise_for :users, controllers: {sessions: "sessions"}
    resources :topics
    resources :questions
    resources :exams do
      resources :questions_exams, only: :create
    end
    resources :questions_exams
  end
end

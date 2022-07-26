Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#dashboard"

    devise_for :users, controllers: {sessions: "sessions"}
    resources :users
    resources :topics
    resources :questions
    resources :subjects
    resources :exams do
      resources :questions_exams, only: :create
    end
    resources :questions_exams
    resources :questions do
      collection {post :import}
    end
    resources :subject_topic, only: :index
    resources :records
  end
end

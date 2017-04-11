Rails.application.routes.draw do
  devise_for :lecturers
  devise_for :students
   root "home#home"

  namespace :student do
    resources :profiles
    resources :scores
    resources :curriculums
  end
end

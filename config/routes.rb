Rails.application.routes.draw do
  devise_for :lecturers
  devise_for :students
   root "home#home"

  namespace :student do
    resources :profiles
    resources :scores
    resources :curriculums
  end

  namespace :lecturer do
    resources :profiles
    resources :subjects
    resources :student_class_subjects
    resources :student_classes
    resources :class_subjects
    resources :scores
  end
end

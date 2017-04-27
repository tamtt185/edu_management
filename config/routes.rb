Rails.application.routes.draw do
  devise_for :lecturers, controllers: {sessions: "lecturer/sessions"}
  devise_for :students, controllers: {registrations: "registrations", sessions: "authentications"}
  root "home#index"

  namespace :student do
    resources :profiles
    resources :scores
    resources :curriculums
  end

  namespace :lecturer do
    get "/" => "home#index"
    resources :profiles
    resources :lecturer_subjects
    resources :student_class_subjects
    resources :student_classes
    resources :class_subjects
    resources :scores
  end

  namespace :admin do
    resources :subjects do 
      collection {post :import}
    end
    resources :students do 
      collection {post :import}
    end
    resources :lecturers do 
      collection {post :import}
    end
    resources :curriculums do
      resources :curriculum_subjects do
        collection {post :import}
      end
      collection {post :import}
    end
    resources :scores do 
      collection {post :import}
    end
    resources :class_subjects do
      collection {post :import}
    end
    resources :student_classes do
      collection {post :import}
    end
    resources :notices
  end
end

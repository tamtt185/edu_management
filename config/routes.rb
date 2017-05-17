Rails.application.routes.draw do
  devise_for :admins, controllers: {sessions: "admin/sessions"}
  devise_for :lecturers, controllers: {sessions: "lecturer/sessions"}
  devise_for :students, controllers: {sessions: "student/sessions"}
  root "student/sessions#new"
  
  devise_scope :student do 
    get "/sign_in" => "sessions_controller" 
  end
  namespace :student do
    resources :profiles
    resources :scores
    resources :curriculums
    resources :sessions
  end

  namespace :lecturer do
    get "/" => "sessions#new"
    resources :profiles
    resources :lecturer_subjects
    resources :student_classes
    resources :class_subjects do
      resources :scores
      resources :subject_scores do
        collection {get :scoring}
      end
    end
  end

  namespace :admin do
    get "/" => "profiles#index"
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
    resources :class_subjects do
      resources :scores do
        collection {get :scoring}
      end
      resources :student_class_subjects
      collection {post :import}
    end
    resources :student_classes do
      collection {post :import}
    end
    resources :notices
    resources :semesters
    resources :profiles
  end
end

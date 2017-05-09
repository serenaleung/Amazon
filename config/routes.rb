Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match "/delayed_job" => DelayedJobWeb, anchor: false, via: [:get, :post]

   get('/about', { to: 'about#index'} )
   get('/contact', {to: 'contact#index'})
   post('/contact', {to: 'contact#create', as: 'contact_submit'})

   resources :products do
     resources :reviews, only: [:create, :destroy]
   end

   resources :reviews, shallow: true do
     resources :likes, only: [:create, :destroy]
        resources :votes, only: [:create, :destroy, :update]
   end

   resources :tags, only: [:show]

#  (HTTP Verb: delete - path: /questions/:id ) ==> questions controller / destroy action
#  (HTTP Verb: get - path: /questions/:id/edit ) ==> questions controller / edit action
#  (HTTP Verb: get - path: /questions/:id ) ==> questions controller / show action
#  (HTTP Verb: post - path: /questions/:id/comments ) ==> comments controller / create action
#  (HTTP Verb: get - path: /faq ) ==> home controller / faq action

  #  delete('/questions/:id', {to: 'questions#destroy'})
  #  get('/questions/:id/edit', {to: 'questions#edit'})
  #  get('/questions/:id', {to: 'questions#show'})
  #  post('/questions/:id/comments', {to: 'comments#create'})
  #  get('/faq',{to: 'home#faq'})

  namespace :api, defaults: { format: :json } do
      	namespace :v1 do
      		# /api/v1/questions.json # => INDEX
            # /api/v1/questions/1.json # => SHOW
      		resources :products, only: [:index, :show, :create]
      	end
      end



  # resources :products
  resources :users, only: [:new, :create] do
    resources :likes, only: [:index]
  end

  # prevents password to show in address bar
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  root 'welcome#index'
end

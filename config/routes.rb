Rails.application.routes.draw do
  root 'messages#index'
  get 'messages/index'
  resource :messages do
    collection do
      post 'send_sms'
      post 'reply'
    end
  end

end

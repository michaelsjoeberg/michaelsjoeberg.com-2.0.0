Rails.application.routes.draw do
    #root to: "pages#home"
    get "/"                                     => "pages#home", as: "home"
    #get "/programming"                          => "pages#programming", as: "programming"
    #get '/programming/:category/:group'         => 'pages#programming', as: "group"
    #get '/programming/:category/:group/:file'   => 'pages#programming', as: "file"
    get "/technical-notes"                          => "pages#programming", as: "programming"
    get '/technical-notes/:category/:group/:file'   => 'pages#programming', as: "file"
    get "/projects"                             => "pages#projects", as: "projects"
    #get "/consulting"                           => "pages#consulting", as: "consulting"
    get "/about"                                => "pages#about", as: "about"
    get "/posts"                                => "pages#posts", as: "posts"
    get "/posts/:post"                          => "pages#posts", as: "post"
end

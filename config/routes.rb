Rails.application.routes.draw do
    #root to: "pages#home"
    get "/"                                             => "pages#home", as: "home"
    get "/technical-notes"                              => "pages#programming", as: "programming"
    get "/technical-notes/:category/:group/:file"       => 'pages#programming', as: "file"
    get "/projects"                                     => "pages#projects", as: "projects"
    get "/about"                                        => "pages#about", as: "about"
    get "/posts"                                        => "pages#posts", as: "posts"
    get "/posts/:post"                                  => "pages#posts", as: "post"
    get "/activity"                                     => "pages#activity", as: "activity"
end

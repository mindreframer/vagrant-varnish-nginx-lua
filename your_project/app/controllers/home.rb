YourProject::App.controllers :home do

  get :index do
    render 'home/index'
  end

  get :esi do
    "esi content, wowowo"
  end
end

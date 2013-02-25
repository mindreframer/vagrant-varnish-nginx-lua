YourProject::App.controllers :mem do

  get :index do
    key = env["REQUEST_URI"]
    CACHE.set(key, "something")
    env["REQUEST_URI"] + "\n"
  end
end

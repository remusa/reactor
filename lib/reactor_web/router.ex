defmodule ReactorWeb.Router do
  use ReactorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ReactorWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ReactorWeb do
    pipe_through :browser

    live "/users", UserLive.Index, layout: {ReactorWeb.LayoutView, :root}
    live "/users/new", UserLive.New, layout: {ReactorWeb.LayoutView, :root}
    live "/users/:id", UserLive.Show, layout: {ReactorWeb.LayoutView, :root}
    live "/users/:id/edit", UserLive.Edit, layout: {ReactorWeb.LayoutView, :root}

    get("/forgot", SessionController, :forgot)
    get("/login", SessionController, :new)
    get("/login/:token/email/:email", SessionController, :create_from_email)
    get("/logout", SessionController, :delete)
    get("/forgot", SessionController, :reset_pass)

    resources(
      "/sessions",
      SessionController,
      only: [:new, :create, :delete],
      singleton: true
    )

    resources "/users", UserController
    resources "/podcasts", PodcastController
    resources "/comments", CommentController

    live "/", PageLive, :index
    live "/foo", FooLive, layout: {ReactorWeb.LayoutView, :root}
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReactorWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ReactorWeb.Telemetry
    end
  end
end

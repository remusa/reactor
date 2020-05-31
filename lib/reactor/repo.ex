defmodule Reactor.Repo do
  use Ecto.Repo,
    otp_app: :reactor,
    adapter: Ecto.Adapters.Postgres
end

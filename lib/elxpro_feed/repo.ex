defmodule ElxproFeed.Repo do
  use Ecto.Repo,
    otp_app: :elxpro_feed,
    adapter: Ecto.Adapters.Postgres
end

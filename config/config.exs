# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :metro,
  ecto_repos: [Metro.Repo]

# Configures the endpoint
config :metro, Metro.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qPjLj9vMp0PDwhwqCs75FVGdQDzhti0oOVdzsQkxhknZR+36cXUEfnzRHVWoeCJU",
  render_errors: [view: Metro.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Metro.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Uberauth config
config :ueberauth, Ueberauth,
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"]
    ]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

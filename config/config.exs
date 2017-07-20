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

# Ueberauth config
config :ueberauth, Ueberauth,
  base_path: "/",
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      request_path: "",
      callback_path: "",
      callback_methods: ["POST"],
      uid_field: :email,
      nickname_field: :email
    ]}
  ]

# Guardian config
config :guardian, Guardian,
  issuer: "Metro",
  ttl: { 30, :days },
  allowed_drift: 2000,
  secret_key: "J1debCKFp5ahjLSQIKouXC5Tr4lBy+Z7xDk90x4QO1L2pxsoAmDO48X659Td0Bfa",
  serializer: Metro.GuardianSerializer

# Drab config
config :phoenix, :template_engines,
  drab: Drab.Live.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :metro, Metro.Web.Endpoint,
  http: [port: 4001],
  server: true

# For Wallaby features tests
config :metro, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

import_config "test.secret.exs"

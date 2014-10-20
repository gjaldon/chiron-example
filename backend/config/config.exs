# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the router
config :phoenix, Chiron.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "HrZv92nXjB1dt2eAVyzYTxTpADJxRrnX6jbznnD8Bi/HXdni9U56atwI9KRUDjBSMT7Gwcg8Q4WUih+Jk/uLmg==",
  catch_errors: true,
  debug_errors: false,
  error_controller: Chiron.PageController

# Session configuration
config :phoenix, Chiron.Router,
  session: [store: :cookie,
            key: "_chiron_key"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

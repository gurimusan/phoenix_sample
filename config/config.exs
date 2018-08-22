# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_sample,
  ecto_repos: [PhoenixSample.Repo]

# Configures the endpoint
config :phoenix_sample, PhoenixSample.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Tts2lnToCfsUmuQUFoItzGi1dqhA39zsmPXgluV7DaA7ebeCcLSPbuxqTnpV5GKQ",
  render_errors: [view: PhoenixSample.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixSample.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :phoenix_sample, PhoenixSample.Guardian,
  issuer: "phoenix_sample",
  allowed_algos: ["HS512"],
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "fkSAv00455eZFP+fKW0dhSpN3D27Wb/wouf2mCThHTZhHi5JFVv0Agdi1z9kmT6k"

config :phoenix_sample, PhoenixSample.AuthAccessPipline,
  module: PhoenixSample.Guardian,
  error_handler: PhoenixSample.AuthErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

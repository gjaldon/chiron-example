use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :phoenix, Chiron.Router,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "HrZv92nXjB1dt2eAVyzYTxTpADJxRrnX6jbznnD8Bi/HXdni9U56atwI9KRUDjBSMT7Gwcg8Q4WUih+Jk/uLmg=="

config :logger, :console,
  level: :info

defmodule Chiron do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    setup_ets_table
    Chiron.Patient.setup()

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Chiron.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chiron.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # TODO: tests for host_url/0 and api_origin/0
  def host_url do
    [{"couch_host", url}] = :ets.lookup(:chiron_registry, "couch_host")
    url
  end

  def api_origin do
    case Mix.env do
      :dev -> "*"
      _ ->
        [{"api_origin", origin}] = :ets.lookup(:chiron_registry, "api_origin")
        origin
    end
  end

  defp setup_ets_table do
    :ets.new(:chiron_registry, [:named_table, :set, :protected])
    store_couch_host_url
    store_api_origin
  end

  defp store_couch_host_url do
    host = System.get_env("COUCH_DB_HOST") || "http://127.0.0.1:5984"
    :ets.insert(:chiron_registry, {"couch_host", host})
  end

  defp store_api_origin do
    api_origin = System.get_env("API_ORIGIN") || "http://127.0.0.1:8080"
    :ets.insert(:chiron_registry, {"api_origin", api_origin})
  end
end

defmodule Chiron do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    setup_ets_table
    store_couch_host_url

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Chiron.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chiron.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def host_url do
    [{"couch_host", url}] = :ets.lookup(:chiron_registry, "couch_host")
    url
  end

  defp setup_ets_table do
    :ets.new(:chiron_registry, [:named_table, :set, :protected])
  end

  defp store_couch_host_url do
    host = System.get_env("COUCH_DB_HOST") || "http://127.0.0.1:5984"
    :ets.insert(:chiron_registry, {"couch_host", host})
  end
end

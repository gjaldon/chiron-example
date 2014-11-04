defmodule Chiron do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

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

  def config(name) do
    Application.get_env(:chiron, name)
  end

  def host_url do
    config(:couchdb_host)
  end

  def api_origin do
    config(:api_origin)
  end
end

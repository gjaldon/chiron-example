defmodule Chiron.Router do
  use Phoenix.Router

  # TODO: Test for api pipeline or cors plug
  pipeline :api do
    plug :cors
  end

  scope "/api", alias: Chiron do
    pipe_through :api

    resources "/patients", PatientController
  end

  def cors(conn, []) do
    register_before_send(conn, fn (conn) ->
      put_resp_header conn, "access-control-allow-origin", Chiron.api_origin
    end)
  end
end

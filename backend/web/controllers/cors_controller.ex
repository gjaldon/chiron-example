defmodule Chiron.CorsController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    conn
    |> put_resp_header("access-control-allow-headers", "if-match, content-type")
    |> put_resp_header("access-control-allow-methods", "POST, DELETE, GET, PUT")
    |> put_resp_header("access-control-max-age", "1728000")
    |> text(200, "Accepted")
  end
end

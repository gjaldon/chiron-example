defmodule Chiron.PatientController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    json conn, User.all
  end

  def create(conn, params) do
    status = case User.create(params) do
      %{"ok" => true} ->
        200
      _ ->
        500
    end
    json conn, status, ""
  end
end

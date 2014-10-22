defmodule Chiron.PatientController do
  use Phoenix.Controller
  alias Chiron.Repo

  plug :action

  def index(conn, _params) do
    json conn, User.all
  end
end

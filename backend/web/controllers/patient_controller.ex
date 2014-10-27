defmodule Chiron.PatientController do
  use Phoenix.Controller
  alias Chiron.Patient

  plug :action

  def index(conn, _params) do
    json conn, Patient.all
  end

  def create(conn, params) do
    status = case Patient.create(params) do
      %{"ok" => true} ->
        200
      _ ->
        500
    end
    json conn, status, ""
  end
end

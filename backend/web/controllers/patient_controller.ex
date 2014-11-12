defmodule Chiron.PatientController do
  use Phoenix.Controller
  alias Chiron.Patient

  plug :action

  def index(conn, _params) do
    json conn, Patient.all
  end

  def create(conn, params) do
    {status, response} = Patient.create(params)
    json conn, status, response
  end

  def destroy(conn, %{"id" => id}) do
    rev = get_req_header(conn, "if-match")
    {status, response} = Patient.destroy(id, rev)
    json conn, status, response
  end

  def update(conn, params) do
    {status, response} = Patient.update(params)
    json conn, status, response
  end
end

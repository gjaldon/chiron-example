defmodule Chiron.Repo do
  use Timex
  import Chiron
  alias HTTPoison, as: HTTP
  alias Poison, as: JSON
  alias HTTPoison.Response

  def all_docs(database) do
    %Response{body: body} = HTTP.get! "#{host_url}/#{database}/_all_docs"
    body
  end

  def create_doc(database, map) do
    now = DateFormat.format! Date.now, "{RFC1123}"
    body = Dict.merge(map, %{created_at: now, updated_at: now}) |> JSON.encode!
    header = [{"Content-Type", "application/json"}]
    %Response{body: body} = HTTP.put! "#{host_url}/#{database}", body, header
    body
  end

  @doc """
  Creates a design doc in the specified database.

  The `doc_name` param is expected to follow the format: %{fun_name: map: fun_binary}
  """
  def create_design_doc(database, doc_name, funs, lang \\ "erlang") do
    body = %{language: lang, views: funs} |> JSON.encode!
    header = [{"Content-Type", "application/json"}]
    url = "#{host_url}/#{database}/_design/#{doc_name}"
    %Response{body: body} = HTTP.put! url, body, header
    body
  end
end

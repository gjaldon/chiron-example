defmodule Chiron.Patient do
  import Chiron
  alias HTTPoison, as: HTTP
  alias Poison, as: JSON
  alias HTTPoison.Response
  alias Chiron.Repo

  @db_name "patients"

  def create(map) do
    Repo.create_doc(@db_name, map)
  end

  def destroy(id, rev) do
    Repo.destroy_doc(@db_name, id, rev)
  end

  def update(map) do
    Repo.update_doc(@db_name, map)
  end

  # TODO: tests for all funcs here
  def all(number \\ 10, options \\ []) do
    query_string = Enum.reduce(options, "",fn ({key, value}, query_string) ->
      query_string <> "&#{key}=#{value}"
    end)
    url = "#{host_url}/patients/_design/admin/_view/all?limit=#{number}#{query_string}"
    %Response{body: body} = HTTP.get! url
    body
  end

  def setup do
    create_db()
    create_all_design_doc()
  end

  defp create_db do
    Repo.create_db(@db_name)
  end

  defp create_all_design_doc do
    fun = """
    fun({Doc}) ->
      Name = proplists:get_value(<<"name">>, Doc, null),
      case Name of
        null -> null;
        Key -> Emit(Key, {Doc})
      end
    end.
    """
    map = %{all: %{map: fun}}
    Repo.create_design_doc(@db_name, "admin", map)
  end
end

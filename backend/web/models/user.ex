defmodule User do
  import Chiron
  alias HTTPoison, as: HTTP
  alias Poison, as: JSON
  alias HTTPoison.Response

  # TODO: tests for all funcs here
  def all(number \\ 10, options \\ []) do
    query_string = Enum.reduce(options, "",fn ({key, value}, query_string) ->
      query_string <> "&#{key}=#{value}"
    end)
    url = "#{host_url}/users/_design/admin/_view/all?limit=#{number}#{query_string}"
    %Response{body: body} = HTTP.get! url
    body
  end

  def create_all_design_doc do
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
    Repo.create_design_doc("users", "admin", map)
  end
end

defmodule User do
  import Chiron
  alias HTTPoison, as: HTTP
  alias Poison, as: JSON
  alias HTTPoison.Response

  def all(number \\ 10, options \\ []) do
    query_string = Enum.reduce(options, "",fn ({key, value}, query_string) ->
      query_string <> "&#{key}=#{value}"
    end)
    url = "#{host_url}/users/_design/admin/_view/all?limit=#{number}#{query_string}"
    %Response{body: body} = HTTP.get! url
    JSON.decode! body
  end

  def create_all_design_doc do
    fun = """
          fun({Doc}) ->
            LastName = proplists:get_value(<<"last_name">>, Doc, null),
            FirstName = proplists:get_value(<<"first_name">>, Doc, null),
            case [LastName, FirstName] of
              [null, null] -> null;
              Key -> Emit([LastName, FirstName], {Doc})
            end
          end.
          """
    map = %{all: %{map: fun}}
    Repo.create_design_doc("users", "admin", map)
  end
end

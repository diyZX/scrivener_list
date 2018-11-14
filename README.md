# Scrivener.List [![Build Status](https://travis-ci.org/stephenmoloney/scrivener_list.svg)](https://travis-ci.org/stephenmoloney/scrivener_list) [![Hex Version](http://img.shields.io/hexpm/v/scrivener_list.svg?style=flat)](https://hex.pm/packages/scrivener_list) [![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/scrivener_list)

[Scrivener.List](https://hex.pm/packages/scrivener_list) is a Scrivener compatible extension that
allows the pagination of a list of elements.

## Features 

  - Scrivener.List extends the protocol `Scrivener.Paginater.paginate/2` from the [scrivener](https://github.com/drewolson/scrivener) library.
    
## Usage

### Function 

```Scrivener.paginate(list, config)```

### Arguments

- ```list```: A list of elements to be paginated
- ```config```: A configuration object with the pagination details. Can be in any of the following formats:
     - ```%{page: page_number, page_size: page_size}``` (map)
     - ```[page: page_number, page_size: page_size]``` (Keyword.t)
     - ```%Scrivener.Config{page_number: page_number, page_size: page_size}``` (Scrivener.Config.t)

`max_page_size` **cannot** be configured with method 1.

### Examples

```elixir
def index(conn, params) do
  config = maybe_put_default_config(params)

  page =
    ["C#", "C++", "Clojure", "Elixir", "Erlang", "Go", "JAVA", "JavaScript", "Lisp",
      "PHP", "Perl", "Python", "Ruby", "Rust", "SQL"]
    |> Enum.map(&(&1 <> "  " <> "language"))
    |> Scrivener.paginate(config)

  render conn, :index,
    people: page.entries,
    page_number: page.page_number,
    page_size: page.page_size,
    total_pages: page.total_pages,
    total_entries: page.total_entries
end

defp maybe_put_default_config(%{page: page_number, page_size: page_size} = params), do: params
defp maybe_put_default_config(_params), do: %Scrivener.Config{page_number: 1, page_size: 10}
```

```elixir  
list = ["C#", "C++", "Clojure", "Elixir", "Erlang", "Go", "JAVA", "JavaScript", "Lisp",
        "PHP", "Perl", "Python", "Ruby", "Rust", "SQL"]
        
Scrivener.paginate(list, %Scrivener.Config{page_number: 1, page_size: 4}) # %Scrivener.Config{}
Scrivener.paginate(list, page: 1, page_size: 4) # keyword list
Scrivener.paginate(%{page: 1, page_size: 4}) # map
Scrivener.paginate(%{page: 1}) # map with only page number (page_size defaults to 10)
```

## Installation

Add [scrivener_list](https://hex.pm/packages/scrivener_list) to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:scrivener_list, "~> 1.0"}
  ]
end
```

## Tests

```shell
mix test
```

## Acknowledgements

Thanks to [Drew Olson](https://github.com/drewolson) for helping with this, particularly the introduction of the [protocol](http://blog.drewolson.org/extensible-design-with-protocols/).

## Licence

MIT

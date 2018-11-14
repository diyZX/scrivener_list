defimpl Scrivener.Paginater, for: List do
  alias Scrivener.Config
  alias Scrivener.Page

  @doc ~s"""
  Implementation of `Scrivener.Paginater` protocol to extend the `Scrivener.Paginater.paginate/2` function.
  """
  @spec paginate(any, map | Keyword.t) :: Scrivener.Page.t
  def paginate(entries, %Config{page_number: page_number, page_size: page_size}) do
      total_entries = length(entries)

      %Page{
        page_size: page_size,
        page_number: page_number,
        entries: entries(entries, page_number, page_size),
        total_entries: total_entries,
        total_pages: total_pages(total_entries, page_size)
      }
  end

  defp entries(entries, page_number, page_size) do
    offset = page_size * (page_number - 1)
    Enum.slice(entries, offset, page_size)
  end

  defp total_pages(0, _), do: 1
  defp total_pages(total_entries, page_size) do
    (total_entries / page_size) |> Float.ceil() |> round
  end
end

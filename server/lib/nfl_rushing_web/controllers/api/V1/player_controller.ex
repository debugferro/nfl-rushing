defmodule NflRushingWeb.Api.V1.PlayerController do
  alias NflRushing.{Player, Player.CSVBuilder}
  use NflRushingWeb, :controller

  def index(conn, params) do
    rushings = request_data(params)
    render(conn, "rushings.json", rushings: rushings)
  end

  def download_csv(conn, params) do
    csv_file = request_data(params) |> CSVBuilder.write()
    send_download(conn, {:binary, csv_file}, content_type: "text/csv", filename: "rushing-statistics.csv")
  end

  defp request_data(%{"sort_by" => sort_args, "q" => search_term}), do: Player.search_by_name(search_term, sort_args)
  defp request_data(%{"sort_by" => sort_args}), do: Player.get_rushing_ordered_by(sort_args)
  defp request_data(%{"q" => search_term}), do: Player.search_by_name(search_term)
  defp request_data(_params), do: Player.get_all()
end

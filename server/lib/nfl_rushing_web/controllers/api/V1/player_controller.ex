defmodule NflRushingWeb.Api.V1.PlayerController do
  alias NflRushing.{Player, Player.Rushing, Repo}
  use NflRushingWeb, :controller

  def index(conn, %{"sort_by" => sort_arg}) do
    IO.inspect(sort_arg)
    rushings = Player.get_rushing_ordered_by(sort_arg)
    render(conn, "rushings.json", rushings: rushings)
  end

  def index(conn, %{"q" => searched_name}) do
    rushings = Player.search_by_name(searched_name)
    render(conn, "rushings.json", rushings: rushings)
  end

  def index(conn, params) do
    IO.inspect(params)
    render(conn, "rushings.json", rushings: Repo.all(Rushing))
  end
end

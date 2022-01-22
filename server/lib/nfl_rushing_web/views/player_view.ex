defmodule NflRushingWeb.Api.V1.PlayerView do
  use NflRushingWeb, :view
  alias NflRushing.Player

  def render("rushings.json", %{rushings: {columns, rows}}) do
    %{columns: columns, rows: rows}
  end

  def render("rushings.json", %{rushings: rushings}) do
    %{rushings: render_many(rushings, NflRushingWeb.Api.V1.PlayerView, "rushing.json", as: :rushing)}
  end

  def render("rushing.json", %{rushing: rushing}) do
    %{
      "id" => rushing.id,
      "player" => rushing.player,
      "team" => rushing.team,
      "pos" => rushing.pos,
      "attempts_avg" => rushing.attempts_avg,
      "attempts" => rushing.attempts,
      "total_yards" => rushing.total_yards,
      "yards_per_att" => rushing.yards_per_att,
      "yards_per_game" => rushing.yards_per_game,
      "total_touchdowns" => rushing.total_touchdowns,
      "longest_rush" => rushing.longest_rush,
      "longest_rush_td" => rushing.longest_rush_td |> Player.parse_longest_rush_td(),
      "first_downs" => rushing.first_downs,
      "first_downs_pct" => rushing.first_downs_pct,
      "twenty_yards_plus" => rushing.twenty_yards_plus,
      "forty_yards_plus" => rushing.forty_yards_plus,
      "fumbles" => rushing.fumbles
    }
  end
end

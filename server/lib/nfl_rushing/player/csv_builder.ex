defmodule NflRushing.Player.CSVBuilder do
  alias NflRushing.Player

  @fields_name [
    "Player Name",
    "Team",
    "Position",
    "Attempts",
    "Attempts Avg.",
    "Total Rushing Yards",
    "Avg. Yards per Attempt",
    "Yards per Game",
    "Total Touchdowns",
    "Longest Rush",
    "Longest Rush Touchdown",
    "1st Downs",
    "1st Downs %",
    "20+ Yards",
    "40+ Yards",
    "Fumbles"
  ]

  def write(player_rushings) do
    player_rushings
    |> build_csv_list
    |> write_file
  end

  defp build_csv_list(player_rushings) do
    values =
      Enum.map(player_rushings, fn data ->
        [
          data.player,
          data.team,
          data.pos,
          data.attempts,
          data.attempts_avg,
          data.total_yards,
          data.yards_per_att,
          data.yards_per_game,
          data.total_touchdowns,
          data.longest_rush,
          data.longest_rush_td |> Player.parse_longest_rush_td(),
          data.first_downs,
          data.first_downs_pct,
          data.twenty_yards_plus,
          data.forty_yards_plus,
          data.fumbles
        ]
      end)

    [@fields_name] ++ values
  end

  defp write_file(csv_data) do
    NimbleCSV.RFC4180.dump_to_iodata(csv_data)
  end
end

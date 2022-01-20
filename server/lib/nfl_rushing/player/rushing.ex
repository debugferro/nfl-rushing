defmodule NflRushing.Player.Rushing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_rushings" do
    field(:attempts, :integer)
    field(:attempts_avg, :float)
    field(:first_downs, :integer)
    field(:first_downs_pct, :float)
    field(:forty_yards_plus, :integer)
    field(:fumbles, :integer)
    field(:longest_rush, :integer)
    field(:longest_rush_td, :boolean, default: false)
    field(:player, :string)
    field(:pos, :string)
    field(:team, :string)
    field(:total_touchdowns, :integer)
    field(:total_yards, :integer)
    field(:twenty_yards_plus, :integer)
    field(:yards_per_att, :float)
    field(:yards_per_game, :float)

    timestamps()
  end

  @doc false
  def changeset(rushing, attrs) do
    rushing
    |> cast(attrs, [
      :player,
      :team,
      :pos,
      :attempts_avg,
      :attempts,
      :total_yards,
      :yards_per_att,
      :yards_per_game,
      :total_touchdowns,
      :longest_rush,
      :longest_rush_td,
      :first_downs,
      :first_downs_pct,
      :twenty_yards_plus,
      :forty_yards_plus,
      :fumbles
    ])
    |> validate_required([
      :player,
      :team,
      :pos,
      :attempts_avg,
      :attempts,
      :total_yards,
      :yards_per_att,
      :yards_per_game,
      :total_touchdowns,
      :longest_rush,
      :longest_rush_td,
      :first_downs,
      :first_downs_pct,
      :twenty_yards_plus,
      :forty_yards_plus,
      :fumbles
    ])
  end

  def map(data) do
    {longest_rush, longest_rush_td} = parse_longest_rush(data["Lng"])

    %{
      "player" => data["Player"],
      "team" => data["Team"],
      "pos" => data["Pos"],
      "attempts_avg" => data["Att/G"],
      "attempts" => data["Att"],
      "total_yards" => parse_yards(data["Yds"]),
      "yards_per_att" => data["Avg"],
      "yards_per_game" => data["Yds/G"],
      "total_touchdowns" => data["TD"],
      "longest_rush" => longest_rush,
      "longest_rush_td" => longest_rush_td,
      "first_downs" => data["1st"],
      "first_downs_pct" => data["1st%"],
      "twenty_yards_plus" => data["20+"],
      "forty_yards_plus" => data["40+"],
      "fumbles" => data["FUM"]
    }
  end

  defp parse_longest_rush(longest_rush) when is_bitstring(longest_rush) do
    with true <- String.contains?(longest_rush, "T") do
      {String.replace(longest_rush, "T", ""), true}
    else
      _ -> {longest_rush, false}
    end
  end

  defp parse_longest_rush(longest_rush), do: {longest_rush, false}

  defp parse_yards(yards) when is_bitstring(yards), do: String.replace(yards, ",", "")
  defp parse_yards(yards), do: yards

end

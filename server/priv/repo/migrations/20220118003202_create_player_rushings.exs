defmodule NflRushing.Repo.Migrations.CreatePlayerRushings do
  use Ecto.Migration

  def change do
    create table(:player_rushings) do
      add :player, :string
      add :team, :string
      add :pos, :string
      add :attempts_avg, :float
      add :attempts, :integer
      add :total_yards, :integer
      add :yards_per_att, :float
      add :yards_per_game, :float
      add :total_touchdowns, :integer
      add :longest_rush, :integer
      add :longest_rush_td, :boolean, default: false, null: false
      add :first_downs, :integer
      add :first_downs_pct, :float
      add :twenty_yards_plus, :integer
      add :forty_yards_plus, :integer
      add :fumbles, :integer

      timestamps()
    end

  end
end

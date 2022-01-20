defmodule NflRushing.Repo.Migrations.AddPlayerNameTrgmIndex do
  use Ecto.Migration

  def up do
    execute "CREATE INDEX rushings_player_trgm_index ON player_rushings USING gin (player gin_trgm_ops);"
  end

  def down do
    execute "DROP INDEX rushings_player_trgm_index;"
  end
end

defmodule NflRushing.Repo.Migrations.AddPgSearch do
  use Ecto.Migration

  def up do
    execute "CREATE extension if not exists pg_trgm;"
  end

  def down do
    execute "DROP extension pg_trgm;"
  end
end

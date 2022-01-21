# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflRushing.Repo.insert!(%NflRushing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias NflRushing.Player.Rushing
alias NflRushing.Repo

Path.expand("./priv/repo/rushing.json")
|> File.read!
|> IO.inspect
|> Jason.decode!
|> IO.inspect
|> Task.async_stream(fn rushing ->
  %Rushing{}
  |> Rushing.changeset(Rushing.map(rushing))
  |> Repo.insert!
end)
|> Stream.run

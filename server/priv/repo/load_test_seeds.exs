# Seed to test system capability for larger sets of data

alias NflRushing.Player.Rushing
alias NflRushing.Repo

Faker.start()

Enum.each(0..10_000, fn _ ->
  Repo.insert!(%Rushing{
    attempts: 1,
    attempts_avg: 0.1,
    first_downs: 0,
    first_downs_pct: 0.0,
    forty_yards_plus: 0,
    fumbles: 0,
    longest_rush: 2,
    longest_rush_td: false,
    player: Faker.Person.first_name() <> " " <> Faker.Person.last_name(),
    pos: "WR",
    team: "BAL",
    total_touchdowns: Enum.random(0..30),
    total_yards: 2,
    twenty_yards_plus: 0,
    yards_per_att: 2.0,
    yards_per_game: 0.1
  })
end)

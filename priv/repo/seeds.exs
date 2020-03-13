# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Notifier.Repo.insert!(%Notifier.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

now = NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)
columns = [
  [name: "TODO", inserted_at: now, updated_at: now],
  [name: "Doing", inserted_at: now, updated_at: now],
  [name: "Test", inserted_at: now, updated_at: now],
  [name: "QA", inserted_at: now, updated_at: now],
  [name: "Done", inserted_at: now, updated_at: now]
]

Notifier.Repo.insert_all(Notifier.Board.Column, columns)

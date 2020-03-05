defmodule Notifier.Repo.Migrations.AddDefaultColumn do
  use Ecto.Migration

  def up do
    Notifier.Repo.insert!(%Notifier.Board.Column{id: 1, name: "Backlog"})
  end

  def down do
    Notifier.Repo.delete!(%Notifier.Board.Column{id: 1, name: "Backlog"})
  end
end

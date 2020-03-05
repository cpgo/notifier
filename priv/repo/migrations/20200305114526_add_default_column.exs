defmodule Notifier.Repo.Migrations.AddDefaultColumn do
  use Ecto.Migration

  def up do
    Notifier.Repo.insert!(%Notifier.Board.Column{name: "Backlog"})
  end

  def down do
    Notifier.Repo.delete!(%Notifier.Board.Column{name: "Backlog"})
  end
end

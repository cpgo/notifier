defmodule Notifier.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :body, :string
      add :column_id, references(:columns), null: false, default: 1
      timestamps()
    end
  end
end

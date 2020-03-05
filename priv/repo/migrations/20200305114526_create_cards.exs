defmodule Notifier.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :body, :string
      add :column_id, references(:columns), null: true
      timestamps()
    end

    create unique_index(:cards, [:column_id])
  end
end

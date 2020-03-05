defmodule Notifier.Repo.Migrations.CreateColumns do
  use Ecto.Migration

  def change do
    create table(:columns) do
      add :name, :string

      timestamps()
    end

  end
end

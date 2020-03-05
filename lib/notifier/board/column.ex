defmodule Notifier.Board.Column do
  use Ecto.Schema
  import Ecto.Changeset

  schema "columns" do
    field :name, :string
    has_many :cards, Notifier.Board.Card
    timestamps()
  end

  @doc false
  def changeset(column, attrs) do
    column
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

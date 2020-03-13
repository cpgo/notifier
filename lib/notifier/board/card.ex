defmodule Notifier.Board.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :body, :string
    belongs_to :column, Notifier.Board.Column
    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:body, :column_id])
    |> cast_assoc(:column)
    |> validate_required([:body])
  end
end


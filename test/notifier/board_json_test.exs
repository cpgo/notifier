defmodule Notifier.BoardJsonTest do
  use Notifier.DataCase

  alias Notifier.Board

  describe "cards" do
    alias Notifier.Board.Card

    @valid_column_attrs %{name: "TODO", id: 123}
    @valid_attrs %{body: "some body", column_id: 123}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Board.create_card()

      card
    end

    def column_fixture(attrs \\ %{}) do
      {:ok, column} =
        attrs
        |> Enum.into(@valid_column_attrs)
        |> Board.create_column()
      column
    end

    test "list_cards/0 returns all cards" do
      column = column_fixture()
      card = card_fixture(%{column_id: column.id})
      assert Board.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      column = column_fixture()
      card = card_fixture(%{column_id: column.id})
      assert Board.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      column = column_fixture()
      assert {:ok, %Card{} = card} = Board.create_card(%{body: "some body", column_id: column.id})
      assert card.body == "some body"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Board.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      column = column_fixture()
      card = card_fixture(%{column_id: column.id})
      assert {:ok, %Card{} = card} = Board.update_card(card, @update_attrs)
      assert card.body == "some updated body"
    end

    test "update_card/2 with invalid data returns error changeset" do
      column = column_fixture()
      card = card_fixture(%{column_id: column.id})
      assert {:error, %Ecto.Changeset{}} = Board.update_card(card, @invalid_attrs)
      assert card == Board.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      column = column_fixture()
      card = card_fixture(%{column_id: column.id})
      assert {:ok, %Card{}} = Board.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Board.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      column = column_fixture()
      card = card_fixture(%{column_id: column.id})
      assert %Ecto.Changeset{} = Board.change_card(card)
    end
  end
end

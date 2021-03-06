defmodule Notifier.BoardTest do
  use Notifier.DataCase

  alias Notifier.Board

  describe "cards" do
    alias Notifier.Board.Card

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Board.create_card()

      card
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
      assert {:ok, %Card{} = card} = Board.create_card(@valid_attrs)
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

  describe "columns" do
    alias Notifier.Board.Column

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def column_fixture(attrs \\ %{}) do
      {:ok, column} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Board.create_column()

      column
    end

    test "list_columns/0 returns all columns" do
      backlog = Notifier.Board.Column |> Ecto.Query.first |> Notifier.Repo.one # default column generated by migration
      column = column_fixture()
      assert Board.list_columns() == [backlog, column]
    end

    test "get_column!/1 returns the column with given id" do
      column = column_fixture()
      assert Board.get_column!(column.id) == column
    end

    test "create_column/1 with valid data creates a column" do
      assert {:ok, %Column{} = column} = Board.create_column(@valid_attrs)
      assert column.name == "some name"
    end

    test "create_column/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Board.create_column(@invalid_attrs)
    end

    test "update_column/2 with valid data updates the column" do
      column = column_fixture()
      assert {:ok, %Column{} = column} = Board.update_column(column, @update_attrs)
      assert column.name == "some updated name"
    end

    test "update_column/2 with invalid data returns error changeset" do
      column = column_fixture()
      assert {:error, %Ecto.Changeset{}} = Board.update_column(column, @invalid_attrs)
      assert column == Board.get_column!(column.id)
    end

    test "delete_column/1 deletes the column" do
      column = column_fixture()
      assert {:ok, %Column{}} = Board.delete_column(column)
      assert_raise Ecto.NoResultsError, fn -> Board.get_column!(column.id) end
    end

    test "change_column/1 returns a column changeset" do
      column = column_fixture()
      assert %Ecto.Changeset{} = Board.change_column(column)
    end
  end
end

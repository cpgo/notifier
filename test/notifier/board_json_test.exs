defmodule Notifier.BoardJsonTest do
  use Notifier.DataCase

  alias Notifier.Board

  describe "cards" do
    alias Notifier.Board.Card

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

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Board.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
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
      card = card_fixture()
      assert {:ok, %Card{} = card} = Board.update_card(card, @update_attrs)
      assert card.body == "some updated body"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Board.update_card(card, @invalid_attrs)
      assert card == Board.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Board.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Board.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Board.change_card(card)
    end
  end
end

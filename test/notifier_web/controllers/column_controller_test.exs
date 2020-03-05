defmodule NotifierWeb.ColumnControllerTest do
  use NotifierWeb.ConnCase

  alias Notifier.Board

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:column) do
    {:ok, column} = Board.create_column(@create_attrs)
    column
  end

  describe "index" do
    test "lists all columns", %{conn: conn} do
      conn = get(conn, Routes.column_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Columns"
    end
  end

  describe "new column" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.column_path(conn, :new))
      assert html_response(conn, 200) =~ "New Column"
    end
  end

  describe "create column" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.column_path(conn, :create), column: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.column_path(conn, :show, id)

      conn = get(conn, Routes.column_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Column"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.column_path(conn, :create), column: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Column"
    end
  end

  describe "edit column" do
    setup [:create_column]

    test "renders form for editing chosen column", %{conn: conn, column: column} do
      conn = get(conn, Routes.column_path(conn, :edit, column))
      assert html_response(conn, 200) =~ "Edit Column"
    end
  end

  describe "update column" do
    setup [:create_column]

    test "redirects when data is valid", %{conn: conn, column: column} do
      conn = put(conn, Routes.column_path(conn, :update, column), column: @update_attrs)
      assert redirected_to(conn) == Routes.column_path(conn, :show, column)

      conn = get(conn, Routes.column_path(conn, :show, column))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, column: column} do
      conn = put(conn, Routes.column_path(conn, :update, column), column: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Column"
    end
  end

  describe "delete column" do
    setup [:create_column]

    test "deletes chosen column", %{conn: conn, column: column} do
      conn = delete(conn, Routes.column_path(conn, :delete, column))
      assert redirected_to(conn) == Routes.column_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.column_path(conn, :show, column))
      end
    end
  end

  defp create_column(_) do
    column = fixture(:column)
    {:ok, column: column}
  end
end

defmodule Yores.NarratorControllerTest do
  use Yores.ConnCase

  alias Yores.Narrator
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, narrator_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing narrators"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, narrator_path(conn, :new)
    assert html_response(conn, 200) =~ "New narrator"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, narrator_path(conn, :create), narrator: @valid_attrs
    assert redirected_to(conn) == narrator_path(conn, :index)
    assert Repo.get_by(Narrator, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, narrator_path(conn, :create), narrator: @invalid_attrs
    assert html_response(conn, 200) =~ "New narrator"
  end

  test "shows chosen resource", %{conn: conn} do
    narrator = Repo.insert! %Narrator{}
    conn = get conn, narrator_path(conn, :show, narrator)
    assert html_response(conn, 200) =~ "Show narrator"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, narrator_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    narrator = Repo.insert! %Narrator{}
    conn = get conn, narrator_path(conn, :edit, narrator)
    assert html_response(conn, 200) =~ "Edit narrator"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    narrator = Repo.insert! %Narrator{}
    conn = put conn, narrator_path(conn, :update, narrator), narrator: @valid_attrs
    assert redirected_to(conn) == narrator_path(conn, :show, narrator)
    assert Repo.get_by(Narrator, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    narrator = Repo.insert! %Narrator{}
    conn = put conn, narrator_path(conn, :update, narrator), narrator: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit narrator"
  end

  test "deletes chosen resource", %{conn: conn} do
    narrator = Repo.insert! %Narrator{}
    conn = delete conn, narrator_path(conn, :delete, narrator)
    assert redirected_to(conn) == narrator_path(conn, :index)
    refute Repo.get(Narrator, narrator.id)
  end
end

defmodule Yores.SceneControllerTest do
  use Yores.ConnCase

  alias Yores.Scene
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, scene_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing scenes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, scene_path(conn, :new)
    assert html_response(conn, 200) =~ "New scene"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, scene_path(conn, :create), scene: @valid_attrs
    assert redirected_to(conn) == scene_path(conn, :index)
    assert Repo.get_by(Scene, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, scene_path(conn, :create), scene: @invalid_attrs
    assert html_response(conn, 200) =~ "New scene"
  end

  test "shows chosen resource", %{conn: conn} do
    scene = Repo.insert! %Scene{}
    conn = get conn, scene_path(conn, :show, scene)
    assert html_response(conn, 200) =~ "Show scene"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, scene_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    scene = Repo.insert! %Scene{}
    conn = get conn, scene_path(conn, :edit, scene)
    assert html_response(conn, 200) =~ "Edit scene"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    scene = Repo.insert! %Scene{}
    conn = put conn, scene_path(conn, :update, scene), scene: @valid_attrs
    assert redirected_to(conn) == scene_path(conn, :show, scene)
    assert Repo.get_by(Scene, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    scene = Repo.insert! %Scene{}
    conn = put conn, scene_path(conn, :update, scene), scene: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit scene"
  end

  test "deletes chosen resource", %{conn: conn} do
    scene = Repo.insert! %Scene{}
    conn = delete conn, scene_path(conn, :delete, scene)
    assert redirected_to(conn) == scene_path(conn, :index)
    refute Repo.get(Scene, scene.id)
  end
end

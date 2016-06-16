defmodule Yores.SceneController do
  use Yores.Web, :controller

  alias Yores.Scene

  plug :scrub_params, "scene" when action in [:create, :update]

  def index(conn, _params) do
    scenes = Repo.all(Scene)
    render(conn, "index.html", scenes: scenes)
  end

  def new(conn, _params) do
    changeset = Scene.changeset(%Scene{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"scene" => scene_params}) do
    changeset = Scene.changeset(%Scene{}, scene_params)

    case Repo.insert(changeset) do
      {:ok, _scene} ->
        conn
        |> put_flash(:info, "Scene created successfully.")
        |> redirect(to: scene_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    scene = Repo.get!(Scene, id)
    render(conn, "show.html", scene: scene)
  end

  def edit(conn, %{"id" => id}) do
    scene = Repo.get!(Scene, id)
    changeset = Scene.changeset(scene)
    render(conn, "edit.html", scene: scene, changeset: changeset)
  end

  def update(conn, %{"id" => id, "scene" => scene_params}) do
    scene = Repo.get!(Scene, id)
    changeset = Scene.changeset(scene, scene_params)

    case Repo.update(changeset) do
      {:ok, scene} ->
        conn
        |> put_flash(:info, "Scene updated successfully.")
        |> redirect(to: scene_path(conn, :show, scene))
      {:error, changeset} ->
        render(conn, "edit.html", scene: scene, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    scene = Repo.get!(Scene, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(scene)

    conn
    |> put_flash(:info, "Scene deleted successfully.")
    |> redirect(to: scene_path(conn, :index))
  end
end

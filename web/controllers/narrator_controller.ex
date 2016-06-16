defmodule Yores.NarratorController do
  use Yores.Web, :controller

  alias Yores.Narrator

  plug :scrub_params, "narrator" when action in [:create, :update]

  def index(conn, _params) do
    narrators = Repo.all(Narrator)
    render(conn, "index.html", narrators: narrators)
  end

  def new(conn, _params) do
    changeset = Narrator.changeset(%Narrator{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"narrator" => narrator_params}) do
    changeset = Narrator.changeset(%Narrator{}, narrator_params)

    case Repo.insert(changeset) do
      {:ok, _narrator} ->
        conn
        |> put_flash(:info, "Narrator created successfully.")
        |> redirect(to: narrator_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    narrator = Repo.get!(Narrator, id)
    render(conn, "show.html", narrator: narrator)
  end

  def edit(conn, %{"id" => id}) do
    narrator = Repo.get!(Narrator, id)
    changeset = Narrator.changeset(narrator)
    render(conn, "edit.html", narrator: narrator, changeset: changeset)
  end

  def update(conn, %{"id" => id, "narrator" => narrator_params}) do
    narrator = Repo.get!(Narrator, id)
    changeset = Narrator.changeset(narrator, narrator_params)

    case Repo.update(changeset) do
      {:ok, narrator} ->
        conn
        |> put_flash(:info, "Narrator updated successfully.")
        |> redirect(to: narrator_path(conn, :show, narrator))
      {:error, changeset} ->
        render(conn, "edit.html", narrator: narrator, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    narrator = Repo.get!(Narrator, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(narrator)

    conn
    |> put_flash(:info, "Narrator deleted successfully.")
    |> redirect(to: narrator_path(conn, :index))
  end
end

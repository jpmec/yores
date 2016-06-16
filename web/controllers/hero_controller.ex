defmodule Yores.HeroController do
  use Yores.Web, :controller

  alias Yores.Hero

  plug :scrub_params, "hero" when action in [:create, :update]

  def index(conn, _params) do
    heros = Repo.all(Hero)
    render(conn, "index.html", heros: heros)
  end

  def new(conn, _params) do
    changeset = Hero.changeset(%Hero{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hero" => hero_params}) do
    changeset = Hero.changeset(%Hero{}, hero_params)

    case Repo.insert(changeset) do
      {:ok, _hero} ->
        conn
        |> put_flash(:info, "Hero created successfully.")
        |> redirect(to: hero_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hero = Repo.get!(Hero, id)
    render(conn, "show.html", hero: hero)
  end

  def edit(conn, %{"id" => id}) do
    hero = Repo.get!(Hero, id)
    changeset = Hero.changeset(hero)
    render(conn, "edit.html", hero: hero, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hero" => hero_params}) do
    hero = Repo.get!(Hero, id)
    changeset = Hero.changeset(hero, hero_params)

    case Repo.update(changeset) do
      {:ok, hero} ->
        conn
        |> put_flash(:info, "Hero updated successfully.")
        |> redirect(to: hero_path(conn, :show, hero))
      {:error, changeset} ->
        render(conn, "edit.html", hero: hero, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hero = Repo.get!(Hero, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(hero)

    conn
    |> put_flash(:info, "Hero deleted successfully.")
    |> redirect(to: hero_path(conn, :index))
  end
end

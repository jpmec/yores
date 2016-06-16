defmodule Yores.SceneTest do
  use Yores.ModelCase

  alias Yores.Scene

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Scene.changeset(%Scene{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Scene.changeset(%Scene{}, @invalid_attrs)
    refute changeset.valid?
  end
end

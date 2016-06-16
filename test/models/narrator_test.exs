defmodule Yores.NarratorTest do
  use Yores.ModelCase

  alias Yores.Narrator

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Narrator.changeset(%Narrator{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Narrator.changeset(%Narrator{}, @invalid_attrs)
    refute changeset.valid?
  end
end

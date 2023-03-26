defmodule ElxproFeed.Cars.Car do
  @moduledoc """
    nodoc
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cars" do
    field :age, :integer
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:name, :description, :age])
    |> validate_required([:name, :description, :age])
  end
end

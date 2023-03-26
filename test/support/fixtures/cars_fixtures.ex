defmodule ElxproFeed.CarsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElxproFeed.Cars` context.
  """

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> Enum.into(%{
        age: 42,
        description: "some description",
        name: "some name"
      })
      |> ElxproFeed.Cars.create_car()

    car
  end
end

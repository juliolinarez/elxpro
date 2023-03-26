defmodule ElxproFeed.CarsTest do
  use ElxproFeed.DataCase

  alias ElxproFeed.Cars

  describe "cars" do
    alias ElxproFeed.Cars.Car

    import ElxproFeed.CarsFixtures

    @invalid_attrs %{age: nil, description: nil, name: nil}

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Cars.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Cars.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      valid_attrs = %{age: 42, description: "some description", name: "some name"}

      assert {:ok, %Car{} = car} = Cars.create_car(valid_attrs)
      assert car.age == 42
      assert car.description == "some description"
      assert car.name == "some name"
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cars.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      update_attrs = %{age: 43, description: "some updated description", name: "some updated name"}

      assert {:ok, %Car{} = car} = Cars.update_car(car, update_attrs)
      assert car.age == 43
      assert car.description == "some updated description"
      assert car.name == "some updated name"
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Cars.update_car(car, @invalid_attrs)
      assert car == Cars.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Cars.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Cars.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Cars.change_car(car)
    end
  end
end

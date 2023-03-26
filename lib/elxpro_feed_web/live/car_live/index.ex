defmodule ElxproFeedWeb.CarLive.Index do
  use ElxproFeedWeb, :live_view

  alias ElxproFeed.Cars
  alias ElxproFeed.Cars.Car

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :cars, Cars.list_cars())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Car")
    |> assign(:car, Cars.get_car!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Car")
    |> assign(:car, %Car{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cars")
    |> assign(:car, nil)
  end

  @impl true
  def handle_info({ElxproFeedWeb.CarLive.FormComponent, {:saved, car}}, socket) do
    {:noreply, stream_insert(socket, :cars, car)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    car = Cars.get_car!(id)
    {:ok, _} = Cars.delete_car(car)

    {:noreply, stream_delete(socket, :cars, car)}
  end
end

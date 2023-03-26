defmodule ElxproFeedWeb.CarLive.FormComponent do
  use ElxproFeedWeb, :live_component

  alias ElxproFeed.Cars

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage car records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="car-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:age]} type="number" label="Age" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Car</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{car: car} = assigns, socket) do
    changeset = Cars.change_car(car)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"car" => car_params}, socket) do
    changeset =
      socket.assigns.car
      |> Cars.change_car(car_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"car" => car_params}, socket) do
    save_car(socket, socket.assigns.action, car_params)
  end

  defp save_car(socket, :edit, car_params) do
    case Cars.update_car(socket.assigns.car, car_params) do
      {:ok, car} ->
        notify_parent({:saved, car})

        {:noreply,
         socket
         |> put_flash(:info, "Car updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_car(socket, :new, car_params) do
    case Cars.create_car(car_params) do
      {:ok, car} ->
        notify_parent({:saved, car})

        {:noreply,
         socket
         |> put_flash(:info, "Car created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

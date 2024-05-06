defmodule ChatAppWeb.RoomChannel do
  use ChatAppWeb, :channel

  @impl true
  def join("room:lobby", _payload, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  # broadcast!/3 will notify all joined clients on this socket's topic and invoke their handle_out/3 callbacks.
  def handle_in("new_msg", %{"body" => body, "username" => username}, socket) do
    broadcast!(socket, "new_msg", %{username: username, body: body})
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat_room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

defmodule ChatAppWeb.ChatRoomChannel do
  use ChatAppWeb, :channel

  @impl true
  def join("chat_room:" <> room_id, _payload, socket) do
    {:ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat_room:lobby).
  @impl true
  def handle_in("new_message", %{"content" => content}, socket) do
    broadcast(socket, "new_message", %{
      "username" => socket.assigns.current_user.username,
      "content" => content
    })
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

defmodule ChatAppWeb.ChatRoomLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, username_field: true)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col h-screen">
      <div id="messages" role="log" aria-live="polite" class="flex-grow overflow-y-auto"></div>
      <div :if={@username_field} class="flex items-center text-sm px-6 py-2.5 sm:px-3.5 gap-x-6">
        <form phx-submit="username_field">
        <input

          id="name-input"
          type="text"
          placeholder="Enter Username"
          class="w-full max-w-xs px-3 py-1 border rounded-md focus:outline-none focus:border-blue-500"
        />
        </form>
      </div>
      <input id="chat-input" placeholder= "Send a Message" type="text" class="w-full max-w-xs px-3 py-1 border rounded-md focus:outline-none focus:border-blue-500" />
    </div>
    """
  end

  def handle_event("username_field", _params, socket) do
    {:noreply, assign(socket, username_field: false)}
  end
end

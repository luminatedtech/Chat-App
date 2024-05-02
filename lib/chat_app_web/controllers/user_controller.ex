defmodule ChatAppWeb.UserController do
  alias ChatAppWeb.User
  alias Guardian
  use ChatAppWeb, :controller
  use Ecto.Repo,
    otp_app: :chat_app,
    adapter: Ecto.Adapters.Postgres
  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> Guardian.Plug.sign_in(changeset.data)
        |> redirect(to: "/")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

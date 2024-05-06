defmodule ChatAppWeb.UserController do
  use ChatAppWeb, :controller
  alias ChatAppWeb.User
  alias ChatApp.Repo
  alias Guardian

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{~c"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        token = Guardian.encode_and_sign(user, :token)

        conn
        |> Guardian.Plug.sign_in(user, token)
        |> put_flash(:info, "User created and logged in successfully.")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

defmodule ChatAppWeb.SessionController do
  use ChatAppWeb, :controller
  alias ChatApp.Repo
  alias ChatAppWeb.User
  alias Guardian

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => user_params}) do
    case Repo.get_by(User, username: user_params["username"] || user_params["email"]) do
      nil ->
        conn
        |> put_flash(:error, "Invalid username or email.")
        |> render("new.html")

      user ->
        case Guardian.authenticate(user, user_params["password"]) do
          {:ok, _claims, token} ->
            conn
            |> Guardian.Plug.sign_in(user, token)
            |> put_flash(:info, "Logged in successfully.")
            |> redirect(to: "/")

          {:error, :invalid_credentials} ->
            conn
            |> put_flash(:error, "Invalid username or password.")
            |> render("new.html")

          {:error, reason} ->
            IO.puts("Error during authentication: #{reason}")

            conn
            |> put_flash(:error, "An error occurred. Please try again.")
            |> render("new.html")
        end
    end
  end
end

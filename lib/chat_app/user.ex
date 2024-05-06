defmodule ChatApp.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
    |> set_password_hash()
  end

  defp set_password_hash(changeset) do
    case changeset.valid? do
      true ->
        case changeset.data[:password] do
          nil ->
            changeset

          password ->
            put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
        end

      false ->
        changeset
    end
  end
end

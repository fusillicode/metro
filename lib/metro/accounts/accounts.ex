defmodule Metro.Accounts do
  @moduledoc """
  """

  import Comeonin.Bcrypt
  import Ecto.Query, warn: false

  alias Metro.{Repo, Accounts.User}
  alias Ueberauth.Auth

  def list_users, do: Repo.all(User)
  def get_user!(id), do: Repo.get!(User, id)
  def delete_user(%User{} = user), do: Repo.delete(user)
  def delete_all, do: Repo.delete_all(User)

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(%Auth{provider: :identity, uid: nil}), do: {:error, "Invalid username or password"}
  def authenticate_user(%Auth{provider: :identity, uid: email, credentials: credentials}) do
    case Repo.get_by(User, email: email) do
      nil  -> {:error, "Invalid username or password"}
      user -> case checkpw(credentials.other.password, user.password_hash) do
        false -> {:error, "Invalid username or password"}
        true  -> {:ok, user}
      end
    end
  end
  def authenticate_user(_), do: {:error, "Invalid username or password"}
end

defmodule Metro.AccountsTest do
  use Metro.DataCase

  alias Metro.Accounts

  describe "register_user/1" do
    alias Metro.Accounts.User

    test "with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.register_user(%{email: "joe@test.com", password: "password"})
      assert true = Comeonin.Bcrypt.checkpw("password", user.password_hash)
      assert user.email == "joe@test.com"
    end

    test "with blank email and password returns an error changeset" do
      assert {:error, changeset} = Accounts.register_user(%{email: nil, password: nil})
      assert [
        email:    {"can't be blank", [validation: :required]},
        password: {"can't be blank", [validation: :required]}
      ] == changeset.errors
    end

    test "with wrongly formatted email returns an error changeset" do
      assert {:error, changeset} = Accounts.register_user(%{email: "wrong", password: nil})
      assert [
        email:    {"has invalid format", [validation: :format]},
        password: {"can't be blank",     [validation: :required]}
      ] == changeset.errors
    end

    test "with wrongly formatted password an error changeset" do
      assert {:error, changeset} = Accounts.register_user(%{email: "joe@test.com", password: "wrong"})
      assert [
        password: {"should be at least %{count} character(s)", [count: 8, validation: :length, min: 8]}
      ] == changeset.errors
    end
  end
end

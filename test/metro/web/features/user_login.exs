defmodule Metro.Web.Features.UserLogin do
  use Metro.Web.FeatureCase, async: true

  alias Metro.Accounts

  setup do
    {:ok, user} = Accounts.register_user(%{email: "joe@test.com", password: "password"})
    [user: user]
  end

  describe "with valid credentials" do
    test "the user is redirected to the admin dashboard", context do
      context[:session]
      |> visit(sessions_path(Endpoint, :new))
      |> fill_in(text_field("Email"), with: context[:user].email)
      |> fill_in(text_field("Password"), with: context[:user].password)
      |> click(button("Login"))
      |> assert_has(css(".alert", text: "Successfully authenticated."))

      assert current_path(context[:session]) == admin_dashboard_path(Endpoint, :index)
    end
  end

  describe "with invalid credentials" do
    test "a proper error message is shown", context do
      context[:session]
      |> visit(sessions_path(Endpoint, :new))
      |> fill_in(text_field("Email"), with: "wrong@email.com")
      |> fill_in(text_field("Password"), with: "wrongpassword")
      |> click(button("Login"))
      |> assert_has(css(".alert", text: "Invalid username or password"))

      assert current_path(context[:session]) == sessions_path(Endpoint, :new)
    end
  end
end

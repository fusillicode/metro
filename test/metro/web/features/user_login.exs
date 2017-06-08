defmodule Metro.Features.UserLogin do
  use Metro.FeatureCase, async: true

  describe "with valid credentials" do
    test "the user is redirected to the admin dashboard", %{session: session} do
      session
      |> visit(sessions_path(Endpoint, :new))
      |> fill_in(text_field("Email"), with: "wrong@email.com")
      |> fill_in(text_field("Password"), with: "wrongpassword")
      |> click(button("Login"))
      |> assert_has(css(".alert", text: "Successfully authenticated."))

      assert current_path(session) == dashboard_path(Endpoint, :index)
    end
  end

  describe "with invalid credentials" do
    test "a proper error message is shown", %{session: session} do
      session
      |> visit(sessions_path(Endpoint, :new))
      |> fill_in(text_field("Email"), with: "wrong@email.com")
      |> fill_in(text_field("Password"), with: "wrongpassword")
      |> click(button("Login"))
      |> assert_has(css(".alert", text: "Invalid username or password"))

      assert current_path(session) == sessions_path(Endpoint, :new)
    end
  end
end

defmodule Metro.Web.Admin.DashboardCommander do
  use Drab.Commander

  def uppercase(socket, sender) do
    text = sender.params["text_to_uppercase"]
    IO.inspect text
    poke socket, nil, "index.html", text: String.upcase(text)
  end
end

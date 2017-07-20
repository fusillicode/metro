defmodule Metro.Web.Admin.DashboardCommander do
  use Drab.Commander

  def uppercase(socket, sender) do
    text = sender.params["text_to_uppercase"]
    poke socket, text: String.upcase(text)
  end
end

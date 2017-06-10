defmodule Metro.Uploads.Media do
  use Ecto.Schema
  import Ecto.Changeset
  alias Metro.Uploads.Media


  schema "uploads_media" do
    field :name, :string
    field :path, :string

    timestamps()
  end

  @doc false
  def changeset(%Media{} = media, attrs) do
    media
    |> cast(attrs, [:name, :path])
    |> validate_required([:name, :path])
  end
end

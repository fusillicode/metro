defmodule Metro.Repo.Migrations.CreateMetro.Uploads.Media do
  use Ecto.Migration

  def change do
    create table(:uploads_media) do
      add :name, :string
      add :path, :string

      timestamps()
    end

  end
end

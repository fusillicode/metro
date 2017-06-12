defmodule Metro.Web.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias Metro.{Repo, Web.Endpoint}

      import Ecto
      import Ecto.{Changeset, Query}
      import Wallaby.Query
      import Metro.Web.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Metro.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Metro.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Metro.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end

defmodule ExredisKeyAuth do
  @moduledoc """
  This model makes set/get operations using Exredis hex lib
  on a Redis instance
  """
  import Exredis

  @doc """
  Gets a corresponding work_group_id in relation to the keys
  """
  def authenticate(access_key, secret_key) do
    combined = access_key <> ":" <> secret_key
    {:ok, client} = start_link()

    work_group_id = client |> query(["GET", combined])

    client |> Exredis.stop

    if (work_group_id == :undefined) do
      :undefined
    else
      work_group_id
    end
  end
end

defmodule ExredisKeyAuth do
  @moduledoc """
  This model makes set/get operations using Exredis hex lib
  on a Redis instance
  """
  alias Exredis, as: E
  alias Exredis.Api, as: A
  require IEx
  @doc """
  Gets a corresponding work_group_id in relation to the keys
  """
  def authenticate(access_key, secret_key) do
    combined = access_key <> ":" <> secret_key
    {:ok, client} = E.start_link()

    work_group_id = client |> E.query(["GET", combined])

    client |> E.stop

    if (work_group_id == :undefined) do
      :undefined
    else
      work_group_id
    end
  end

  def authenticate(access_key, secret_key, "pdfler") do
    combined = access_key <> ":" <> secret_key
    {:ok, client} = E.start_link()

    work_group_id = client |> A.hget("pdfler:credentials_sets", combined)

    client |> E.stop

    if (work_group_id == :undefined) do
      :undefined
    else
      work_group_id
    end
  end
end

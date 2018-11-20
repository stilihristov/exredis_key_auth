defmodule ExredisKeyAuth do
  @moduledoc """
  This model makes set/get operations using Exredis hex lib
  on a Redis instance
  """
  import Exredis

  @doc """
  Gets a corresponding work_group_id in relation to the keys
  """
  def get(keys) do
    {:ok, client} = start_link()

    work_group_id = client |> query(["GET", keys])

    client |> Exredis.stop

    if (work_group_id == :undefined) do
      :undefined
    else
      work_group_id
    end
  end

  @doc """
  Sets a key/work_group pair
  """
  def set(keys, work_group_id) do
   {:ok, client} = start_link()

    work_group_id = client |> query(["SET", keys, work_group_id])

    client |> Exredis.stop
  end
end

defmodule ExredisKeyAuth do
  @moduledoc """
  This model makes set/get operations using Exredis hex lib
  on a Redis instance
  """
  import Exredis

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

  def set(keys, work_group_id) do
   {:ok, client} = start_link()

    work_group_id = client |> query(["SET", keys, work_group_id])

    client |> Exredis.stop
  end
end

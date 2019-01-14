defmodule ExredisKeyAuth do
  @moduledoc """
  This model makes set/get operations using Exredis hex lib
  on a Redis instance
  """
  alias Exredis, as: E
  alias Exredis.Api, as: A

  @doc """
  Gets a corresponding work_group_id in relation to the keys
  """
  def authenticate(access_key, secret_key, service) do
    combined = access_key <> ":" <> secret_key
    {:ok, client} = E.start_link()

    work_group_id = client |> A.hget("#{service}:credentials_sets", combined)

    client |> E.stop

    is_undefined(work_group_id)
  end

  @doc """
  If the work_group_id could not be resolved return an atom of :undefined
  Pdfler returns an error 401 not authorized.
  """
  def is_undefined(work_group_id) when work_group_id == :undefined do
    :undefined
  end

  def is_undefined(work_group_id) do
    work_group_id
  end
end

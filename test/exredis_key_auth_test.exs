defmodule ExredisKeyAuthTest do
  use ExUnit.Case
  doctest ExredisKeyAuth

  describe "Calls to ExredisKeyAuth" do
    test "return undefined for nonexistent key-workgroup pair" do
      assert ExredisKeyAuth.get("a_non_existent_key") == :undefined
    end

    test "sets a key and corresponding work group" do
      assert ExredisKeyAuth.set("an_existing_key", "1")
    end

    test "gets a correct work group when a key is valid" do
      assert ExredisKeyAuth.get("an_existing_key") == "1"
    end
  end
end

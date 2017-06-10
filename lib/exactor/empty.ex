defmodule ExActor.Empty do
  @moduledoc """
  Empty predefine. Imports all ExActor macros, but doesn't provide any default
  implementation. The declaring module must define all required functions
  of the `gen_server` behaviour.

  Example:

      defmodule MyServer do
        use ExActor.Empty

        # define all gen_server required functions
      end

      # Locally registered name:
      use ExActor.Empty, export: :some_registered_name

      # Globally registered name:
      use ExActor.Empty, export: {:global, :global_registered_name}
  """
  defmacro __using__(opts) do
    quote do
      @behaviour :gen_server
      use ExActor.Common

      @generated_funs MapSet.new

      import ExActor.Operations
      import ExActor.Responders

      unquote(ExActor.Helper.init_generation_state(opts))



      @doc """
      By default, the `server` argument given
      to the different interface functions, is expected to be a process identifier,
      unless overridden by the `export:` option.

      But by providing a custom implementation of `server_pid/1`, you can map an identifier
      to a PID by some other means.
      """
      def server_pid(server_reference) do
        server_reference
      end

      defoverridable [server_pid: 1]
    end
  end
end

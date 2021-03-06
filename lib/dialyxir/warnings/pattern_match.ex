defmodule Dialyxir.Warnings.PatternMatch do
  @behaviour Dialyxir.Warning

  @impl Dialyxir.Warning
  @spec warning() :: :pattern_match
  def warning(), do: :pattern_match

  @impl Dialyxir.Warning
  @spec format_short([String.t()]) :: String.t()
  def format_short(_) do
    "The pattern can never match the type."
  end

  @impl Dialyxir.Warning
  @spec format_long([String.t()]) :: String.t()
  def format_long([pattern, type]) do
    pretty_pattern = Dialyxir.PrettyPrint.pretty_print_pattern(pattern)
    pretty_type = Dialyxir.PrettyPrint.pretty_print_type(type)

    """
    The pattern
    #{pretty_pattern}

    can never match the type
    #{pretty_type}
    """
  end

  @impl Dialyxir.Warning
  @spec explain() :: String.t()
  def explain() do
    """
    The pattern matching is never given a value that satisfies all of
    its clauses.

    Example:

    defmodule Example do

      def ok() do
        unmatched(:ok)
      end

      defp unmatched(:ok), do: :ok

      defp unmatched(:error), do: :error
    end
    """
  end
end

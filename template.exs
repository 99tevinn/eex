defmodule MyEngine do
  @behaviour EEx.Engine

  def init(_opts), do: []


  def handle_begin(_state) do
    IO.inspect("Begin")
    [quote do: IO.write("BEGIN: ")]
  end

  def handle_body(state) do
    IO.inspect({"Body", state})

    quote do
      unquote_splicing(state)
    end
  end

  def handle_text(state, _list, text) do
    IO.inspect({"Text", text})

    state ++ [quote do: IO.write(unquote(text))]
  end

  def handle_expr(state, _marker, {:if, _, _} = expr) do
    IO.inspect({"Expr - Control Structure", expr})

    state ++ [expr]
  end

  def handle_expr(state, _marker, expr) do
    IO.inspect({"Expr", expr})

    state ++ [quote do: IO.write(to_string(unquote(expr)))]
  end

  def handle_end(state) do
    IO.inspect("End")

    state ++ [quote do: IO.write(" :END")]
  end
end

template = """
<%= if true do %>
  Hello, <%= name %>! Today is <%= day %>.
<% end %>
"""

result = EEx.eval_string(template, [name: "Alice", day: "Tuesday"], engine: MyEngine)

IO.puts("\nFinal Output: #{result}")

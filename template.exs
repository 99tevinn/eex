defmodule MyEngine do
  @behaviour EEx.Engine

  def init(_opts), do: %{velocity: 1}

  def handle_begin(state) do
    IO.inspect({"Begin", state})
    state
  end

  def handle_body(state) do
    IO.inspect({"Body", state})
    state
  end

  def handle_text(state, _meta, text) do
    IO.inspect({"Text", text})
    state
  end

  def handle_expr(state, _marker, expr) do
    IO.inspect({"Expr", expr})
    state
  end

  def handle_end(quoted) do
    IO.inspect("Finished!")
    quoted
  end
end

EEx.compile_string("Hello <%= name %>", engine: MyEngine)

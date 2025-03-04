defmodule Tev do
  @ast EEx.compile_file("tev.eex")

  def render(user) do
    {result, _} = Code.eval_quoted(@ast, user: user)
    result
  end
end

user = %{name: "Tevin", age: 17}
IO.puts(Tev.render(user))

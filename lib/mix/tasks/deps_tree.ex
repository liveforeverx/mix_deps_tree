defmodule Mix.Tasks.Deps.Tree do
  @moduledoc """
  Analyses the current Mix project and prints dependency tree on terminal.

  ## Command line options

    * `--exclude` - exclude dependencies, which you do not want to see in a tree

  ## Example of use

      mix deps.tree --exclude logger,elixir

  Please note, that `kernel` and `stdlib` are always excluded from tree.
  """

  @shortdoc "Analyses the current Mix project and prints dependency tree on terminal."

  use Mix.Task

  @default_excluded [:kernel, :stdlib]

  @spec run(OptionParser.argv) :: :ok
  def run(args) do
    Mix.Task.run "loadpaths"
    {parsed, _, _} = OptionParser.parse(args)
    parsed = case parsed[:exclude] do
      nil -> []
      list -> String.split(list, ",") |> Enum.map(&String.to_atom/1)
    end
    excluded = @default_excluded ++ parsed
    [Mix.Project.get!.project[:app] |> deps] |> print_tree(excluded)
  end

  defp deps(app, type \\ :normal) do
    {apps, include_apps} = load(app)
    {app, type, Enum.map(apps, &deps(&1)) ++ Enum.map(include_apps, &deps(&1, :include))}
  end

  defp load(app) do
    case Application.load(app) do
      :ok -> :ok
      {:error, {:already_loaded, ^app}} -> :ok
    end
    {:ok, apps} = :application.get_key(app, :applications)
    {:ok, included_apps} = :application.get_key(app, :included_applications)
    {apps, included_apps}
  end

  defp print_tree(app_tree, depth \\ [], excluded)

  defp print_tree([], _depth, _excluded), do: :ok
  defp print_tree([{app, type, apps} | app_tree], depth, excluded) do
    unless app in excluded do
      unless depth == [],
        do: Enum.reverse(depth) |> tl |> Enum.map(&IO.write(if &1, do: " | ", else: "   "))
      prefix = prefix(depth, app_tree)
      IO.puts("#{prefix}#{app}#{type(type)}")
      print_tree(apps, [(app_tree != []) | depth], excluded)
    end
    print_tree(app_tree, depth, excluded)
  end

  defp prefix([], _), do: ""
  defp prefix(_, []), do: " `-- "
  defp prefix(_, _), do: " |-- "

  defp type(:normal), do: ""
  defp type(:include), do: " (included)"
end

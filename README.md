# MixDepsTree

** DEPRECATED: Use `mix app.tree` in upcoming elixir version: [elixir#4261](https://github.com/elixir-lang/elixir/pull/4261)

Mix task to show dependency tree in terminal.

## Installation

The package can be installed as:

  1. Add mix_deps_tree to your list of dependencies in `mix.exs`:

        def deps do
          [{:mix_deps_tree, "~> 0.1.0"}]
        end

## Usage

```
  phoenix % mix deps.tree --exclude elixir
  phoenix
  |-- plug
  |  |-- crypto
  |  `-- logger
  |-- poison
  |-- logger
  `-- eex
```

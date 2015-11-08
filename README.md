# MixDepsTree

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add mix_deps_tree to your list of dependencies in `mix.exs`:

        def deps do
          [{:mix_deps_tree, "~> 0.0.1"}]
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

# SheetLoader

Elixir program that polls Google Spreadsheet and serializes it into YAML file on disk.
Will be used later on with Middleman or another static site generator that supports YAML format.

Each spreadsheet tab will be saved as different YAML file.

It's based on [GoogleSheets](https://github.com/GrandCru/GoogleSheets) library.

Before you begin you'll need to give your Spreadsheet public read access. Which you want anyway, because you usually
will need these YAML files as public content of websites.

## Setup & development

Edit `config/config.exs`.

Run `mix gs.fetch` to set up initial CSV files.

```sh
iex -S mix
```

## Testing

```sh
mix test --no-start
```

## Running in production

Be sure to run `mix gs.fetch` before `mix run` to set up initial CSV files.

```sh
cp config/dev.exs config/prod.exs # edit your prod.exs config file
mix gs.fetch && MIX_ENV=prod mix run --no-halt
```

## Learned

`worker.ex` is our GenServer. Every GenServer needs to implement `start_link`. `start_link` is called when creating
workers in `Supervisor`.

`--no-halt` is what I needed from the start. (http://stackoverflow.com/questions/30687781/how-to-run-elixir-application)

```elixir
:timer.sleep(poll_delay_seconds * 5 * 1000) # This timer needs to always be more than poll_delay_seconds
```

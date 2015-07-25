# SheetLoader

Elixir program that polls Google Spreadsheet and serializes it into YAML file on disk.
Will be used later on with Middleman or another static site generator that supports YAML format.

It's based on [GoogleSheets](https://github.com/GrandCru/GoogleSheets) library.

Before you begin you'll need to give your Spreadsheet public read access. Which you want anyway, because you usually
will need these YAML files as public content of websites.

## Setup & development

Edit `config/config.exs`.

```sh
iex -S mix
```

## Testing

```sh
mix test --no-start
```

## Prod run

Be sure to run `mix gs.fetch` before `mix run` to set up initial CSV files.

```sh
MIX_ENV=prod mix run --no-halt
```

## Learned

`worker.ex` is our GenServer. Every GenServer needs to implement `start_link`. `start_link` is called when creating
workers in `Supervisor`.

`--no-halt` is what I needed from the start. (http://stackoverflow.com/questions/30687781/how-to-run-elixir-application)

```elixir
:timer.sleep(poll_delay_seconds * 5 * 1000) # This timer needs to always be more than poll_delay_seconds
```

## What's wrong

Latest version key returned by `GoogleSheets.latest_key` isn't correct for the spreadsheet config id.

```
01:25:39.690 [info]  Writing ../../center-mirje/locales/en.yml file...
ConfigID: en_center_mirje
latest_version_key: b5a60adb0b0cab3ff64d1a95cfc5573c7638c166

01:25:39.690 [info]  Writing ../../center-mirje/locales/sl.yml file...
ConfigID: sl_center_mirje
latest_version_key: b5a60adb0b0cab3ff64d1a95cfc5573c7638c166
```

There you can see that `ConfigID` is different in both times, but `latest_version_key` is the same, even though it
shouldn't be. I suspect this line in `google_sheets.ex` file:

```elixir
[{{^spreadsheet_id, :latest}, key}] -> {:ok, key}
```

It might be a pin (`^`) operator's fault? Dunno. Write a test that fails that.

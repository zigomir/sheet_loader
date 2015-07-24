# SheetLoader

Edit `config/config.exs`.

```sh
iex -S mix
```

## Testing

```sh
mix test --no-start
```

## Prod run

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

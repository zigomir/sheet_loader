# SheetLoader

Edit `config/config.exs`.

```sh
iex -S mix
```

## Prod run

```sh
MIX_ENV=prod mix run --no-halt
```

## Learned

`worker.ex` is our GenServer. Every GenServer needs to implement `start_link`. `start_link` is called when creating
workers in `Supervisor`.

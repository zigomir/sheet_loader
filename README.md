# SheetLoader

Edit `config/config.exs`.

```sh
iex -S mix
```


## Learned

`worker.ex` is our GenServer. Every GenServer needs to implement `start_link`. `start_link` is called when creating
workers in `Supervisor`.

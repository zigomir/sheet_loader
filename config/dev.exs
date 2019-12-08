use Mix.Config

config :google_sheets,
  spreadsheets: [
    config: [
      parser: SheetLoader.YamlParser,
      poll_delay_seconds: 10,
      dir: "priv/data",
      url:
        "https://spreadsheets.google.com/feeds/worksheets/1oSPJdAINiMT7oTe7MxIjE5RWxoasoYlZiSFSPtK81W4/public/basic"
    ]
  ]

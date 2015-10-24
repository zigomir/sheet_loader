use Mix.Config

config :google_sheets, spreadsheets: [
    config: [
      parser: SheetLoader.YamlParser,
      poll_delay_seconds: 10,
      dir: "priv/data",
      url: "https://spreadsheets.google.com/feeds/worksheets/1TgfWukYampLldgjS7quiF8HKvlvvyHrxkChtNkHBwqs/public/basic",
    ]
  ]

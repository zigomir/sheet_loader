use Mix.Config

config :google_sheets, spreadsheets: [
    [
      id: :test_sheet,
      parser: SheetLoader.YamlParser,
      poll_delay_seconds: 2,
      dir: "priv/data",
      url: "https://spreadsheets.google.com/feeds/worksheets/1TgfWukYampLldgjS7quiF8HKvlvvyHrxkChtNkHBwqs/public/basic"
    ]
  ]
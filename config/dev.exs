use Mix.Config

config :google_sheets, spreadsheets: [
    [
      id: :test_sheet,
      parser: SheetLoader.YamlParser,
      poll_delay_seconds: 10,
      dir: "priv/data",
      url: "https://spreadsheets.google.com/feeds/worksheets/1TgfWukYampLldgjS7quiF8HKvlvvyHrxkChtNkHBwqs/public/basic",
      post_save: %{
        command: "/Users/zigomir/.rbenv/shims/middleman",
        directory: "/Users/zigomir/development/center-mirje",
        args: ["build"]
      }
    ]
  ]

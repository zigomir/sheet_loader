defmodule SheetLoader.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sheet_loader,
      version: "0.2.0",
      elixir: "~> 1.2",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    # with this SheetLoader needs to be an OTP app
    [applications: [:logger, :google_sheets], mod: {SheetLoader, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:google_sheets, "~> 2.0.3"}]
  end
end

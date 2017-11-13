defmodule Mix.Tasks.Serve do
  use Mix.Task

  @shortdoc "Starts service"
  def run(_) do
    :timer.sleep(5000) # lets give rabbit time to boot up
    Auth.start
  end
end
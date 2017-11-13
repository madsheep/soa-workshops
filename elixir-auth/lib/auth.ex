defmodule Auth do

  @users %{"madsheep" => "owca", "admin" => "dupa8"}

  def start do
    {:ok, connection} = AMQP.Connection.open(host: System.get_env("RABBIT_HOST"))
    {:ok, channel} = AMQP.Channel.open(connection)

    AMQP.Queue.declare(channel, "backend.auth")
    AMQP.Basic.qos(channel, prefetch_count: 1)
    AMQP.Basic.consume(channel, "backend.auth")
    IO.puts " [x] Awaiting RPC requests"

    wait_for_messages(channel)
  end

  def wait_for_messages(channel) do
    receive do
      {:basic_deliver, payload, meta} ->
        AMQP.Basic.ack(channel, meta.delivery_tag)
        IO.inspect(payload)

        response = Auth.process_message(Poison.decode(payload)) |> Poison.encode!
        AMQP.Basic.publish(channel, "", meta.reply_to, response, correlation_id: meta.correlation_id)

        wait_for_messages(channel)
    end
  end

  def process_message({:ok, %{"user" => nil}}), do: process_message({:ok, nil})
  def process_message({:ok, %{"password" => nil}}), do: process_message({:ok, nil})

  def process_message({:ok, %{"user" => user, "password" => password}}) do
    if @users[user] == password,
      do: %{"login" => true},
      else: %{"login" => false}
  end

  def process_message({:ok, _}) do
    %{"error" => "Please provide user and password"}
  end

  def process_message(_) do
    %{"error" => "Please send valid json request!"}
  end

end
defmodule EchoServer do
  def run do
    listening(:gen_tcp.listen(2345, 
              [:binary, packet: :line, active: false, reuseaddr: true]))
  end

  def listening({:ok, socket}) do
    accept(socket)
  end

  def listening({:error, something}) do
    IO.puts "LISTEN ERROR #{something}"
  end

  def accept(socket) do
    accepted(:gen_tcp.accept(socket))
    accept(socket)
  end

  def accepted({:ok, client}) do
    spawn_monitor(EchoServer, :connection, [client])
  end

  def accepted({:error, something}) do
    IO.puts "ACCEPT ERROR #{something}"
  end

  def connection(client) do
    :gen_tcp.send(client, "Welcome (quit to exit)\n")
    received_data(client)
  end

  def received_data(client) do
    received_data(client, :gen_tcp.recv(client, 0))
  end

  def received_data(client, {:ok, "quit\r\n"}) do
    :gen_tcp.close(client)
    IO.puts "QUIT #{inspect client}"
  end

  def received_data(client, {:ok, data}) do
    IO.puts "DATA #{inspect data}"
    :gen_tcp.send(client, data)
    received_data(client)
  end

  def received_data(client, {:error, :closed}) do
    :gen_tcp.close(client)
    IO.puts "CLOSED #{inspect client}"
  end

  def close(socket) do
    :gen_tcp.close(socket)
  end
end

EchoServer.run


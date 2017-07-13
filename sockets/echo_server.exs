defmodule EchoServer do
  def run do
    control()
  end

  def control() do
    control_pid = self()
    spawn_monitor(EchoServer, :listening, [control_pid])
    monitor()
  end

  def monitor() do
    receive do
      _ -> IO.puts "Exiting..."
    end
  end

  def listening(control_pid) do
    IO.puts "Welcome to Echo"
    listening(control_pid, :gen_tcp.listen(2345, 
              [:binary, packet: :line, active: false, reuseaddr: true]))
  end

  def listening(control_pid, {:ok, socket}) do
    accept(control_pid, socket)
  end

  def listening(_, {:error, something}) do
    IO.puts "LISTEN ERROR #{something}"
  end

  def accept(control_pid, socket) do
    accepted(control_pid, :gen_tcp.accept(socket))
    accept(control_pid, socket)
  end

  def accepted(control_pid, {:ok, client}) do
    spawn_monitor(EchoServer, :connection, [control_pid, client])
  end

  def accepted(_, {:error, something}) do
    IO.puts "ACCEPT ERROR #{something}"
  end

  def connection(control_pid, client) do
    :gen_tcp.send(client, "Welcome (quit to exit)\n")
    received_data(control_pid, client)
  end

  def received_data(control_pid, client) do
    received_data(control_pid, client, :gen_tcp.recv(client, 0))
  end

  def received_data(_, client, {:ok, "quit\r\n"}) do
    :gen_tcp.close(client)
    IO.puts "QUIT #{inspect client}"
  end

  def received_data(control_pid, client, {:ok, "shutdown\r\n"}) do
    :gen_tcp.close(client)
    IO.puts "Shutting Down #{inspect client}"
    send control_pid, "shutdown"
  end

  def received_data(control_pid, client, {:ok, data}) do
    IO.puts "DATA #{inspect data}"
    :gen_tcp.send(client, data)
    received_data(control_pid, client)
  end

  def received_data(_, client, {:error, :closed}) do
    :gen_tcp.close(client)
    IO.puts "CLOSED #{inspect client}"
  end

  def close(socket) do
    :gen_tcp.close(socket)
  end
end

EchoServer.run


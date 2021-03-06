#
# A simple Echo Server to explor program structure.
#
# usage:
#   elixir echo_server.exs
#
# clients:
#   telnet localhost 2345
#

# Separate module to isolate program startup.
defmodule Echo.Main do
  def start do
    Echo.Control.control()
  end
end

# Module for the main erlang process that controls all linked child erlang processes
defmodule Echo.Control do
  def control() do
    control_pid = self()
    spawn_monitor(Echo.Listen, :start, [control_pid])
    wait_for_command()
  end

  def wait_for_command() do
    receive do
      "shutdown"   -> IO.puts "Shutdown..."
      message      -> IO.puts "Unexpected Exit: #{inspect message}"
    end
  end
end

# Module to isolate the first child process responsible for accepting connections.
defmodule Echo.Listen do
  # Convension all erlang processes have "start" function.
  def start(control_pid) do
    listening(control_pid)
  end

  def listening(control_pid) do
    IO.puts "Welcome to Echo"
    listening(control_pid, 
              :gen_tcp.listen(2345, [:binary, packet: :line, active: false, reuseaddr: true]))
  end

  def listening(control_pid, {:ok, listen_socket}) do
    accept_loop(control_pid, listen_socket)
  end

  def listening(_, {:error, message}) do
    IO.puts "LISTEN ERROR #{message}"
  end

  # Convension to suffix _loop for control loops
  def accept_loop(control_pid, listen_socket) do
    accepted(control_pid, :gen_tcp.accept(listen_socket))
    accept_loop(control_pid, listen_socket)
  end

  def accepted(control_pid, {:ok, client_socket}) do
    spawn_monitor(Echo.Connection, :start, [control_pid, client_socket])
  end

  def accepted(_, {:error, message}) do
    IO.puts "ACCEPT ERROR #{message}"
  end
end

# Module to isolate read/write of each connection
defmodule Echo.Connection do
  # Convension all erlang processes have "start" function.
  def start(control_pid, client_socket) do
    welcome(control_pid, client_socket)
  end

  def welcome(control_pid, client_socket) do
    :gen_tcp.send(client_socket, "Welcome (quit to exit, or shutdown to stop everything)\n")
    received_loop(control_pid, client_socket)
  end

  # Convension to suffix _loop for control loops
  def received_loop(control_pid, client_socket) do
    received_data(control_pid, client_socket, 
                  :gen_tcp.recv(client_socket, 0))
  end

  def received_data(_, client_socket, {:ok, "quit\r\n"}) do
    :gen_tcp.send(client_socket, "Goodbye\n")
    :gen_tcp.close(client_socket)
    IO.puts "QUIT #{inspect client_socket}"
  end

  def received_data(control_pid, client_socket, {:ok, "shutdown\r\n"}) do
    :gen_tcp.send(client_socket, "Shutting Down\n")
    :gen_tcp.close(client_socket)
    IO.puts "Shutting Down #{inspect client_socket}"
    send control_pid, "shutdown"
  end

  def received_data(control_pid, client_socket, {:ok, data}) do
    IO.puts "DATA #{inspect data}"
    :gen_tcp.send(client_socket, data)
    received_loop(control_pid, client_socket)
  end

  def received_data(_, client_socket, {:error, :closed}) do
    :gen_tcp.close(client_socket)
    IO.puts "CLOSED #{inspect client_socket}"
  end
end

Echo.Main.start


defmodule ExJrubyPort do
  alias ExJrubyPort.JrubyService
  alias ExJrubyPort.JrubySession
  alias ExJrubyPort.JrubyContext
  use GenServer

  def start_link(%JrubyContext{} = ctx) do
    GenServer.start_link(__MODULE__, ctx)
  end

  def run(pid, file, params \\ []) do
    GenServer.call(pid, {:run, file, params})
  catch
    :exit, {:timeout, _} -> {:ok, ""}
  end

  def start_node(pid, file, params \\ []) do
    GenServer.call(pid, {:new_node, file, params})
  end

  def init(opts) do
    {:ok, %{context: opts}}
  end

  def handle_call({:run, file, params}, _from, state) do
    {:ok, spid} = JrubySession.start_link(state.context)
    res = GenServer.call(spid, {:run, file, params})
    GenServer.stop(spid)
    {:reply, res, state}
  end

  def handle_call({:new_node, file, params}, _from, state) do
    {:ok, spid} = JrubyService.start_link(state, file, params)
    {:reply, {:ok, spid}, state}
  end
end

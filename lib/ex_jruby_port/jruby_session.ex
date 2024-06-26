defmodule ExJrubyPort.JrubySession do
  alias ExJrubyPort.JrubyContext
  alias ExJrubyPort.JrubySession
  use GenServer

  use TypedStruct

  typedstruct do
    field(:context, any())
  end

  def set_context(sess, ctx), do: %JrubySession{sess | context: ctx}

  def start_link(%JrubyContext{} = ctx) do
    sess =
      %JrubySession{}
      |> JrubySession.set_context(ctx)

    GenServer.start_link(__MODULE__, sess)
  end

  def init(%JrubySession{context: %JrubyContext{java_path: path}}) when is_nil(path),
    do: {:stop, {:error, :java_path_is_nil}}

  def init(%JrubySession{} = sess) do
    {:ok, sess}
  end

  def handle_call({:run, file, params}, _from, state) do
    port =
      Port.open(
        {:spawn,
         "#{state.context.java_path} -jar #{state.context.jruby_jar_path} #{Path.expand(file)} #{Enum.join(params, " ")}"},
        [
          :binary,
          :exit_status
        ]
      )

    res =
      receive do
        {^port, {:data, result}} -> result
      end

    Port.close(port)

    {:reply, {:ok, res}, state}
  end

  def handle_info(msg, _state) do
    IO.puts("handle_info : #{IO.inspect(msg)}")
    {:noreply, :ok}
  end
end

defmodule VampServer do
  use GenServer

  def init(output) do
    {:ok, output}
  end

  def handle_cast({:save_state,fang},output) do

    {:noreply,output++[fang]}
  end
  def handle_call(:get_state,_from,output) do
    {:reply,output,output}
  end



end

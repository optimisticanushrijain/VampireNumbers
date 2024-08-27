defmodule VampireSupervisor do
  use Supervisor

   def start_link(int_arg,print_pid) do
    Supervisor.start_link(__MODULE__, [int_arg,print_pid])
   # IO.inspect(var)
  end
  def init([int_arg,print_pid]) do
   # IO.puts("Here")

   [start,last] = int_arg
    nodes = Enum.chunk_every(start..last, 250000)
    children = Enum.map(nodes, fn(chunk_list) ->
      worker(VampireReceiver, [chunk_list,print_pid], [id: List.first(chunk_list)])
    end)

   #children = [
     # worker(VampireReceiver, [[100000,125000]],[id: 1]),
      #worker(VampireReceiver, [[125001,150000]],[id: 2]),
      #worker(VampireReceiver, [[150001,175000]],[id: 3]),
      #worker(VampireReceiver, [[175001,200000]],[id: 4])
    #]

    supervise(children, strategy: :one_for_one)
    #Process.sleep 10_100
  end
end 
# testing



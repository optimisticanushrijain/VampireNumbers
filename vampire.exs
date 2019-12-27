defmodule Vampire do
  use Application

  def start(_type,_args) do
    [n,m] = System.argv()
    int_arg = [String.to_integer(n),String.to_integer(m)]
    #IO.inspect(args)
   #int_arg = [Enum.at(args,0),Enum.at(args,1)]
  # IO.inspect(int_arg)
    {:ok,print_pid} = GenServer.start_link(VampServer,[])
   VampireSupervisor.start_link(int_arg,print_pid)

   output = GenServer.call(print_pid,:get_state)
  # IO.inspect(output)
   Enum.each(output,fn(pairs)->
    Enum.each(pairs,fn(element)->
      IO.write("#{element} ")

    end)
IO.puts("")
  end)

   #IO.inspect(output)


    # IO.inspect()
  #children = [

   # %{
    #  id: 1,
     # start: {VampireReceiver, :start_link, [[100000,125000]]}
   # },
    ## id: 2,
      #start: {VampireReceiver, :start_link, [[125001,150000]]}
    #},
   # %{
   #   id: 3,
   #   start: {VampireReceiver, :start_link, [[150001,175000]]}
   # },
   # %{
    #  id: 4,
     # start: {VampireReceiver, :start_link, [[175001,200000]]}
   # }

#    worker(VampireReceiver, [[100000,125000]],[id: 1]),
 #   worker(VampireReceiver, [[125001,150000]],[id: 2]),
  #  worker(VampireReceiver, [[150001,175000]],[id: 3]),
   # worker(VampireReceiver, [[175001,200000]],[id: 4])
  #]

 # Supervisor.start_link(children, strategy: :one_for_one)

end

end



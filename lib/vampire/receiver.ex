defmodule VampireReceiver do
  use GenServer
  def start_link(init_arg,print_pid) do
   {:ok,_} =  GenServer.start_link(__MODULE__,[init_arg,print_pid])

   # pid = spawn_link(__MODULE__, :init, [init_arg])
   # {:ok,pid}
  end

  def init([init_arg,print_pid]) do
    #[left,right] = init_arg
    #func(left, right)
    
    func(init_arg,print_pid)
    {:ok,init_arg}
  end
def func(chunks,print_pid) do
  Enum.each(chunks, fn(x)->
   # main(x)
    spawn(__MODULE__,:main,[x,print_pid])
  end)
end
 def main(n,print_pid) do
    list = make_factor(n,round(:math.sqrt(n)),[])
    #{:ok,pid}=GenServer.start_link(VampServer, list)
    state = get_fang(n,list,[n])
    #Enum.each(list, fn([left,right])->
     #   result = check_vampire(n,left,right)
        #if result do

        #end
    #end)
    if length(state)>1 do
      GenServer.cast(print_pid,{:save_state,state})
    end

end


  def get_fang(_n,[],state) do
    state
  end

  def get_fang(n,factors,state) do
    [[left,right]|_] = factors
    result = check_vampire(n,left,right)
    [_|tail] = factors
    if result do
    get_fang(n,tail,state++[left,right])
    else
      get_fang(n,tail,state)
    end

  end


  def make_factor(_n,x,list) when x<=0 do
    list
  end

  def make_factor(n,x,list) when x>0 and rem(n,x)==0 do
    make_factor(n,x-1,[[x,div(n,x)]|list])

  end
  def make_factor(n,x,list) do
    make_factor(n,x-1,list)
  end


  def check_vampire(n,left,right) do
    main_number = Integer.digits(n)
    split_size = div(length(main_number),2)
    split_left = Integer.digits(left)
    split_right = Integer.digits(right)
    if(not (rem(left,10)==0 and rem(right,10)==0) and (length(split_right)==split_size and length(split_left)==split_size)) do
      check_list = split_left ++ split_right
      if(check_list--main_number==[]) do
        true
       # IO.puts("#{n} #{left} #{right}")
        #Process.sleep(500)
      else
        false
      end
    else
      false

    end

end

end


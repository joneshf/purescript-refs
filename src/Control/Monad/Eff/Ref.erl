-module(control_monad_eff_ref@foreign).
-export(['modifyRef\''/2, newRef/1, readRef/1, writeRef/2]).

'modifyRef\''(Ref, F) ->
    fun () ->
        rpc(Ref, {modify, F})
    end.

newRef(Value) ->
    fun () ->
        spawn(fun() -> ref(Value) end)
    end.

readRef(Ref) ->
    fun () ->
        rpc(Ref, read)
    end.

writeRef(Ref, Value) ->
    fun () ->
        rpc(Ref, {write, Value})
    end.

%% Ref implementation

ref(Value) ->
    receive
        {From, {modify, F}} ->
            #{ state := NewValue, value := Result } = F(Value),
            respond(From, Result),
            ref(NewValue);

        {From, read} ->
            respond(From, Value),
            ref(Value);


        {From, {write, NewValue}} ->
            respond(From, unit),
            ref(NewValue)
    end.

respond(Pid, Response) ->
    Pid ! {self(), Response}.

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
        {Pid, Response} ->
            Response
    end.

-module(control_monad_eff_ref@foreign).
-export(['modifyRef\''/2, newRef/1, readRef/1, writeRef/2]).

'modifyRef\''(Ref, F) ->
    fun () ->
        [{value, Value1}] = ets:lookup(Ref, value),
        #{state := State, value := Value2} = F(Value1),
        ets:insert(Ref, {value, State}),
        Value2
    end.

newRef(Value) ->
    fun () ->
        Ref = ets:new(ref, []),
        ets:insert(Ref, {value, Value}),
        Ref
    end.

readRef(Ref) ->
    fun () ->
        [{value, Value}] = ets:lookup(Ref, value),
        Value
    end.

writeRef(Ref, Value) ->
    fun () ->
        ets:insert(Ref, {value, Value}),
        unit
    end.

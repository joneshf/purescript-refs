module Test.Main where
  
import Prelude

import Effect (Effect)
import Effect.Console (log)
import Effect.Ref (modify, modify', new, read, write)
import Test.Assert (assert)

main :: Effect Unit
main = do
  log "read and write"
  boolRef <- new false
  read boolRef >>= \initial -> assert (not initial)
  
  write true boolRef 
  read boolRef >>= \updated -> assert updated

  log "modify"
  intRef <- new 0
  modify (_+1) intRef >>= \n -> assert $ n == 1
  
  res <- modify' (\s -> { state: s+1, value: "hi" }) intRef
  assert $ res == "hi"
  read intRef >>= \nn -> assert $ nn == 2

{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "control"
, dependencies = [ "effect", "prelude" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, backend = "purerl"
}

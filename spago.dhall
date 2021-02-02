{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "purescript-refs"
, dependencies = [ "assert", "console", "effect", "psci-support" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, backend = "purerl"
}

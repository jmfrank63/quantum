import Lake
open Lake DSL

package «quantum» where
  -- add package configuration options here

lean_lib «Quantum» where
  -- add library configuration options here

@[default_target]
lean_exe «quantum» where
  root := `Main

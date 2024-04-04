# Quantum Theorem Proofs

This repository contains a collection of theorem proofs related to quantum computing, written in Lean, a theorem prover and programming language.

## Structure

The repository is structured as follows:

- `Main.lean`: This is the main entry point of the proofs.
- `Quantum/`: This directory contains the quantum computing related proofs.
  - `Basic.lean`: Contains basic quantum computing proofs.
  - `Quantum.lean`: Contains advanced quantum computing proofs.
- `lakefile.lean` and `lake-manifest.json`: These files are used by Lean's package manager, Lake.
- `lean-toolchain`: Specifies the version of Lean to be used.

## Getting Started

To get started with these proofs, you need to have Lean and Lake installed. Once they are installed, you can use Lake to build the project:

```sh
lake build
```

Then

```sh
lean Quantum/Basic.lean
```

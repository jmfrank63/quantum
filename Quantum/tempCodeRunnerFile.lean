def classic :=
  experiment.run (ModelOrDependentModel.Model (ClassicModel true)) (threshold + 1)

def classic_in_quantum :=
  experiment.run (ModelOrDependentModel.Model (ClassicModel true)) (threshold -1)

def quantum :=
  experiment.run
    (ModelOrDependentModel.DependentModel (QuantumModel (ClassicModel true) (threshold - 1)))
    (threshold -1)

def quantum_in_classic :=
  experiment.run
    (ModelOrDependentModel.DependentModel (QuantumModel (ClassicModel true) (threshold + 1)))
    (threshold + 1)

def illegal_classic :=
  experiment.run (ModelOrDependentModel.Model (ClassicModel false)) (threshold + 1)

def illegal_quantum_in_quantum :=
  experiment.run
    (ModelOrDependentModel.DependentModel (QuantumModel (ClassicModel false) (threshold - 1)))
    (threshold - 1)

def illegal_quantum_in_classic :=
  experiment.run
    (ModelOrDependentModel.DependentModel (QuantumModel (ClassicModel false) (threshold + 1)))
    (threshold + 1)
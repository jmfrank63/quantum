-- Define the Behavior type and specific behaviors a and b
inductive Behavior
| classic : Behavior
| quantum : Behavior
| unknown : Behavior
| different : Behavior
deriving Repr, DecidableEq

def threshold : Nat := 100

-- Define the Model structure
structure Model :=
(behavior : Bool → Nat → Option Behavior)
(legal : Bool)

-- Define the Model structure
structure DependencyModel :=
(behavior : Nat → Option Behavior)
(model: Model)

-- Define a new type that can be either a Model or a DependencyModel
inductive ModelOrDependencyModel
| Model (m : Model) : ModelOrDependencyModel
| DependencyModel (d : DependencyModel) : ModelOrDependencyModel

structure Scale :=
(size : Nat)

-- Define the Experiment structure
structure Experiment :=
(run : ModelOrDependencyModel → Nat → Option Behavior)

-- Define Model A
def ClassicModel (legal : Bool) : Model :=
{ behavior := fun legal s => if legal then (if s > threshold then some Behavior.classic else some Behavior.different) else none,
  legal := legal}

-- Define Model B based on Model A
def QuantumModel (m: Model) (s : Nat): DependencyModel :=
{ behavior := fun _ => if ¬ m.legal then m.behavior false s else
    if s < threshold then Behavior.quantum else Behavior.unknown,
  model := m }

-- Define an experiment that uses a model's behavior function
def experiment : Experiment :=
{ run := λ modOrDepMod s => match modOrDepMod with
  | ModelOrDependencyModel.Model m => match m.legal with
    | false => none
    | true => (match m.behavior true s with
      | none => none
      | some _ => m.behavior true s)
  | ModelOrDependencyModel.DependencyModel d => (match d.behavior s with
      | none => none
      | some _ => d.behavior s)
}

def matchOptions {α : Type} [BEq α] (opt1 opt2 : Option α) : Bool :=
  match opt1, opt2 with
  | some x, some y => x == y
  | none, none => true
  | _, _ => false

def classic := experiment.run (ModelOrDependencyModel.Model (ClassicModel true)) (threshold + 1)
def classic_in_quantum := experiment.run (ModelOrDependencyModel.Model (ClassicModel true)) (threshold -1 )
def quantum := experiment.run (ModelOrDependencyModel.DependencyModel (QuantumModel (ClassicModel true) (threshold - 1))) (threshold -1)
def quantum_in_classic := experiment.run (ModelOrDependencyModel.DependencyModel (QuantumModel (ClassicModel true) (threshold + 1))) (threshold + 1)

def illegal_classic := experiment.run (ModelOrDependencyModel.Model (ClassicModel false)) (threshold + 1)
def illegal_quantum_in_quantum := experiment.run (ModelOrDependencyModel.DependencyModel (QuantumModel (ClassicModel false) (threshold - 1))) (threshold - 1)
def illegal_quantum_in_classic := experiment.run (ModelOrDependencyModel.DependencyModel (QuantumModel (ClassicModel false) (threshold + 1))) (threshold + 1)

#eval classic
#eval classic_in_quantum
#eval quantum
#eval quantum_in_classic

#eval illegal_classic
#eval illegal_quantum_in_quantum
#eval illegal_quantum_in_classic

-- Theorem : If the classic model is illegal, then the quantum model is illegal
theorem illegal_classic_implies_illegal_quantum (s : Nat) :
  (ClassicModel false).legal = false → (QuantumModel (ClassicModel false) s).model.legal = false :=
by intro h; exact h

#check illegal_classic_implies_illegal_quantum
#eval "QED"

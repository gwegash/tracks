# Wiring example Press Alt+Enter to start (⌥+Enter on Mac)
(lfo :modulator)

(chain 
  (oscillator :oscar)
  (scope :oscar-scope)
  :out
)

#(wire :modulator :oscar :frequency) # wire the module up to the :frequency knob on the oscilator

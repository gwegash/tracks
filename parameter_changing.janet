# Set up an oscillator, plug it into a scope, plug the result into the output
(chain 
  (oscillator :oscar :wave "sine")
  (scope :oscar-scope)
  :out
)

# Set up a live_loop called :frequency_changer. Change the :oscar's :frequency knob from 100 to 500 every beat.
(live_loop :frequency_changer
  (change :oscar :frequency 100)
  (sleep 0.5)
  (change :oscar :frequency 500)
  (sleep 0.5)
)

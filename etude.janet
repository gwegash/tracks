# Hello
# This is a little tour of the main features of trane

# You can create instruments (and effects) and chain them together
(chain 
  (synth :hello-synth "triangle")
  (Dlay :hello-delay 0.7 0.4)
  (biquad :hello-filter "highpass")
  (gain :hello-gain)
  (reverb :hello-verb "https://oramics.github.io/sampled/IR/EMT140-Plate/samples/emt_140_medium_5.wav") #ty Greg Hopkins
  :out
)
# Instruments want events sending to them, so you have to give them a name.

# Live loops are like regular loops, but their body can be modified.
# The new code will execute when the loop runs again.
# Try modifying the note below. Remember to press alt+enter again.
(live_loop :player
  (def note (+ (note :G4) (timesel [0 7 12] 2)))
  (play note :hello-synth :dur 0.1)
  (target :hello-gain :gain 0.3 0.01)
  (sleep 2)
)
# To send notes to instruments, you can use the play function
# You can also change instrument parameters at specific times with one of change, lin, exp, target


# Live loops have to sleep for some time, try uncommenting the code below
#(live_loop :twinkle
#  (def note (pick (chord :G5 :maj9)))
#  (play note :hello-synth :dur 0.1)
#  (sleep (rand 2 8))
#)

# Samples can be loaded from the web, or locally by dragging and dropping them over the editor
(chain 
  (sample :drone-sample "https://lisp.trane.studio/tracks/choir%20g%20maj.wav" 52)
  (gain :drone-gain)
  :hello-verb
)

(live_loop :drones
  (change :drone-gain :gain 0.1)
  (play (pick [40 52 52 64]) :drone-sample :dur 32)
  (sleep 5)
)

# You can use (doc ...) whilst editing to find out more until I write better documentation
#(doc Dlay)

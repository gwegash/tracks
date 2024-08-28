# Create a "triangle" wave synth, attach it to a scope, and attach that to the output
(chain 
  (synth :hi-synth :wave "triangle")
  (scope :hi-scope)
  :out
)


# Create a live_loop called :scale_player
(live_loop :scale_player
  (def scale_gen (scale :c4 :major)) # Create a :major scale generator with a root note of :c4
  (def chord_gen (chord :c4 :major)) # Create a :major chord generator with a root note of :c4
  (for i 0 8 
    (def n (scale_gen i))
    (play n :hi-synth :dur 0.25)     # Play our note n with a duration or 0.25 beats
    (sleep 0.5)
  )
)

(bpm 120)
(chain 
  (keyboard :keys)
  (synth :s :wave "sawtooth" :gain 0.3 :attack 0.4 :release 0.5)
  (chorus :synth-chorus)
  (biquad :filter :filter_type "highpass")
  (scope :scope)
  :out
)

(chain 
  (keyboard :keys-samp)
  (sample :samp :url "tracks/piano_c5.wav" :pitch :c4 :gain 0.4)
  (scope :scope-samp)
  :out
)

(chain 
  (keyboard :keys-break)
  (breakbeat :break :url "tracks/break.wav" :length_beats 8 :slices 4)
  (scope :scope-break)
  :out
)

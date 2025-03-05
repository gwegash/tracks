(chain 
  (keyboard :ke)
  (sample :example :url "tracks/samples/pad_c.wav" :attack 0.17 :release 0.25 :loop-start 0.3 :loop-end 0.69 :pitch :c3)
  (panner :pan)
  (gain :gate)
  (reverb :verb :decay-time 4)
  :out
)

(live_loop :chords
  (play ((chord (timesel [:c2 :f1 :a1 :d1] 16) (pick :m7 :m7 :m7)) [0 2 4 5 7]) :example :dur 16)
  (sleep 16)
)

(live_loop :gate
  (sleep 0.125)
  (target :gate :gain 0.001 0.001)
  (sleep 0.125)
  (target :gate :gain 1.2 0.001)
)

(chain 
  (breakbeat :gras :url "tracks/samples/lo_break.flac"
    :length_beats 4 
    :slices 8
    :gain 0.7)
  (biquad :gras-filter :filter_type "lowpass" :frequency 50 )
  (gain :gras-gain)
  (reverb :d-verb)
  :out
)

(live_loop :breaks
  (sleep (til 4))
  (each [n s] (P [
    (pick 0 (uclid 0 3 8)) 
  ] 4)
    (play n :gras :dur s)
    (sleep s)
  )
)














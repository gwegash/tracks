(bpm 160)

(use-lib "tracks/utils.janet")

(chain 
  (tb303 :teeb :gain 0.8002 :cutoff 40 :resonance 0.1783 :envMod 0.06324 :decay 0.3189 :attack 0.00307 :slide 0.03593)
  (distortion :teeb-stort :amount 750 )
  (gain :teeb-level :gain 1.738)
  (scope :teeb-scope)
  (reverb :teeb-verb)
  :out
)

(chain 
  (drums :808 :hits ["tracks/samples/hedonics/808BD3.flac"])
  (compressor :808-comp :threshold -53 :knee 0 :ratio 19.43 :attack 0.003 :release 0.075)
  (distortion :808-stort :amount 100)
  (gain :drum-vol :gain 2.399)
  (scope :drum-scope)
  :out
)

(live_loop :teeb-player
  (seed 45)
#  (seed 100)
  (for i 0 24
    (play (pick :d3 :d2 :d2 :d2 :eb3 :d4) :teeb :dur (pick 0.1 0.1 0.1 -0.1))
    (change :teeb :envMod (+ 0.01 (pick 0.01 0.01 0.01 0.05)) 0.01)
    (sleep 0.25)
  )
)

(chain 
  (sample :pad :url "tracks/samples/pad_c.wav" :pitch :c3)
  (gain :pad-gate)
  (reverb :pad-verb)
  (biquad :pad-shimmer :filter_type "peaking")
  (gain :pad-level)
  (scope :pad-scope)
  :out
)

(live_loop :pads
  (def root :e3)
  (play root :pad :dur 5)
  (play (- root 2) :pad :dur 5)
  (play (- root 5) :pad :dur 5)
  (sleep 4)
)

(gate :pad-gate :rate 0.125)
(sweep :pad-shimmer :frequency [4000 100] 32)
(sweep :teeb :cutoff [40 4000] 32)
(sweep :teeb :resonance [0.7 0.99] 32)

(live_loop :bd
  (for i 0 4
    (play 0 :808 :dur 1)
    (sleep 1)
  )
)

(chain 
  (breakbeat :warrior :url "tracks/samples/loops/warrior.flac" :slices 8 :length_beats 4 :transpose 4 :gain 3)
  (distortion :warrior-stort :amount 10)
  (compressor :warrior-comp :threshold -31 :knee 30 :ratio 14.19 :attack 0.003 :release 0.015)
  (gain :warrior-level :gain 3.802)
  (scope :warrior-scope)
  :out
)

(chain 
  (breakbeat :amen :url "tracks/samples/breaks/amen.wav" :slices 8 :length_beats 16 :transpose 2 :gain 0.1)
  :warrior-comp
)

(live_loop :warrior_loop
  (each [n s] (P 
    [
      0
      0
      0
      (pick (uclid 2 3 8) (uclid 1 3 8))
      0 
      2
      0
      (pick (uclid 4 3 8) [0 1 2 (rep (pick 0 1 2 3 4) (pick 16 8))])
    ] 32
  ) 
    (play n (pick :amen) :dur s)
    (sleep s)
  )
)


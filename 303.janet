(bpm 160)

(use-lib "tracks/utils.janet")

(chain 
  (tb303 :teeb :gain 0.8002 :cutoff 40 :resonance 0.1783 :envMod 0.06324 :decay 0.3189 :attack 0.00307 :slide 0.03593)
  (distortion :teeb-stort :amount 750 )
  (gain :teeb-level :gain 1.738)
  (scope :teeb-scope)
  (reverb :teeb-verb :wet-dry -0.96)
  :out
)

(live_loop :teeb-player
  (seed 19)
#  (seed 100)
  (for i 0 24
    (play (pick :d3 :d2 :d2 :d2 :eb3 :d4) :teeb :dur (pick 0.1 0.1 0.1 -0.1))
    (change :teeb :envMod (+ 0.01 (pick 0.01 0.01 0.01 0.05)) :dur 0.1)
    (sleep 0.5)
  )
)

(sweep :teeb :cutoff [200 5000] 64)

(chain 
  (sample :pads :url "tracks/samples/deep.wav" :pitch :a4)
  (gain :pad-gate)
  (reverb :pad-verb)
  (biquad :pad-shimmer :filter_type "peaking")
  (gain :pad-level)
  (scope :pad-scope)
  :out
)

'(live_loop :pads
  (sleep (til 16))
  (each [n s] (P 
    [
      :a4 :tie :tie :tie 
      :c5 :tie :g4 :tie 
    ] 16
  ) 
    (play n :pads :dur s)
    (sleep s)
  )
)


(chain 
  (breakbeat :levee :url "tracks/samples/breaks/levee.wav" :slices 8 :length_beats 8 :transpose 2)
  (biquad :levee-f :filter_type "lowpass" :frequency 58.43)
  :out
)

(live_loop :levee
  (sleep (til 8))
  (each [n s] (P 
    [
      0
    ] 8 
  ) 
    (play n (pick :levee) :dur s)
    (sleep s)
  )
)

'(chain 
  (breakbeat :amen :url "tracks/samples/breaks/amen.wav" :slices 8 :length_beats 16 :transpose 2 :gain 2.5)
  (biquad :amen-filter :filter_type "lowpass" :frequency 323.8)
  (scope :amen-scope)
  (distortion :hii)
  (compressor :amen-pressor :release 0.05 :attack 0.003 :ratio 12 :knee 32.6 :threshold -22.5)
  :out
)

'(live_loop :warrior_loop
  (sleep (til 32))
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


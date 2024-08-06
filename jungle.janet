(bpm 180)

(chain 
  (breakbeat :gras "tracks/break.wav" 8 8)
  (compressor :gras-comp)
  (biquad :gras-filter "highpass")
  (gain :gras-gain)
  :out
)

(chain
  (synth :bass "sine")
  :out
)

(live_loop :jungles
  (each [n s] (P [
    [:rest 1 (pick 1 :tie 2) 1 :tie 1 :tie (pick :tie :tie 2)]
    [1 :tie 0 (pick 1 :tie) :tie 1 :tie 3]
    (pick (uclid [1 :rest] 3 8) (uclid [1 :tie] 5 8))
    [0 :tie [1 1] 1 :rest 1 (pick :tie (rep 2 8)) 1]
  ] 16)
    (play n :gras :dur s)
    (sleep s)
  )
)

(live_loop :bass
  (each [n s] (P [
    [:C3 :tie :F2 :Bb2]
    [:C3 :tie :F2 :Bb2]
    [:C3 :tie :F2 :Bb2]
    [:C3 :tie :F2 [:Bb2 :tie :tie :Cs3]]
    ] 64)
    (play (- (note n) 12) :bass :dur s)
    (sleep s)
  )
)


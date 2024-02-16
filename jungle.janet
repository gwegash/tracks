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
    [0 nil (pick 1 nil 2) 1 nil 1 nil (pick nil nil 2)]
    [1 nil 0 (pick 1 nil) nil 1 nil 3]
    (pick (euclid 8 3) (euclid 8 5))
    [0 nil [1 1] 1 nil 1 (pick nil (rep 2 8)) 1]
  ] 16)
    (play (+ 4 n) :gras :dur s)
    #(play (+ (pick 2 6 0) n) :gras :dur s)
    (sleep s)
  )
)

(live_loop :bass
  (each [n s] (P [
    [:C3 nil :F2 :Bb2]
    [:C3 nil :F2 :Bb2]
    [:C3 nil :F2 :Bb2]
    [:C3 nil :F2 [:Bb2 nil nil :Cs3]]
    ] 64)
    (play (- (note n) 12) :bass :dur s)
    (sleep s)
  )
)

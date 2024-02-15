(chain 
  (sample :piano "local://148602__neatonk__piano_med_c5.wav" :C5)
  (compressor :piano-comp)
  :out
)

(live_loop :piano-player
  (def chord (timesel [
    [0 4 7 12 16] 
    [0 2 9 14 17] 
    [-1 2 7 14 17] 
    [0 4 7 12 16] 
    [0 4 9 16 21] 
    [0 2 6 9 14] 
    [-1 2 7 14 19] 
    [-1 0 4 7 12] 
    [-3 0 4 7 12] 
    [-10 -3 2 6 12] 
    [-5 -1 2 7 11] 
    [-5 -2 4 7 13] 
    [-7 -3 2 9 14] 
    [-7 -4 2 5 11] 
    [-8 -5 0 7 12] 
    [-8 -7 -3 0 5] 
    [-10 -7 -3 0 5] 
    [-17 -10 -5 -1 5]
    [-12 -8 -5 0 4] 
    [-12 -5 -2 0 4] 
    [-19 -7 -3 0 4] 
    [-18 -12 -3 0 3] 
    [-17 -9 -1 0 3] #two wrong chords?
    [-15 -7 -1 0 2] 
    [-17 -7 -5 -1 2] 
    [-17 -8 -5 0 4] 
    [-17 -10 -5 0 5] 
    [-17 -10 -5 -1 5] 
    [-17 -9 -3 0 6] 
    [-17 -8 -5 0 7] 
    [-17 -10 -5 0 5] 
    [-17 -10 -5 -1 5] 
    [-24 -12 -5 -2 4] 
    [-24 -12 -3 0 5] 
    [-24 -12 -7 -4 2] #[-24 -12 -7 -4 2]#  
    [-24 -12 -8 -5 0]
  ] 16))
  (each [n s] (P [0 1 2 3 4 2 3 4] 4)
    (play (+ (get chord n) (note :C4)) :piano :dur 8)
    (sleep s)
  )
)

(chain 
  (breakbeat :gras "local://kidnplay [2024-01-30 112434].wav" 8 8)
  (compressor :gras-comp)
  (biquad :gras-filter "highpass")
  (gain :gras-gain)
  :out
)

(live_loop :jungles
  (each [n s] (P [
    [0 nil (pick 1 nil 2) 1 nil 1 nil (pick nil nil (rep 8 1))]
    [1 nil 0 (pick 1 nil) nil 1 nil 3]
    (pick (euclid 8 3) (euclid 8 5))
    [0 nil [1 1] 1 nil 1 nil (rep 1 4)]
  ] 16)
    (play (+ 4 n) :gras :dur s)
    (play (+ (pick 2 6 0) n) :gras :dur s)
    (sleep s)
  )
)

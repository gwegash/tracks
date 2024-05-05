


(live_loop :organ-player
  (each [p s] (P [0 nil nil nil 0 nil nil 1 nil nil 1 nil nil 1 nil nil] 4)
    (def chordPairs [
      [[:D3 :F3 :A3 :C4 :E4] [:D3 :F3 :A3 :C4 :D4]]
      [[:D3 :F3 :A3 :C4 :E4] [:D3 :F3 :A3 :C4 :D4]]
      [[:A2 :G3 :C4 :E4] [:Bb2 :A3 :D4 :F4]]
      [[:G2 :G3 :Bb3 :D4 :F4] [:C3 :G3 :Bb3 :Cs4 :E4]]
      [[:D3 :F3 :A3 :C4 :E4] [:D3 :F3 :A3 :C4 :D4]]
      [[:D3 :F3 :A3 :C4 :E4] [:D3 :F3 :A3 :C4 :D4]]
      [[:A2 :G3 :C4 :E4] [:Bb2 :A3 :D4 :F4]]
      [[:E3 :E4 :G4 :B4 :D5] [:Eb3 :Eb4 :G4 :Bb4 :D5]]
    ])
    (def c (map note (get (timesel chordPairs 4) p )))
    (play c :korgan :dur s)
    (play c :piano :dur s)
    (sleep s)
  )
)

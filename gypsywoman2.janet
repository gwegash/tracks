(chain 
  (sample :piano "local://Acoustic Piano - Piano 16 064L.wav" :E3 )
  (scope :organ)
  :out
)

(chain 
  (sample :korgan "local://Perc Organ - Organ 2 064L.wav" :E3 )
  (scope :keys)
  :out
)

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
    (play c :korgan :dur (* s 0.85))
    (play c :piano :dur (* s 0.85))
    (sleep s)
  )
)

(chain 
  (drums :lol 
    "local://BD A 808 Decay C 04.wav"
    "local://CH Combo 808.wav"
    "local://Clap A 808 Tape.wav" 
    "local://OH 808 Decay 05.wav"
  )
  (compressor :comp)
  (distortion :korgan-dist 10)
  (gain :drums-gain)
  (scope :bbscope)
  :out
)

(live_loop :drum
  (each [p s] (P [0 0 0 0] 4)
    (play p :lol :dur 2)
    (sleep s)
  )
)

(live_loop :drumclaps
  (sleep 1)
  (play [2] :lol :dur 2)
  (sleep 1)
)

(live_loop :hh
  (sleep 0.5)
  (play [3] :lol :dur 2)
  (sleep 0.5)
)

(chain 
  (breakbeat :bb "local://James Brown - Funky Drummer [2024-01-30 103836].wav" 4 4)
  (scope :bbscopes)
  :out
)

(chain 
  (breakbeat :pella "local://Crystal Waters - Gypsy Woman (She's Homeless) [Acapella] (256).mp3" 325 325)
  (biquad :vocs-f "highshelf")
  (scope :claps)
  #(Dlay :vocs-d 0.25)
  :out
)

(live_loop :bb
  (play 0 :bb :dur 4)
  (sleep 4)
)

(live_loop :vocals
  #(play (timesel (range 0 325) 1) :pella :dur 1)
  (sleep 1)
)

(live_loop :ch
  (each [p s] (P [1 nil nil nil 1 nil nil 1 1 1 nil nil 1 nil nil nil] 4)
    (play p :lol :dur 2)
    (sleep s)
  )
)


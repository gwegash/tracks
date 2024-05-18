(chain 
  (sample :piano "local://Acoustic Piano - Piano 16 064L.wav" :E3 )
  (scope :keys)
  (panner :pan-organ)
  :out
)
#
(chain 
  (sample :korgan "local://Perc Organ - Organ 2 064L.wav" :E3 )
  (panner :pan-keys)
  (scope :organ)
  :out
)

(live_loop :organ-player
  (each [p s] (P [0 [0 nil nil 1] [nil nil 1 nil] [nil 1 nil nil]] 4)
    (def chordPairs [
      [[:A2 :G3 :C4 :E4] [:Bb2 :A3 :D4 :F4]]
      [[:G2 :G3 :Bb3 :D4 :F4] [:C3 :G3 :Bb3 :Cs4 :E4]]
      [[:D3 :F3 :A3 :C4 :E4] [:D3 :F3 :A3 :C4 :D4]]
      [[:D3 :F3 :A3 :C4 :E4] [:D3 :F3 :A3 :C4 :D4]]
      [[:A2 :G3 :C4 :E4] [:Bb2 :A3 :D4 :F4]]
      [[:E3 :E4 :G4 :B4 :D5] [:Eb3 :Eb4 :G4 :Bb4 :D5]]
      [[:D3 :F3 :A3 :C4 :E4] [:D3 :F3 :A3 :C4 :D4]]
      [[:D3 :F3 :A3 :C4 :E4] [:D3 :F3 :A3 :C4 :D4]]
    ])
    
    (def c 
      (->> (get (timesel chordPairs 4) p) 
        (map note)
        (map (fn [x] (+ x (rand -0.05 0.05))))
    ))
    (play c :korgan :dur (* s 0.85))
    (play c :piano :dur (* s 0.85))
    (sleep s)
  )
)

(chain 
  (drums :lol 
    "local://BD 909 Tape Medium F 04.wav"
    "local://CH 909 Clean 01.wav"
    "local://Clap 909 Clean.wav"
    "local://OH 909 Clean 01.wav"
  )
  (gain :drums-gain)
  (panner :pan-drums)
  (scope :bbscope)
  :out
)

(live_loop :drum
  (each [p s] (P [0 3 @[0 2] 3 0 3 @[0 2] 3] 4)
    (play p :lol :dur 2)
    (sleep s)
  )
)

(chain 
  (breakbeat :bb "local://James Brown - Funky Drummer [2024-01-30 103836].wav" 4 4)
  (scope :bbscopes)
  (panner :pan-bb)
  :out
)

(chain 
  (drums :pella "local://verse.wav" "local://loop.wav" "local://ooh.wav")
  (gain :vocs-g)
  (biquad :vocs-f "highshelf")
  (Dlay :dlay-vocs 1.5)
  (scope :claps)
  :out
)

(chain :vocs-f :out)

(live_loop :bb
  (play 0 :bb :dur 4)
  (sleep 4)
)

(live_loop :vocals
  (sleep (- 32 (mod (time) 32)))
  (sleep 0.55)
  (play 0 :pella :dur 55)
  (sleep 51.45)
  (for i 0 18
    (sleep 3)
    (play 1 :pella :dur 4)
    (sleep 1)
  )
  (sleep 4)
  (for i 0 8
    (sleep 2.5)
    (play 2 :pella :dur 4)
    (sleep 1.5)
  )
)

(live_loop :ch
  (each [p s] (P [1 [[1 nil] [nil nil 1]] [[1 nil 1] [nil nil]] 1] 4)
    (play p :lol :dur 2)
    (sleep s)
  )
)

(chain 
  (sample :korgan "tracks/korgan_e3.wav" :E3 )
  (panner :pan-keys)
  (scope :organ)
  :out
)

(live_loop :organ-player
  (each [p s] (P [0 [0 :tie :tie 1] [:tie :tie 1 :tie] [:tie 1 :tie :tie]] 4)
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
    (sleep s)
  )
)

(chain 
  (drums :lol 
    "tracks/samples/909_bd.wav"
    "tracks/samples/909_ch.wav"
    "tracks/samples/909_clap.wav"
    "tracks/samples/909_oh.wav"
  )
  (gain :drums-gain)
  (panner :pan-drums)
  (scope :bbscope)
  :out
)

(live_loop :drum
  (each [p s] (P [0 3 0 3 0 3 0 3] 4)
    (play p :lol :dur 2)
    (sleep s)
  )
)

(live_loop :clap
  (sleep 1)
  (play 2 :lol :dur 2)
  (sleep 1)
)

(live_loop :ch
  (each [p s] (P [1 [[1 :rest] [:rest :rest 1]] [[1 :rest 1] [:rest :rest]] 1] 4)
    (play p :lol :dur 2)
    (sleep s)
  )
)

(bpm 185)

(chain 
  (line_in :aa)
  
  (gain :cutout)
  (looper :hi-loop :loop_time 168)
  (gain :aaa-g :gain 45.0)
  (scope :aaa-s)
  (compressor :comp-e)
  (reverb :lol-verb :decay_time 5.0 :wet-dry 0.4)
  (gain :post-comp :gain 2.0)
  :out
)
(chain 
  (sample :piano :url "https://raw.githubusercontent.com/tidalcycles/dirt-samples/main/crow/000_crow.wav" :pitch :d5)
  (reverb :aaa)
  (compressor :piano-comp)
  :out
)

(def notes [
[:db5 :rest :rest :rest]
[:rest :rest :b4 :rest]
[:bb4 :rest :rest :rest]
[:rest :b4 :rest :d5]
[:rest :rest :rest :rest]
[:rest :rest :rest :db5]
[:rest :rest :rest :rest]
[:rest :rest :rest :rest]
[:rest :rest :rest :e5]
[:rest :d5 :rest :db5]
[:rest :d5 :rest :e5]
[:rest :gb5 :rest :gb5]
[:rest :rest :rest :rest]
[:rest :rest :rest :rest]
[:e5 :rest :rest :rest]
[:rest :a5 :rest :db6]
[:rest :rest :rest :rest]
[:rest :b5 :rest :e6]
[:rest :eb6 :rest :d6]
[:rest :db6 :rest :a5]
[:rest :rest :rest :rest]
[:rest :rest :rest :b5]
[:rest :rest :rest :rest]
[:rest :rest :rest :rest]
[:gb5 :gb5 :rest :gb5]
[:gb5 :rest :gb5 :gb5]
[:rest :gb5 :gb5 :rest]
[:rest]
[:gb5 :gb5 :rest :gb5]
[:gb5 :rest :gb5 :gb5]
[:rest :gb5 :gb5 :rest]
[:rest]
[:db5 :rest :rest :rest]
[:rest :rest :b4 :rest]
[:bb4 :rest :rest :rest]
[:rest :b4 :rest :d5]
[:rest :rest :rest :rest]
[:rest :rest :rest :rest]
[:rest :db5 :rest :c5]
[:rest :db5 :rest :e5]
[:rest :rest :rest :rest]
[:rest :d5 :rest :db5]
[:rest :d5 :rest :e5]
[:rest :gb5 :rest :gb5]
[:rest :rest :rest :rest]
[:rest :rest :rest :e5]
[:rest :rest :rest :rest]
[:rest :rest :rest :rest]
[:a5 :ab5 :rest :g5]
[:rest :d5 :rest :a5]
[:rest :ab5 :rest :g5]
[:rest :rest :rest :rest]
[:e5 :eb5 :rest :d5]
[:rest :a4 :rest :e5]
[:rest :eb5 :rest :d5]
[:rest :rest :rest :rest]
[:a5 :ab5 :rest :g5]
[:rest :d5 :rest :a5]
[:rest :ab5 :rest :g5]
[:rest :rest :rest :rest]
[:gb5 :gb5 :rest :g5]
[:g5 :rest :e5 :e5]
[:rest :gb5 :gb5 :rest]
[:rest :rest :rest :rest]
[:a5 :a5 :rest :b5]
[:b5 :rest :g5 :g5]
[:rest :a5 :a5 :rest]
[:rest :rest :rest :rest]
[:rest :b4 :g4 :b4]
[:d5 :b4 :d5 :gb5]
[:d5 :gb5 :a5 :gb5]
[:a5 :db6 :d6 :b5]
[:rest :rest :rest :rest]
[:rest :rest :rest :rest]
[:rest :rest :rest :rest]
[:rest :rest :rest :rest]
[:gb5 :gb5 :rest :gb5]
[:gb5 :rest :gb5 :gb5]
[:rest :gb5 :gb5 :rest]
[:rest]
[:gb5 :gb5 :rest :gb5]
[:gb5 :rest :gb5 :gb5]
[:rest :gb5 :gb5 :rest]
[:rest]
])

(live_loop :piano-player
  (sleep (til 168))
  (for i 0 2
    (each [n s] (P notes (* (length notes) 2))
      (play n :piano :dur s)
      (if (not (= n :rest))
        (do 
          (play (+ n 12) :piano :dur s)
          (play (- n 12) :piano :dur s)
        )
      )
      (sleep s)
    )
  )
  (sleep 168)
)

(chain
  (breakbeat :hi :url "tracks/samples/loops/shaker.wav" :length_beats 8 :slices 2)
  :out
)

(chain 
  (sample :clave :url "tracks/samples/instruments/fx_drum/rim.flac" :pitch :c3)
  (gain :ge :gain 5.0)
  :out
)
( def clave [:c3 :tie :tie :c3 :tie :tie :c3 :tie :tie :tie :c3 :tie :c3 :tie :tie :rest])

(live_loop :clave
  (pp (- 168 (mod (time) 168)))
  (sleep (til 8))
  (each [n s] (P (pick clave clave (reverse clave)) 8)
    (play n :clave :dur 2)
    (sleep s)
  )
)

(live_loop :aaas
  (play [0 1] :hi :dur 4)
  (sleep 2)
)

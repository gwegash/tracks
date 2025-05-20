(bpm 60)
(chain
  (sample :haha :url "tracks/samples/instruments/mandolin/e5.wav" :pitch :e5)
  (reverb :verb)
  :out
)

'(live_loop :hiya
  (def c (timesel [] 8))
  (for i 0 5
    (def n ((scale :c3 :major) (+ i (pick 3 i 0 0 0 2 7 6))))
    (play (- n 12) :haha :dur 8)
    (play n :haha :dur 8)
    (sleep (rand 1 4))
  )
  #(sleep (rand 4 12))
)

'(live_loop :hiya-2
  (def n ((chord :c5 :sus4) (timesel [3 2 1 0] 1)))
  (play n :haha :dur 8)
  (play (- n 12) :haha :dur 8)
  (sleep (rand 0.5 4))
  #(sleep (rand 4 12))
)

(chain
  (sample :cell :url "tracks/samples/instruments/cello/a3_sustain.wav" :pitch :a3)
  (gain :cell-g)
  (panner :c-pan)
  (reverb :cello-verb)
  :out
)

(live_loop :cello-apnner
  (sleep 9)
  (lin :c-pan :pan (rand -0.3 0.3))
)

(live_loop :cello
#  (play :c2 :cell :dur 9)
#  (play :c3 :cell :dur 9)
#  (play :c4 :cell :dur 9)
#  (play :f4 :cell :dur 9)
#  (play :d4 :cell :dur 9)
#  (play :g4 :cell :dur 9)
  (sleep 5)
)

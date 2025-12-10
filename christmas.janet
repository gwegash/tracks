
(bpm 167)

(chain 
  (breakbeat :amen :url "tracks/samples/breaks/amen.wav" :length_beats 16 :slices 16 :gain 4.0)
  (distortion :amen-stort :amount 20)
  (biquad :amen-filter :filter_type "bandpass")
  #(Dlay :funky-lay :delay_time 0.04)
  (panner :funky-pan)
  (scope :funky-s)
  :out
)

(chain 
  (breakbeat :mardis :url "tracks/samples/breaks/mardis_gras.wav" :length_beats 16 :slices 16 :gain 5.0)
  (distortion :mardis-stort :amount 20)
  :funky-pan
)

(chain 
  (breakbeat :funky :url "tracks/samples/breaks/helicopter.wav" :length_beats 8 :slices 16 :gain 1.8)
  :funky-pan
)

(chain 
  (keyboard :lol)
  (drums :sfx :hits [
    "tracks/samples/fx/hl/sci_dis.wav"
    "tracks/samples/fx/hl/cantbeworse.wav"
    "tracks/samples/fx/hl/scream2.wav"
    "tracks/samples/fx/hl/tunedtoday.wav"
  ])
  :out
)

(live_loop :break_player
  (def drum_seq [;(rep 0 7) (pick 0 1 1 2 2 3)])
  (sleep (til 16))
  (each [n s] (P [
    (pick 3 (uclid (pick 6 2) 3 8))
    
    #[:rest [(rep 0 8)]]
    (pick (uclid 2 3 8) (uclid (pick 6 2) 3 8))
    (uclid (pick 2 3 3 4) 3 8)
    
    (pick 
      3 
      (uclid (pick 6 2) 3 8)
      #[(pick :rest :rest [6 6] :tie) [(rep 0 4) (rep 2 4)]]
      #[:rest [(rep 0 8) (rep 2 16) (rep 2 32) (rep 2 64)]]
    )
  ] 16)
    #(def drum_seq [2])
    (case (timesel drum_seq 4)
      0 (play n :funky :dur s)
      1 (play n :amen :dur s)
      2 (play 0 :mardis :dur s)
      3 (play n :funky :dur (* s 0.25))
    )
    #(if (not (= n :rest))
#    (play n :drummer :dur s)
    #)
    (sleep s)
  )
)

(chain 
  (sample :bass :url "local://156502__unfa__wild-stereo-sub.wav" :pitch :f2 :attack 0.005 :release 0.6)
  (distortion :bass-stort :amount 7)
  (compressor :bass-comp :release 0.1 :threshold -34)
  (gain :bass-gain)
  (scope :bass-scope)
  :out
)

(def first  [:c4 :tie :tie :c4 :tie :tie :c4 :tie :tie :tie :c4 :tie :cs4 :tie :cs4 :tie])
(def second [:g4 :tie :tie :g4 :tie :tie :g4 :tie :d4  :tie :tie :d4 :tie :tie :d4  :tie])
(def half [:c4 :tie :tie :c4 :tie :tie :c4 :tie :tie :tie :tie :tie :tie :tie :tie :tie])
(def penul [:rest])

(def deck [:g5 [:tie :f5] :e5 :d5 :c5 :d5 :e5 :c5 [:d5 :e5] [:f5 :d5] :e5 [:tie :d5] :c5 :b4 :c5 :tie])

(live_loop :bass-loop
  (def pat (timesel [first second first second first second first second] 4))
  #(def pat (timesel [deck] 4))
  (each [n s] (P pat 8)
    (play (- n 27) :bass :dur (* s 0.75))
    (sleep s)
  )
)

(chain 
  (breakbeat :santa :url "local://santa_loop_1.flac" :slices 32 :length_beats 16)
  (biquad :santa-filter :filter_type "highpass" :frequency 1500 :Q 7.0)
  (gain :santa-gain :gain 3.0)
  :out
)

(live_loop :santas
  (match (timesel [0 0 2 ;(rep 3 4) 0] 8)
    0 (do
      (sleep (- (til 8) 0.67))
      (play 0 :santa :dur 8)
      (sleep 8)
    )
    1 (do
      (play 10 :santa :dur 3)
      (sleep 3)
    )
    2 (do
      (sleep (- (til 8) 0.67))
      (play 16 :santa :dur 8)
      (sleep 8)
    )
    3 (do
      (sleep (- (til 8) 0.67))
      (sleep 8)
    )
  )
)

(chain
  (keyboard :stabber)
  (sample :stab :url "local://SS_RS_22_Brazil.wav" :pitch :c4 )
  :out
)

(live_loop :stabbings
  (def pat (timesel [first second first second first second first penul] 4))
  (each [n s] (P pat 4)
    (play n :stab :dur s)
    (sleep s)
  )
)

(chain 
  (breakbeat :jingle :url "local://jingle_bells.flac" :slices 8 :length_beats 16)
  (gain :hard-gain :gain 2.0)
  :out
)

(chain 
  (breakbeat :joy :url "local://joy_to_the_world.flac" :slices 8 :length_beats 16)
  :hard-gain
)

(live_loop :hark
  '(each [n s] (P (uclid 4 5 16) 8)
    (play (pick 0 2 4) :jingle :dur s)
    (sleep s)
  )
  (do 
    (play 0 :joy :dur 16)
    (sleep 16)
  )
)

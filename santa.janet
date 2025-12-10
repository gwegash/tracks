(bpm 167)

(chain 
  (breakbeat :amen :url "tracks/samples/breaks/amen.wav" :length_beats 16 :slices 16 :gain 4.0)
  (distortion :amen-stort :amount 20)
  (biquad :amen-filter :filter_type "bandpass" :frequency 3000 :Q 0.18)
  #(Dlay :funky-lay :delay_time 0.04)
  (panner :funky-pan)
  (scope :funky-s)
  (gain :drum-gain)
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
  (sample :bass :url "tracks/samples/instruments/sub.wav" :pitch :f2 :attack 0.005 :release 0.6)
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
(def deck2 [:d5 :tie :tie :e5 :f5 :tie :d5 :tie :e5 :tie :tie :f5 :g5 :tie :d5 :tie])
(def deck3 [:e5 :f5 :g5 :tie :a5 :b5 :c6 :tie :b5 :tie :a5 :tie :g5 :tie :tie :tie])

(live_loop :bass-loop
  (def pat (timesel [first second first second first second first second] 4))
  #(def pat (timesel [deck deck deck2 deck3] 8))
  (each [n s] (P pat 4)
    (play (- n 27) :bass :dur (* s 0.75))
    (sleep s)
  )
)

(chain 
  (breakbeat :santa :url "tracks/samples/vocals/santa_loop1.flac"  :slices 32 :length_beats 16)
  (biquad :santa-filter :filter_type "highpass" :frequency 1500 :Q 7.0)
  (gain :santa-gain :gain 4.5)
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
  (sample :stab :url "tracks/samples/instruments/rave_stab1.wav" :pitch :c4 )
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
  (breakbeat :jingle :url "tracks/samples/vocals/jingle_bells.flac" :slices 8 :length_beats 16)
  (gain :hard-gain :gain 2.0)
  :out
)

(chain 
  (breakbeat :joy :url "tracks/samples/vocals/joy_to_the_world.flac" :slices 8 :length_beats 16)
  :hard-gain
)

(live_loop :hark
  (each [n s] (P [;(rep (uclid 4 5 16) 3) [[4 4] 3 5 5 6 5 :tie (rep (pick 3 3 4 5 6 1) (pick 2 4 4))]] 32)
  #(each [n s] (P (uclid 4 5 16) 8 )
    (play (pick 0 2 4) :jingle :dur s)
    (sleep s)
  )
  '(do 
    (play 0 :jingle :dur 16)
    (sleep 16)
  )
)


(chain (compressor :comp) :out)
(chain 
  (synth :saw :wave "sawtooth" :release 0.03)
  (ladder :sawder :Q 0.5)
  (distortion :sawder-dist :amount 700)
  (panner :paan)
  (reverb :hii :wet-dry 0.7)
  (gain :synth_level :gain 1.67)
  (scope :hi-scope)
  :out
)

(chain 
  (constant :cutoff)
  (gain :env)
)
(wire :env :sawder :cutoff)

(def env_lo 4)
(def env_hi 5000.0)
(def note_len 0.25)
(def env_atk 0.02)
(def env_sus 0.25)
(def env_rel 0.2)

(live_loop :tb303
  (seed 3)

  (def s (scale :c2 :flamenco))
  (for i 0 14 
    
    (itarget :paan :pan 0.4)
    (exp :env :gain (rand 0.001 0.1))
    (if (pick true true true false)
      (do
        (def n (s (pick 0 0 7 0 7 ;(range 0 12))))
        (play n :saw :dur (* 0.7 note_len))
        (play (- n 12) :saw :dur (* 0.5 note_len))
        (if (pick true false false false)
          (change :sawder :cutoff (rand 200 220))
        )
      )
    )
    (sleep (* note_len env_atk))
    (exp :env :gain (rand 0.5 1.0))
    (sleep (* note_len env_sus))
    (sleep (* note_len env_rel))
    (exp :env :gain (rand 0.001 0.1))
    (exp :cutoff :constant (rand 50 1000))
    (sleep (til note_len))
  )
  
  (exp :sawder :cutoff (timesel [700 900 1100 1300 1800 3000] 8))
)

'(live_loop :q-changer
  (sleep 32)
  (lin :sawder :Q (pick 0.6 0.7 0.8 0.9 0.92))
)

(chain
  (keyboard :s-k)
  (drums :electro :hits [
    "tracks/samples/hedonics/808BD2.flac"
    "tracks/samples/hedonics/808BD3.flac"
    "tracks/samples/hedonics/808CH1.flac"
    "tracks/samples/hedonics/808CH2.flac"
    "tracks/samples/hedonics/808CH3.flac"
    "tracks/samples/hedonics/808SD4.flac"
    "tracks/samples/hedonics/808SD5.flac"
  ])
  (compressor :electro-conp :threshold -15.0 :ratio 17.0 :attack 0.01)
  #(biquad :b-f :type "lowpass" :frequency 7200)
  (gain :electro-gain :gain 3.00)
  (distortion :eee :amount 10)
  (gain :eeeg :gain 10.0)
  (reverb :electro-verb :wet-dry 0.58)
  :comp
)

(live_loop :hhs
  (seed 2)
  (for i 0 8
    (play (pick 2 3 4) :electro :dur 0.1)
    (sleep 0.25)
  )
)

(chain 
  (breakbeat :warrior :url "tracks/samples/loops/warrior.flac" :slices 32 :length_beats 4 :gain 0.02)
  (biquad :warrior-f :filter_type "bandpass" :frequency 1600 :Q 0.4)
  (distortion :warrior-dist :amount 100)
  :electro-conp
)

(live_loop :warrior_player
  (play 0 :warrior :dur 4)
  (sleep 4)
)

(live_loop :bdsn
  (sleep (til 16))
  (def fill [(pick 1 [:rest 5]) (pick [:rest :rest 5 5] (rep [5 (pick :rest :tie)] 4))]) # The last two beats of an 4 bar section
  (each [n s] (P [
    ;(rep [[1 (pick 0 :rest) :rest :rest] (pick 5 6) [:tie 1] 5] 7) # Repeat the basic electo beat 3 times
    [[1 0 :rest :rest] 5 ;fill]               
  ] 32)
    (play n :electro :dur s)
    (sleep s)
  )
)


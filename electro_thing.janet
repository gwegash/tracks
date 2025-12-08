(bpm 140)

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
    (change :paan :pan (rand -0.4 0.4))
    
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

(live_loop :q-changer
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
  (biquad :b-f :type "lowpass" :frequency 5000)
  (gain :electro-gain :gain 3.00)
  (distortion :eee :amount 10)
  (gain :lol :gain 10.0)
  (reverb :electro-verb :wet-dry 0.58)
  :comp
)

(live_loop :hhs
  (seed 2)
  (for i 0 8
    (change :electro-gain :gain (rand 1.0 3.0))
    (play (pick 2 3 4) :electro :dur 0.1)
    (sleep 0.25)
  )
)

(chain 
  (breakbeat :warrior :url "tracks/samples/loops/warrior.flac" :slices 32 :length_beats 4 :gain 0.08)
  (biquad :warrior-f :filter_type "bandpass" :frequency 2700)
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


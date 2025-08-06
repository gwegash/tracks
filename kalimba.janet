(chain
  (line_in :hello)
  (gain :ge)
  (scope :hi-s)
  (Dlay :hi-lay :delay_time 0.04)
  (biquad :lol :filter_type "peaking")
  (reverb :hello-verb)
  (gain :post-g)
  :out
)

(chain 
  (keyboard :kalim)
  (drums :kalim-hits :hits [
    "tracks/samples/instruments/kalimba/1.flac"
    "tracks/samples/instruments/kalimba/2.flac"
    "tracks/samples/instruments/kalimba/3.flac"
    "tracks/samples/instruments/kalimba/4.flac"
    "tracks/samples/instruments/kalimba/5.flac"
    "tracks/samples/instruments/kalimba/6.flac"
    "tracks/samples/instruments/kalimba/7.flac"
  ])
  (reverb :kalima-verb)
  (Dlay :kalima-lay)
  :out
)

(live_loop :delay_time_changer 
  (change :hi-lay :feedback 1.00)
  (sleep 15.25)
)

(live_loop :kalimba_player
  (sleep (til 4))
  (seed 4)
  (for i 0 9
    #(play (pick 0 2 3 4 5) :kalim-hits)
    #(sleep (pick 0.75 0.5))
    (play (pick 0 1 2 3 4 5 ) :kalim-hits)
    (sleep (pick 0.75 0.5 0.25))
  )
)

'(live_loop :filter_fixer
  (sleep (rand 32 64))
  (exp :lol :frequency (rand 5000 6000))
  (sleep (rand 32 64))
  (exp :lol :frequency (rand 300 500))
)

(chain 
  (drums :fx-hits :hits [
    "tracks/samples/fx/tom.flac"
    "tracks/samples/fx/woodblock.flac"
    ])
  (reverb :fx-verb)
  :out
)

'(live_loop :fx_player
  (play (pick 0 1 2 3) :fx-hits :dur 16)
  (sleep (rand 32 64))
)

(chain 
  (keyboard :drum-keys)
  (drums :drums :hits [
      "tracks/samples/instruments/fx_drum/kick.flac"
      "tracks/samples/instruments/fx_drum/woodblock.flac"
      "tracks/samples/instruments/fx_drum/clave.flac"
      "tracks/samples/instruments/fx_drum/rim.flac"
    ]
  )
  (gain :drum-gain)
  (Dlay :delay :delay_time 0.75)
  (reverb :drum-verb :decay-time 0.75)
  :out
)

(live_loop :drum_player_2
  (sleep (til 16))
  (each [n s] (P [
      [0 3 :rest 3]
      [:rest 3 :rest 3]
      [:rest 3 :rest 3]
      [:rest 3 :rest 3]
    ]
    16)
    (play n :drums)
    (sleep s)
  )
)

(chain 
  (sample :drone :url "tracks/instruments/dronemachine1.wav" :pitch :c2 :gain 0.2 :attack 1.0 :release 1.0 :loop_start 0.01 :loop_end 0.99)
  (Dlay :drone-lay :delay_time 0.75)
  (reverb :drone-verb :decay-time 2.00)
  :out
)

'(live_loop :drone
  (play (- :d2 0.1) :drone :dur 8)
  (sleep 4)
)


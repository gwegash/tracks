(bpm 167)

(chain 
  (breakbeat :funky :url "tracks/samples/breaks/helicopter.wav" :length_beats 8 :slices 16)
  #(breakbeat :funky :url "tracks/samples/breaks/amen.wav :length_beats 16 :slices 16)
  #(Dlay :funky-lay :delay_time 0.04)
  (panner :funky-pan)
  (scope :funky-s)
  :out
)

(chain 
  (keyboard :lol)
  (drums :sfx :hits [
    "https://hl1sfx.com/play/scientist/c1a0_sci_crit1a.wav"
  ])
  :out
)

(live_loop :break_player
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
    (play n :funky :dur s)
    #(if (not (= n :rest))
#    (play n :drummer :dur s)
    #)
    (sleep s)
  )
)

(chain 
  (breakbeat :ridim :url "tracks/samples/loops/riddim_intro.wav" :length_beats 64 :slices 64) 
  (biquad :butterfly-hi :filter_type "lowpass")
  (gain :ridim-gain :gain 2.0)
  (scope :butterfly-s)
  :out
)

(live_loop :loop_player
  (sleep (til 64))
  (play 0 :ridim :dur 64)
  (sleep 64)
)

(chain 
  (synth :bass :wave "sine" :release 0.07 :attack 0.001 :gain 0.42)
  (scope :bass-s)
  :out
)

(live_loop :bass
  (sleep (til 16))
  (each [n s] (P [
      [[:fs3 :tie :tie :fs3 :tie :tie :fs3 :tie] :tie]
      [[:fs3 :tie :tie :fs3 :tie :tie :cs3 :tie] 
        (pick 
          :tie 
          :tie
          #[:tie [:cs4 :cs4 :fs3 :cs3]]
          #[:tie [:cs4 :cs4 :cs4]]
        )
      ]
    ] 16)
    (play (- n 24.15) :bass :dur (* s 0.75))
    (play (- n 12.15) :bass :dur (* s 0.75))
    (sleep s)
  )
)
#



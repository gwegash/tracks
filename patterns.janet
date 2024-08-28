(bpm 100)

(chain 
  (keyboard :drums)
  (drums :909 :hits [
      "tracks/samples/909_bd.wav"
      "tracks/samples/909_ch.wav"
      "tracks/samples/909_clap.wav"
      "tracks/samples/909_oh.wav"
      "tracks/samples/909_rim.wav"
      "tracks/samples/909_sn.wav"
    ]
  )
  (scope :drum_scope)
  :out
)

(live_loop :drum_player
  (each [n s] (P [
      0 5 0 5
    ] 4)
    (play n :909 :dur 0.25)
    (sleep s)
  )
)

(live_loop :hi_hats
  (each [n s] (P (rep 1 4) 1)
    (play n :909 :dur 0.25)
    (sleep s)
  )
)

(bpm 167)

(chain 
  (breakbeat :funky :url "tracks/samples/breaks/helicopter.wav" :length_beats 8 :slices 16)
  (panner :funky-pan)
  (scope :funky-s)
  :out
)

(chain 
  (breakbeat :drummer :url "tracks/samples/breaks/funky.wav" :length_beats 4 :slices 8)
  (panner :dum-pan)
  (scope :dummer-s)
  :out
)

(live_loop :break_player
  (sleep (til 16))
  (each [n s] (P [
    (pick 0 (uclid (pick 2 0) 3 8))
    (uclid 0 3 8)
    (uclid (pick 2 3 3) 3 8)
    (pick :rest 0 0 [0 :tie [:tie :rest] (pick :rest (rep (pick 0 2) (pick 4 8)))])
  ] 16)
    (play n :funky :dur s)
    #(if (not (= n :rest))
    (play n :drummer :dur s)
    #)
    (sleep s)
  )
)

(chain 
  #(breakbeat :butterfly :url "tracks/samples/loops/intimate_friends.wav" :length_beats 16 :slices 4)
  #(breakbeat :butterfly :url "tracks/samples/loops/misdemeanor.wav" :length_beats 16 :slices 4)
  (breakbeat :butterfly :url "tracks/samples/loops/butterfly.wav" :length_beats 16 :slices 4)
  (biquad :butterfly-hi :filter_type "lowpass")
  (scope :butterfly-s)
  :out
)

(live_loop :loop_player
  (sleep (til 16))
  (play 0 :butterfly :dur 16)
  (sleep 16)
)

(chain 
  (sample :voc :url "tracks/samples/vocals/brownstone_short_2.wav" :pitch :c2)
  (gain :voc-g)
  (Dlay :aa :delay_time 1.5)
  :out
)

'(live_loop :voc_player
  (play :d2 :voc :dur 8)
  (sleep 8)
)

'(chain 
  (breakbeat :misde :url "tracks/samples/loops/misdemeanor.wav" :length_beats 16 :slices 4)
  (biquad :misde-hi :filter_type "lowpass")
  :out
)

'(live_loop :mide_player
  (play 0 :misde :dur 16)
  (sleep 16)
)

(chain 
  (synth :bass :wave "sine" :release 0.07)
  (scope :bass-s)
  :out
)

(live_loop :bass
  (sleep (til 16))
  (each [n s] (P [
      [[:cs1 :tie :tie :cs1 :tie :tie :d1 :tie] :tie]
      [[:b0 :tie :tie :b0 :tie :tie :cs1 :tie] (pick :tie :tie [:tie :tie :cs2 :cs1])]
    ] 16)
    (play n :bass :dur (* s 0.6))
    (sleep s)
  )
)
#

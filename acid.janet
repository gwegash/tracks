(bpm 140)
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
  (distortion :dist 10)
  (compressor :comp)
  (scope :bbscope)
  :out
)

(live_loop :hats
  (each [n s] (P [
    1 1 1 (pick ;(rep 1 4) [1 1]) # 4 times as likely to pick a regular ch, but sometimes does a little roll
  ] 1)
    (play n :909 :dur 0.25)
    (sleep s)
  )
)

(live_loop :bdsn
  (def fill [(pick 0 [:rest 5]) (pick [:rest :rest 5 5] (rep [5 (pick :rest :tie)] 4))]) # The last two beats of an 4 bar section
  (each [n s] (P [
    ;(rep [[0 0 :rest :rest] 5 [:tie 0] 5] 3) # Repeat the basic electo beat 3 times
    [[0 0 :rest :rest] 5 ;fill]               # Last time round add the fill for the last two beats
  ] 16)
    (play n :909 :dur s)
    (sleep s)
  )
)

# Something acidy
(chain 
  (synth :sinth :wave "sawtooth")
  (ladder :filter_lad :Q 0.7)
  (distortion :sinth_dist 100)
  (gain :sinth_mix)
  :out
)
(wire (constant :fmod) :filter_lad :cutoff)

(live_loop :sawtooth_player
  (seed 5)
  (for i 0 7
    (exp :fmod :constant (rand 400 2000))
    (play ((scale :d2 :hirajoshi) (pick ;(range 0 8))) :sinth :dur 0.1)
    (sleep 0.125)
    (exp :fmod :constant 200)
    (sleep 0.125)
  )
)

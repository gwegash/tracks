(bpm 180)

(chain 
  (breakbeat :help :url "tracks/samples/loops/cant_help_it_1.flac" :length_beats 16 :slices 64)
  #(breakbeat :help :url "tracks/samples/loops/cant_help_it_2.flac" :length_beats 16 :slices 64)
  #(breakbeat :help :url "tracks/samples/loops/cant_help_it_verse.flac" :length_beats 32 :slices 4)
  (biquad :help-low :filter_type "peaking" :frequency 120 :Q 0.5 :gain 10)
  (Dlay :hi-lay :delay_time 0.01)
  :out
)

(live_loop :player
  (sleep (til 16))
  (for i 0 64
    (if (pick true)
      (do (play i :help :dur 0.25) (sleep 0.25))
      (do (def n (pick 1 2 4))
        (for j 0 n (play i :help :dur (/ 0.25 n)) (sleep (/ 0.25 n))) 
      )
    )
  )
  #verse
  '(each [n s] (P [
     0#(rep 3 32)
     #1 #(pick 0 1)
     #2 #(pick 2 3) 
     #3 #(pick 0 3)
  ] 32)
    (play n :help :dur s)
    (sleep s)
  )
)

'(chain 
  (breakbeat :warrior :url "tracks/samples/loops/warrior.flac" :length_beats 4 :slices 8)
  (biquad :warrior-f :filter_type "highpass")
  :out
)

'(live_loop :drum-player
  (sleep (til 16))
  (each [n s] (P [
    (pick 0 [0 0] (uclid 2 3 8)) 
    0 
    (pick (uclid 2 3 8) 0)
    (pick (uclid 0 3 8) [;(pick (rep :rest 4) [0 :tie :tie 0 :tie :tie]) [(rep 3 2) (rep 2 4)] [(rep 0 8) (rep 1 16)]])
  ] 16)
    (if (and (= n 0) (pick true false false))
      (play n :warrior :dur 0.5)
    )
    #(play n :warrior :dur s)
    (sleep s)
  )
)

'(chain
  (drums :lol 
   :hits [
      "tracks/samples/909_bd.wav"
      "tracks/samples/909_ch.wav"
      "tracks/samples/909_clap.wav"
      "tracks/samples/909_oh.wav"
    ]
  )
  (gain :drums-gain)
  (panner :pan-drums)
  (scope :bbscope)
  :out
)

'(live_loop :drum
  (sleep (til 16))
  (each [p s] (P [
    [0 3 0 3 0 3 0 3]
    [0 3 0 3 (pick :rest 0 0) 3 0 3]
    [0 3 0 3 0 3 0 3]
    (pick [0 3 0 3 0 3 0 3] [0 3 0 3 0 3 0 (pick 3 [0 0] (rep 0 2) [:rest [1 1]])] 0)
  ] 16)
    (play p :lol :dur 2)
    (sleep s)
  )
)

'(live_loop :clap
  (sleep 1)
  (play 2 :lol :dur 2)
  (sleep 1)
)

'(live_loop :ch
  (each [p s] (P [1 [[1 :rest] [:rest :rest 1]] [[1 :rest 1] [:rest :rest]] 1] 4)
    (play p :lol :dur 2)
    (sleep s)
  )
)

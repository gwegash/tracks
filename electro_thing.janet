(bpm 100)

(chain 
  (sample :s :url "tracks/samples/hedonics/TIAKO24.flac" :pitch :gb3)
  (panner :s-pan)
  (reverb :s-verb :wet-dry 0.75)
  :out
)

(live_loop :s-player
  (seed 8)
  (for i 0 8
    (play ((scale :c3 :major_pentatonic) (pick ;(range 1 6))) :s :dur 0.05)
    (change :s-pan :pan (rand -0.3 0.3))
    (sleep (pick 0.25 0.75 1.5))
  )
)


'(chain 
  (sample :s-pad :url "tracks/samples/hedonics/breath.wav" :pitch 38.5 :attack 0.22 :release 0.22 :gain 0.25)
  (biquad :s-pad-f :type "lowpass" :frequency 2500 :q 4.5)
  (panner :s-pad-pan)
  :out
)

'(live_loop :pads
  (sleep (til 16))
  (each [n s] (P [:c3 :d3] 16)
    (play n :s-pad :dur s)
    (sleep s)
  )
)

'(live_loop :intros
  (sleep 32)
  (lin :s-pad-pan :pan (rand -0.5 0.5)) 
  (exp :s-pad-f :frequency 1200)
)

'(chain
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
  (compressor :electro-conp :threshold -50.0 :ratio 17.0 :attack 0.01)
  (biquad :b-f :type "lowpass" :frequency 4000)
  (gain :electro-gain :gain 3.00)
  (reverb :electro-verb :wet-dry 0.5)
  :out
)

'(live_loop :hhs
  (play (pick 2 3 4) :electro)
  (sleep 0.25)
)

'(live_loop :bdsn
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

'(chain
  (sample :bass-s :url "tracks/samples/hedonics/808BD7.flac" :pitch 27.9)
  :out
)

'(live_loop :bass-loop
  (sleep (til 8))
  (sleep 2)
  (each [n s] (P [:b1 :b1 :gb2 :db2 :db2] 3.75)
    (play n :bass-s :dur (- s .1))
    (sleep s)
  )
)

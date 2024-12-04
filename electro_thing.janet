(bpm 100)

(chain 
  (sample :s :url "local://Hedonics - RS INTL Sample Pack VIII- Eurorack Modular by Hedonics - 260 TIAKO24.flac" :pitch :gb3)
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

'(live_loop :s-player-2
  (seed 12)
  (for i 0 6
    (play ((scale :c3 :major_pentatonic) (pick ;(range 3 10))) :s :dur 0.12)
    (sleep (pick 0.75 1.5))
  )
)

(chain 
  (sample :s-pad :url "local://Breath (JW1).wav" :pitch 38.5 :attack 0.22 :release 0.22 :gain 0.25)
  (biquad :s-pad-f :type "lowpass" :frequency 2500 :q 4.5)
  (panner :s-pad-pan)
  :out
)

(live_loop :pads
  (sleep (til 16))
  (each [n s] (P [:c3 :d3] 16)
    (play n :s-pad :dur s)
    (sleep s)
  )
)

(live_loop :intros
  (sleep 32)
  (lin :s-pad-pan :pan (rand -0.5 0.5)) 
  (exp :s-pad-f :frequency 1200)
)

(chain
  (keyboard :s-k)
  (drums :electro :hits [
    "local://808BD2.flac"
    "local://808BD3.flac"
    "local://808CH1.flac"
    "local://808CH2.flac"
    "local://808CH3.flac"
    "local://808SD4.flac"
    "local://808SD5.flac"
  ])
  (gain :electro-gain :gain 0.75)
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

(chain
  (sample :bass-s :url "local://808BD7.flac" :pitch 27.9)
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

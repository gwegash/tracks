# Hello
# This is a little tour of the main features of trane
# Press Alt+Enter to start (⌥+Enter on Mac)
(chain 
  (breakbeat :gras "local://kidnplay [2024-01-30 112434].wav" 8 8)
  (compressor :gras-comp)
  (biquad :gras-filter "highpass")
  (gain :gras-gain)
  :out
)

(chain
  #(sample :rhodes "local://4191__realrhodessounds__d3.wav" :D3)
  #(sample :rhodes "local://Roland-PN-D10-01-Slow-Voices-C5.wav" :C4)
  (sample :rhodes "local://Roland-D-20-Rich-Piano-C4.wav" :C4)
  (biquad :pad-filter "lowpass")
  (compressor :pad-compressor)
  (gain :pad-gain)
  :out
)

(chain 
  #(breakbeat :loop-sample "local://o pato-1.wav" 16 16)
  #(breakbeat :loop-sample "local://triste-1.WAV" 8 8)
  (breakbeat :loop-sample "local://barrio_drum_2b_2.wav" 16 16)
  :out
)

(live_loop :sample-loop
  (play 0 :loop-sample :dur 16)
  (sleep 8)
)

(chain
  (synth :bass "sine")
  :out
)

(live_loop :padsa
  (each [n s] (P [
    [[:C3 nil nil (pick nil nil nil [:F2 :C3] [:Cs3 :C3] [:C4 :C3])] nil nil [(pick :Eb3 :Eb3 :F2) :Bb2]]
    ] 16)
    (play (chord n :m9) :rhodes :dur s)
    (play (- (note n) 24) :bass :dur s)
    (sleep s)
  )
)
(chain 
  (sample :choir "local://Phat Choir.wav" :C3)
  (biquad :choir-filter "peaking")
  (gain :choir-gain)
  :out
)

(live_loop :rhodes-lfos
  (for i 0 8
    (exp :pad-filter :frequency (lfo 1500 600 (/ 0.125 3)))
    (sleep (/ 0.125 3))
  )
)

(live_loop :choooir
  (play (pick :C3 :C4) :choir :dur 32)
  (sleep 4)
)

(live_loop :jungles
  (each [n s] (P [
    [0 nil (pick 1 nil 2) 1 nil 1 nil (pick nil nil (rep 8 1))]
    [1 nil 0 (pick 1 nil) nil 1 nil 3]
    (pick (euclid 8 3) (euclid 8 5))
    [0 nil [1 1] 1 nil 1 nil (rep 1 4)]
  ] 16)
    (play (+ 4 n) :gras :dur s)
    (play (+ (pick 2 6 0) n) :gras :dur s)
    (sleep s)
  )
)

#(live_loop :breaks-filter-sweep 
#  (target :gras-filter :frequency 100 0.001)
#  (target :pad-filter :frequency 100 0.0001)
#  (sleep 0.125)
#  (target :gras-filter :frequency 100 0.001)
#  (target :pad-filter :frequency (rand 10 12000) 0.0001)
#  (sleep 0.125)
#)

(live_loop :bass
  (each [n s] (P [
    [:C3 nil :F2 :Bb2]
    [:C3 nil :F2 :Bb2]
    [:C3 nil :F2 :Bb2]
    [:C3 nil :F2 [:Bb2 nil nil :Cs3]]
    ] 64)
    (play (- (note n) 12) :bass :dur s)
    (sleep s)
  )
)

(chain
  (synth :twinkle "square")
  (reverb :hello-verb "https://oramics.github.io/sampled/IR/EMT140-Plate/samples/emt_140_medium_5.wav") #ty Greg Hopkins
  #(Dlay :twinkle-delay 0.25)
  :out
)
 
(chain :twinkle (gain :twinkle-dry) :out)

(live_loop :twinkle
  (seed 3)
  (def n (pick 12 0 5 7))
  #(play (+ (note :C5) n) :twinkle :dur 0.05)
  (sleep 0.25)
)

(chain
  (drums :laugh-drums "local://Windy.wav" "local://Murda.wav" "local://Oi.wav" "local://Dirty Call.wav" "local://Eh.wav" "local://Fire.wav" "local://Ha-H-a 1.wav")
  (panner :laugh-pain)
  (reverb :laugh-verb "https://oramics.github.io/sampled/IR/EMT140-Plate/samples/emt_140_medium_5.wav") #ty Greg Hopkins
  (biquad :laugh-filter "peaking") #ty Greg Hopkins
  (Dlay :twinkle-delay 1.5)
  (gain :laugh-gain)
  :out
)

(live_loop :laugh
  (play (timesel (range 0 8) 5) :laugh-drums)
  (sleep (rand 32 64))
)

(live_loop :laugh-panning
  (target :laugh-pain :pan -0.8 1)
  (sleep 3)
  (target :laugh-pain :pan 0.8 1)
  (sleep 3)
)

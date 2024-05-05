(chain 
  (line_in :la)
  (gain :ge) # arm/gain
  (looper :l 32) # 32 beat loop
  (gain :ges) # amp
  (biquad :filter "lowpass") # wah-wah
  (compressor :comp)
  :out
)

(chain 
  (synth :metro "square")
  :out
)

(live_loop :metronome
  (play :C4 :metro :dur 0.1)
  (sleep 1)
  (for i 0 3
    (play :C3 :metro :dur 0.1)
    (sleep 1)
  )
)

(chain 
  (breakbeat :congas "local://congas.wav" 16 2)
  :out
)

(chain 
  #(breakbeat :bb "local://drum_loop1_8b.WAV" 8 8)
  (breakbeat :bb "local://WholeBeats_909Loops_07.wav" 8 8)
  :out
)

(live_loop :lfo
  (exp :filter :frequency 500) 
  (sleep 0.25)
  (exp :filter :frequency 1400) 
  (sleep 0.25)
)
  
  
(live_loop :drumse
  (play 0 :congas :dur 8)
  (play 0 :bb :dur 8)
  (sleep 8)
  (play 1 :congas :dur 8)
  (play 0 :bb :dur 8)
  (sleep 8)
)

(chain 
  (drums :drums "local://drumthing4 Sl-01.WAV" "local://drumthing4 Sl-02.WAV" )
  :out
)


(live_loop :bde
  (play 1 :drums :dur 1)
  (sleep 1)
)

# Inspired by this .xm yolk / parallax https://modarchive.org/index.php?request=view_by_moduleid&query=58051 
(bpm 155)

(chain 
  #(breakbeat :gras :url "tracks/break.wav" :length_beats 8 :slices 8 :gain 1.0)
  #(breakbeat :gras :url "tracks/samples/amen.wav" :length_beats 8 :slices 8 :gain 0.5)
  #(breakbeat :gras :url "tracks/samples/donny_break.wav" :length_beats 8 :slices 8 :gain 0.5)
  (breakbeat :gras :url "tracks/samples/lo_break.flac" :length_beats 4 :slices 8 :gain 0.7)
  (biquad :gras-filter :filter_type "highpass" :frequency 50 )
  (gain :gras-gain)
  :out
)

(chain 
  #(keyboard :keys)
  (sample :pad :url "tracks/samples/pads/pad_a.wav" :pitch :d3 :gain 0.6 :attack 0.3 :release 0.3)
  (reverb :pad-verb :wet-dry 0.2)
  :out
)

(live_loop :breaks
  (each [n s] (P [
    (uclid (pick 2 0) 3 8)
    (uclid 0 3 8)
    (uclid 3 3 8)
    0
  ] 16)
    (play n :gras :dur s)
    (sleep s)
  )
)
  
(live_loop :pads
  (sleep (til 16))
  (each [n s] (P [
      [:g4 ;(pick [:c4] [:tie :c4])]
      :d4
      [:g4 ;(pick [:eb4] [:tie :c4])]
      :d4
    ] 32)
    (play n :pad :dur s)
    (sleep s)
  )
)
  
(chain 
  (synth :bass :wave "sine" :release 0.07)
  :out
)

(live_loop :bass
  (sleep (til 16))
  (each [n s] (P [
      [(uclid :g1 3 8) :tie]
      [(uclid :d2 3 8) :tie]
      [(uclid :g1 3 8) :tie]
      [(uclid :d2 3 8) (uclid :c2 3 8)]
    ] 32)
    (play n :bass :dur (* s 0.8))
    (sleep s)
  )
)


(bpm 80)

(use-lib "tracks/utils.janet")
(use-lib "tracks/libs/emojis.janet")
(chain 
  (sample :cello-scratch :url "tracks/samples/instruments/cello/scrape_e3.wav" :pitch :e3 :loop-end 0.635 :loop-start 0.305 :release 1 :attack 1)
  (reverb :cello-verb :decay-time 5.0 :wet-dry -0.61)
  :out
)

(live_loop :cellos
  (play :c3 :cello-scratch :dur 16)
  (play :d3 :cello-scratch :dur 16)
  (sleep 8)
)

(chain 
  (sf2 :piano :url "tracks/sf2/wii.sf2" )
  (reverb :piano-verb :decay-time 5.0 :wet-dry -0.61)
  (delay :hii-lay :delay_time 1.5)
  :out
)

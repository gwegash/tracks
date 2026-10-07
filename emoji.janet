(use-lib "tracks/libs/emojis.janet")

(bpm 60)
(chain
  (sample :cello :url "tracks/samples/instruments/cello/a3_sustain.wav" :pitch :e5 :gain 10 :attack 3.0 :release 3.0)
  (reverb :verb)
  :out
)

(chain
  (sample :mandolin :url "tracks/samples/instruments/mandolin/e5.wav" :pitch :e5)
  (reverb :mando-verb)
  :out
)

(pp (dyn 'moji))
(moji ``
  🎻️
  `` :cello)

::  Bot for talk.

/-  talk
!:

|%
++  move  {bone card}
++  card
  $%  {$peer wire {@p term} path}
      {$pull wire {@p term} $~}
  ==
++  action
  $%  {$join s/station:talk}
      {$leave s/station:talk}
      {$joined $~}
  ==
--

|_  {bowl joined/(list station:talk)}

++  poke-noun
  |=  a/action
  ^-  {(list move) _+>.$}
  ?-  a
  {$join *}
    ?^  (find [s.a ~] joined)
      ~&  [%already-joined s.a]
      [~ +>.$]
    ~&  [%joining s.a]
    :-  [[ost %peer /listen/(scot %p p.s.a)/[q.s.a] [p.s.a %talk] /afx/[q.s.a]/(scot %da now)] ~]
    +>.$(joined [s.a joined])
  {$leave *}
    =+  i=(find [s.a ~] joined)
    ?~  i
      ~&  [%already-left s.a]
      [~ +>.$]
    ~&  [%leaving s.a]
    :-  [[ost %pull /listen/(scot %p p.s.a)/[q.s.a] [p.s.a %talk] ~] ~]
    +>.$(joined (weld (scag u.i joined) (slag +(u.i) joined)))
  {$joined $~}
    ~&  [%currently-joined joined]
    [~ +>.$]
  ==

++  diff-talk-report
  |=  {wir/wire rep/report:talk}
  ^-  {(list move) _+>.$}
  ~&  %got-talk-report
  [~ +>.$]

--

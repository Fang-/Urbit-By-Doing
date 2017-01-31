::  Bot for talk.

/-  talk
!:

|%
++  move  {bone card}
++  card
  $%  {$peer wire {@p term} path}
      {$pull wire {@p term} $~}
      {$poke wire {@p term} {$talk-command command:talk}}
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
  ?+  rep
    ~&  [%unprocessed-report-type -:rep]
    [~ +>.$]
  {$grams *}  ::  Message list.
    :_  +>.$
    %+  murn  q.rep
      |=  gram/telegram:talk
      (read-telegram wir gram)
  ==

++  read-telegram
  |=  {wir/wire gram/telegram:talk}
  ^-  (unit move)
  =+  aud=(station-from-wire wir)
  ?~  aud
    ~&  %message-source-unclear
    ~
  =*  msg  r.r.q.gram
  ?+  msg
    ~&  [%unprocessed-message-type -:msg]
    ~
  {$lin *}  ::  Regular message.
    =+  tmsg=(trip q.msg)
    ?:  =((find ":: " tmsg) [~ 0])
      ~
    :-  ~
    (send u.aud (weld "you said: " tmsg))
  ==

++  send
  |=  {aud/station:talk mess/?(tape @t)}
  ^-  move
  =+  mes=?@(mess (trip mess) mess)
  :*  ost
      %poke
      /repeat/(scot %ud 1)/(scot %p p.aud)/[q.aud]
      [our %talk]
      (said our aud %talk now eny [%leaf (weld ":: " mes)]~)
  ==

++  said  ::  Modified from lib/talk.hoon.
  |=  {our/@p cuz/station:talk dap/term now/@da eny/@uvJ mes/(list tank)}
  :-  %talk-command
  ^-  command:talk
  :-  %publish
  |-  ^-  (list thought:talk)
  ?~  mes  ~
  :_  $(mes t.mes, eny (sham eny mes))
  ^-  thought:talk
  :+  (shaf %thot eny)
    [[[%& cuz] [*envelope:talk %pending]] ~ ~]
  [now *bouquet:talk [%lin & (crip ~(ram re i.mes))]]

++  station-from-wire
  |=  wir/wire
  ^-  (unit station:talk)
  ?:  ?=({$listen *} wir)
    $(wir t.wir)
  ?.  ?=({@tas @tas *} wir)
    ~
  =+  ship=(slaw %p i.wir)
  ?~  ship
    ~&  [%unparsable-wire-station wir]
    ~
  =+  channel=(crip (slag 1 (spud t.wir)))
  [~ [u.ship channel]]

--

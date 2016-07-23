[_tb_system_call storage=system/_store.ks]

;[deffont face=mplus bold=false]
;[resetfont  ]

//load plugin
[loadjs storage="plugin/experiment.js"]
[loadjs storage="plugin/simulation.js"]

;define variables Tyrano Scripts uses
[eval exp="f.difficulty=''"]
[eval exp="f.chance=0"]
[eval exp="f.exptime=0"]
[eval exp="f.answer=''"]
[eval exp="f.choice=''"]
[eval exp="f.listnum=''"]
[eval exp="f.listname=''"]
[eval exp="f.btnflag=''"]

[iscript]
// added by HIROKI
f.sim = new Sim("store");
f.scenario = "store";
[endscript]

[loadjs storage="plugin/plugin.js"]

[iscript]
	init();
[endscript]
[if eval exp="f.totalplaytime==0"]
	[iscript]
	//load this only once
	scenario_jump();
	[endscript]
[endif]

*difficulty
[clearstack]
;If clearfix is active, role buttons will be hidden.
;[clearfix]
[cm]
[bg  time="500"  method="crossfade"  storage="&f.sim.state.image + '_bg1.png'"  ]

[if eval exp="f.splaytime>0"]
	[cm  ]
	[iscript]
		difficulty_anim_a();
		add_list_exp(f.sim.state);
	[endscript]
[endif]

[tb_ptext_hide  time="0"  ]
[tb_hide_message_window  ]
[iscript]
	difficulty_anim_b();
	f.sim.initExp();
[endscript]
[s]


*start

[cm]
[tb_hide_message_window  ]
[iscript]
	scenario_start_anim();
[endscript]
[eval exp="f.splaytime = f.splaytime + 1"]
[eval exp="f.totalplaytime = f.totalplaytime + 1"]
[jump  storage="store.ks"  target="*scenario"  ]


*scenario

[wait  time="300"  ]

[layopt layer=0 visible=true]

[mtext name="mtext" text="&f.sim.state.place" x=320 y=280 size=36 time=300 in_effect="fadeInLeft" in_delay=10 in_sync="true" out_effect="fadeOutRight"  out_delay=10 out_sync="true"]


[tb_show_message_window  ]
[anim name=role_button opacity=255 time=300 ]

[chara_show  name="ceo" width=640 time="300" top="120" left="160" wait="true"  ]

#社長
おお、よく来てくれたな。[l][r]
頼みというのは他でもない、うちの店に関わる問題なんだ。[p]

君も知っての通り、うちはこの一体に3店舗、スーパーを構えている。[l][r]
君たちの頑張りもあって、売上げは上々だ。[p]

[chara_mod name="ceo" face="angry" time=0]
だがなこの前、レジの列が長すぎるとクレームがあってね。[l][r]
今も見ての通り、夕方でもないのにこのレジ待ちの列だ。[l][r]
これではそのうちお客様も愛想を尽かしていってしまう[p]

[chara_mod name="ceo" face="default" time=0]
そこでだ。君にはどの店に問題があるのか調べて欲しいんだ。[l][r]
どこのお店にレジを増やせばよいのかが分かれば、効率的に改善できるだろう。[l][r]

[chara_mod name="ceo" face="smile" time=0]
期待しているよ。[p]

[tb_hide_message_window  ]
[chara_hide  name="ceo"  time="300"  wait="true"  ]
[bg  time="500"  method="crossfade"  storage="&f.sim.state.image + '_bg2.png'" wait="true" ]

[mtext name="mtext" text="&f.sim.state.order" x=240 y=280 size=36 time=300 in_effect="fadeInLeft" in_delay=10 in_sync="false" out_effect="fadeOutRight" out_delay=10 out_sync="false"]
[jump  storage="store.ks"  target="*choice-exp"  ]
[s  ]


*choice-exp

[iscript]
	$('.choice').css('opacity','1');
[endscript]
[tb_show_message_window  ]


*choices

[clearstack]
[cancelskip]
[iscript]
	choices_init();
[endscript]

#問題
[emb exp="f.sim.state.question"]
;次のA、B、Cのうち、レジに問題のある店舗はどれ？

[s  ]


*choice0
[cm]
[iscript]
	choice();
[endscript]
[emb exp="f.sim.state.choice[0]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="store.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=0" ]
[glink name="sys-btn" storage="store.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*choice1
[cm]
[iscript]
	choice();
[endscript]
[emb exp="f.sim.state.choice[1]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="store.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=1" ]
[glink name="sys-btn" storage="store.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*choice2
[cm]
[iscript]
	choice();
[endscript]
[emb exp="f.sim.state.choice[2]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="store.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=2" ]
[glink name="sys-btn" storage="store.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*experiment

[cm  ]
[message_window_to_right]
[anim name=role_button left="+=500" time=300 ]

[iscript]
	exp_list_anim();
[endscript]
[eval exp="f.btnflag='true'"]
[glink  name="sys-btn" storage="store.ks"  size="20"  text="戻る"  target="*exp-back"  x="824"  y="578"  ]
[s  ]


*exp-result

[cm]
;[anim name=role_button opacity=0 time=300 ]
[if exp="f.btnflag=='false'"]
	[message_window_to_right]
	[anim name=role_button left="+=500" time=300 ]
[endif]
[eval exp="f.btnflag='true'"]
[iscript]
	exp_result_anim();
[endscript]

[glink  name="sys-btn" storage="store.ks"  size="20" text="戻る" target="*exp-back"  x="824"  y="578"  ]
[s  ]


*exp-back

[cm]
[iscript]
	exp_back_anim();
[endscript]
[anim name=role_button left="-=500" time=300 ]
[eval exp="f.btnflag='false'"]
[message_window_to_left]
[wait time=300]
[jump  storage="store.ks"  target="*choices"  ]
[s  ]


*judgement

[cm]
[tb_hide_message_window  time="100"  ]
[iscript]
	judge_anim();
[endscript]

[wait time=1500]

[if exp="f.sim.state.answer[f.selected]==true"]
	[bg  time="300"  method="crossfade"  storage="&f.sim.state.image + '_bg1.png'"  ]

	[image layer=2 page=fore storage=correct.png time="300"]
	[wait time=500]
	[freeimage layer=2 page=fore time=300 wait=true]

	[chara_mod  name="ceo" face="smile" time=0]
	[chara_show  name="ceo" width=640 time="300" top="120" left="160" wait="true"  ]

	[tb_show_message_window  time="300"  ]
	#社長
	正解hogehoge。[p]
	[tb_hide_message_window  time="300"  ]
	[chara_hide  name="ceo"  time="300"  wait="true"  ]


	[glink  name="sys-btn"  storage="store.ks"  size="20" width="100" text="もう1回"  x="240"  y="298"  target="*back-top"  ]
	[glink  name="sys-btn" storage="store.ks"  size="20"  width="100" text="タイトルヘ"  x="536"  y="298"  target="*backtitle"  ]

[else]
	[image layer=2 page=fore storage=incorrect.png time="300"]
	[wait time=500]
	[freeimage layer=2 page=fore time=300 wait=true]

	[chara_mod  name="ceo" face="angry" time=0]
	[chara_show  name="ceo" width=640 time="300" top="120" left="160" wait="true"  ]

	[tb_show_message_window  time="300"  ]
	#社長
	残念hogehoge。[p]
	[tb_hide_message_window  time="300"  ]
	[chara_hide  name="ceo"  time="300"  wait="true"  ]


	[glink  name="sys-btn"  storage="store.ks"  size="20" width="100" text="もう1回"  x="240"  y="298"  target="*back-top"  ]
	[glink  name="sys-btn" storage="store.ks"  size="20"  width="100" text="タイトルヘ"  x="536"  y="298"  target="*backtitle"  ]

[endif]
[s]

*back-top
[cm]

[eval exp="f.chance=0"]
[eval exp="f.exptime=0"]
[freeimage layer=2 page=fore]

[jump  storage="store.ks"  target="*difficulty"  ]
[s]

*backtitle

[cm]
[freeimage layer=2 page=fore]
[bg  time="300"  method="crossfade"  storage="gaussian_1.png"  ]
[iscript]
//	location.reload();
	back_title();
[endscript]
[jump  storage="title_screen.ks"  target="*scenario-index"  ]

[s]
[_tb_system_call storage=system/_factory.ks]

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
f.sim = new Sim("factory");
f.scenario = "factory";
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
[bg  time="500"  method="crossfade"  storage="&f.sim.state.bgimage + '_bg1.png'"  ]

[if eval exp="f.fplaytime>0"]
	[cm  ]
	[iscript]
		clear_class();
		add_list_exp(f.sim.state);
	[endscript]
[endif]

[tb_ptext_hide  time="0"  ]
[tb_hide_message_window  ]
[iscript]
	difficulty_anim();
	f.sim.initNorm();
[endscript]
[s]


*start

[cm]
[tb_hide_message_window  ]
[iscript]
	scenario_start_anim();
[endscript]
[eval exp="f.fplaytime = f.fplaytime + 1"]
[eval exp="f.totalplaytime = f.totalplaytime + 1"]
[iscript]
	console.log('playtime:'+f.totalplaytime+'\n'+'coin:'+f.cplaytime+'\n'+'factory:'+f.fplaytime+'\n'+'store:'+f.splaytime);
[endscript]

[jump  storage="factory.ks"  target="*scenario"  ]
[s]

*scenario

[wait  time="300"  ]

[layopt layer=0 visible=true]

[mtext name="mtext" text="&f.sim.state.place" x=360 y=280 size=36 time=300 in_effect="fadeInLeft" in_delay=10 in_sync="true" out_effect="fadeOutRight" out_delay=10 out_sync="true"]
[tb_show_message_window  ]
[anim name=role_button opacity=255 time=300 ]
#
俺はこの工場の製品検査を担当している。[r]
まあ、簡単に言えば品質管理みたいなものだ。[p]

ある日、俺は工場長に呼ばれた。[r]
	[image layer=2 page=fore storage="candy_scenario.png" name="scenario-img" width=240 height=240 x=360 y=71 time="300"  ]
なんでも、ウチで作っている飴で何か問題があったようだ。[p]
	[freeimage layer=2 page=fore time=300 wait=true]
	
[chara_show  name="chief_manager" width=640 time="300" top="120" left="160" wait="true"  ]
[chara_shake name="chief_manager" count=1 swing=20 time=300]
#工場長
おお、待っとったぞ。[p]
[chara_mod name="chief_manager" face="angry" time=0]
[chara_shake name="chief_manager" count=1 swing=20 time=300]
この前、お客様から電話で「飴の大きさが違う」というクレームが何件もあったんだよ。[l][r]
こっちも3台の製造ラインを色々調べてみたんだけどな、全く分からなかったんだよ。[p]

[chara_mod name="chief_manager" face="default" time=0]
で困って君に相談したということなんだよ。[r]
君にはどのラインに問題があるのか調べて欲しいんだ。[p]

大きさを揃えて生産しないと、信用にも関わるからねえ。[r]
[chara_mod name="chief_manager" face="smile" time=0]
よろしく頼むよ。[p]

[tb_hide_message_window  ]
[chara_hide  name="chief_manager"  time="300"  wait="true"  ]
[bg  time="500"  method="crossfade"  storage="&f.sim.state.bgimage + '_bg2.png'" wait="true" ]

[mtext name="mtext" text="&f.sim.state.order" x=240 y=280 size=36 time=300 in_effect="fadeInLeft" in_delay=10 in_sync="false" out_effect="fadeOutRight" out_delay=10 out_sync="false"]
[jump  storage="factory.ks"  target="*choices"  ]
[s  ]


*choices
[tb_show_message_window  ]
[clearstack]
[cancelskip]
[iscript]
	$('.choice').css('opacity','1');
	choices_init();
[endscript]

#問題
[emb exp="f.sim.state.question"]
;次のA、B、Cのうち、問題のある製造ラインはどれ？

[s  ]


*choice0
[cm]
[iscript]
	choice();
[endscript]
[emb exp="f.sim.state.choice[0]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="factory.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=0" ]
[glink name="sys-btn" storage="factory.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*choice1
[cm]
[iscript]
	choice();
[endscript]
[emb exp="f.sim.state.choice[1]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="factory.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=1" ]
[glink name="sys-btn" storage="factory.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*choice2
[cm]
[iscript]
	choice();
[endscript]
[emb exp="f.sim.state.choice[2]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="factory.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=2" ]
[glink name="sys-btn" storage="factory.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*experiment

[cm  ]
[message_window_to_right]
[anim name=role_button left="+=500" time=300 ]

[iscript]
	exp_list_anim();
[endscript]
[eval exp="f.btnflag='true'"]
[glink  name="sys-btn" storage="factory.ks"  size="20"  text="戻る"  target="*exp-back"  x="824"  y="578"  ]
[s  ]


*exp-result

[cm]
[if exp="f.btnflag=='false'"]
	[message_window_to_right]
	[anim name=role_button left="+=500" time=300 ]
[endif]
[eval exp="f.btnflag='true'"]
[iscript]
	exp_result_anim();
[endscript]

[glink  name="sys-btn" storage="factory.ks"  size="20" text="戻る" target="*exp-back"  x="824"  y="578"  ]
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
[jump  storage="factory.ks"  target="*choices"  ]
[s  ]


*judgement

[cm]
[tb_hide_message_window  time="100"  ]
[iscript]
	judge_anim();
[endscript]

[wait time=1500]

[if exp="f.sim.state.answer[f.selected]==true"]
	[jump  storage="factory.ks"  target="*correct"  ]
[else]
	[jump  storage="factory.ks"  target="*incorrect"  ]
[endif]
[s]


*correct
	[bg  time="300"  method="crossfade"  storage="&f.sim.state.bgimage + '_bg1.png'"  ]

	[image layer=2 page=fore storage=correct.png time="300"]
	[wait time=500]
	[freeimage layer=2 page=fore time=300 wait=true]

	[chara_mod  name="chief_manager" face="smile" time=0]
	[chara_show  name="chief_manager" width=640 time="300" top="120" left="160" wait="true"  ]

	[tb_show_message_window  time="300"  ]
	[chara_shake name="chief_manager" count=1 swing=20 time=300]
	#工場長
	おお、このラインだったか。[l][r]
	早速中を見てみるか…。[p]

	[anim name="chief_manager" left="+=140" time=100 effect=easeInCirc  ]	
	[chara_show  name="staff_mob" width=640 time="300" top="120" left="0" wait="true"  ]

	[chara_shake name="staff_mob" count=1 swing=20 time=300]
	#作業員
	工場長！中の飴を切るための金型が摩耗して変形していました。[l][p]

	[chara_mod  name="chief_manager" face="default" time=0]	
	#工場長
	なるほど…、それで大きさにバラツキが出ていたのか…。[l][r]
	[chara_mod  name="chief_manager" face="smile" time=0]	
	君が調べてくれたお陰でなんとかなりそうだよ。[l][r]
	ありがとう。[p]
	
	[chara_hide  name="staff_mob"  time="100"  wait="true"  ]		
	[jump  storage="factory.ks"  target="*scenario-end"  ]
[s]


*incorrect
	[image layer=2 page=fore storage=incorrect.png time="300"]
	[wait time=500]
	[freeimage layer=2 page=fore time=300 wait=true]

	[chara_mod  name="chief_manager" face="angry" time=0]
	[chara_show  name="chief_manager" width=640 time="300" top="120" left="160" wait="true"  ]

	[tb_show_message_window  time="300"  ]
	[chara_shake name="chief_manager" count=1 swing=20 time=300]
	#工場長
	残念hogehoge。[l][r]
	「アレをコレしてくれたら」何か分かったかもしれないけどなあ。[p]

	[jump  storage="factory.ks"  target="*scenario-end"  ]
[s]


*scenario-end
	[tb_hide_message_window  time="300"  ]
	[chara_hide  name="chief_manager"  time="300"  wait="true"  ]
	[glink  name="sys-btn"  storage="factory.ks"  size="20" width="100" text="もう1回"  x="240"  y="298"  target="*back-top"  ]
	[glink  name="sys-btn" storage="factory.ks"  size="20"  width="100" text="タイトルヘ"  x="536"  y="298"  target="*backtitle"  ]
[s]


*back-top
[cm]

[eval exp="f.chance=0"]
[eval exp="f.exptime=0"]
[freeimage layer=2 page=fore]

[jump  storage="factory.ks"  target="*difficulty"  ]
[s]

*backtitle

[cm]
[freeimage layer=2 page=fore]
;[hide_incorrect_message_window time=100]
[jump  storage="factory.ks"  target="*backtitle-jump"  ]
[s]

*backtitle-jump
[cm]
[bg  time="300"  method="crossfade"  storage="grid.gif"  ]
[iscript]
//	location.reload();
	back_title();
[endscript]
[jump  storage="title_screen.ks"  target="*scenario-index"  ]

[s]
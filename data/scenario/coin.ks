[_tb_system_call storage=system/_coin.ks]

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
f.sim = new Sim("coin");
f.scenario = "coin";
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

[if eval exp="f.cplaytime>0"]
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
	f.sim.initBinom();
[endscript]
[s]


*start

[cm]
[tb_hide_message_window  ]
[iscript]
	scenario_start_anim();
[endscript]
[eval exp="f.cplaytime = f.cplaytime + 1"]
[eval exp="f.totalplaytime = f.totalplaytime + 1"]
[iscript]
	console.log('playtime:'+f.totalplaytime+'\n'+'coin:'+f.cplaytime+'\n'+'factory:'+f.fplaytime+'\n'+'store:'+f.splaytime);
[endscript]

[jump  storage="coin.ks"  target="*scenario"  ]
[s]

*scenario

[wait  time="300"  ]

[layopt layer=0 visible=true]

[mtext name="mtext" text="&f.sim.state.place" x=410 y=280 size=36 time=300 in_effect="fadeInLeft" in_delay=10 in_sync="true" out_effect="fadeOutRight" out_delay=10 out_sync="true"]
[tb_show_message_window  ]
[anim name=role_button opacity=255 time=300 ]

[chara_mod name="boy" face="smile" time=0]
[chara_show  name="boy" width=640 time="300" top="120" left="160" wait="true"  ]
[chara_shake name="boy" count=1 swing=20 time=300]

#友人
よっしゃ！表が出たってことは、今日も俺の勝ちだな！[p]

#自分
えー…また負けかー…[p]

	[image layer=2 page=fore storage="coin_scenario.png" name="scenario-img" width=240 height=240 x=360 y=71 time="300"  ]
#
俺とこの友達は、帰り道にコインを使って賭けをして、負けた方がジュースをおごる、というのが日課になっていた。[p]
	[freeimage layer=2 page=fore time=300 wait=true]
まあ負けたところでたかだか100円ちょっとの出費だ。[l][r]
高校生の俺にはそこまで痛い出費じゃない。…と思っていたのだが。[p]

#自分
おまえ最近勝ちすぎだろ！何かコインに細工でもしてるんじゃないか？[p]

#友人
[chara_mod name="boy" face="angry" time=0]
[chara_shake name="boy" count=1 swing=20 time=300]
そんなことするわけないだろー？[l][r]
[chara_mod name="boy" face="smile" time=0]
[chara_shake name="boy" count=1 swing=20 time=300]
ほら、コインの表も裏も、出る確率は半々だろ？[p]

#自分
そんなこと言ったって…[p]

#
どうも最近負けすぎているような気がするんだが…[l][r]
んー…気になる。[p]

#自分
ちょっとそのコイン、今日だけ貸してもらっていいか？[p]

#友人
[chara_mod name="boy" face="angry" time=0]
[chara_shake name="boy" count=1 swing=20 time=300]
おいおいなんだよ、疑ってるのかー？[l][r]
[chara_mod name="boy" face="default" time=0]
[chara_shake name="boy" count=1 swing=20 time=300]
まあいいよ、ほい、明日返せよー。[l][r]
[chara_shake name="boy" count=1 swing=20 time=300]
じゃあなー。[p]
[chara_hide  name="boy"  time="300"  wait="true"  ]
[wait time=300]
#
[image layer=2 page=fore storage="coin_scenario.png" name="scenario-img" width=240 height=240 x=360 y=71 time="300"  ]
よし、とにかくこれでコインはゲットしたぞ。[l][r]
早速家に帰って調べてみるか。[p]
	[freeimage layer=2 page=fore time=300 wait=true]


[tb_hide_message_window  ]
[bg  time="500"  method="crossfade"  storage="&f.sim.state.bgimage + '_bg2.png'" wait="true" ]

[mtext name="mtext" text="&f.sim.state.order" x=210 y=280 size=36 time=300 in_effect="fadeInLeft" in_delay=10 in_sync="false" out_effect="fadeOutRight" out_delay=10 out_sync="false"]
[jump  storage="coin.ks"  target="*choices"  ]
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
[glink name="sys-btn, sys-btn-yes" storage="coin.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=0" ]
[glink name="sys-btn" storage="coin.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*choice1
[cm]
[iscript]
	choice();
[endscript]
[emb exp="f.sim.state.choice[1]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="coin.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=1" ]
[glink name="sys-btn" storage="coin.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*choice2
[cm]
[iscript]
	choice();
[endscript]
[emb exp="f.sim.state.choice[2]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="coin.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=2" ]
[glink name="sys-btn" storage="coin.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*experiment

[cm  ]
[message_window_to_right]
[anim name=role_button left="+=500" time=300 ]

[iscript]
	exp_list_anim();
[endscript]
[eval exp="f.btnflag='true'"]
[glink  name="sys-btn" storage="coin.ks"  size="20"  text="戻る"  target="*exp-back"  x="824"  y="578"  ]
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

[glink  name="sys-btn" storage="coin.ks"  size="20" text="戻る" target="*exp-back"  x="824"  y="578"  ]
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
[jump  storage="coin.ks"  target="*choices"  ]
[s  ]


*judgement

[cm]
[tb_hide_message_window  time="100"  ]
[iscript]
	judge_anim();
[endscript]

[wait time=1500]

[if exp="f.sim.state.answer[f.selected]==true"]
	[jump  storage="coin.ks"  target="*correct"  ]
[else]
	[jump  storage="coin.ks"  target="*incorrect"  ]
[endif]
[s]


*correct
	[image layer=2 page=fore storage=correct.png time="300"]
	[wait time=500]
	[freeimage layer=2 page=fore time=300 wait=true]

	[bg  time="300"  method="crossfade"  storage="&f.sim.state.bgimage + '_bg3.png'"  ]

	[mtext name="mtext" text="翌日" x=420 y=280 size=36 time=300 in_effect="fadeInLeft" in_delay=10 in_sync="true" out_effect="fadeOutRight" out_delay=10 out_sync="true"]

	[chara_mod  name="boy" face="default" time=0]
	[chara_show  name="boy" width=640 time="300" top="120" left="160" wait="true"  ]	
	[tb_show_message_window  time="300"  ]

	[if exp="f.selected==0 || f.selected==1"]

		#自分
		おい、やっぱりあのコインいかさまだったじゃないか！[p]

		[chara_mod  name="boy" face="angry" time=0]
		[chara_shake name="boy" count=1 swing=20 time=300]
		#友人	
		やーごめんごめん。[l][r]
		[chara_mod  name="boy" face="smile" time=0]
		[chara_shake name="boy" count=1 swing=20 time=300]
		最近金欠だったからさ、ちょっとズルしたくなっちゃんたんだよね。[p]
	
		#
		まったくこいつは…。[p]
		
		#自分
		まあいいや。今日からは俺が持ってきたこの「普通」のコインで勝負な。[p]
	
		[chara_mod  name="boy" face="default" time=0]
		[chara_shake name="boy" count=1 swing=20 time=300]
		#友人
		オッケー、望むところだぜ。[l][r]
		……あー…[p]
	
		#自分
		ん？どうした？[p]
	
		[chara_mod  name="boy" face="smile" time=0]
		[chara_shake name="boy" count=1 swing=20 time=300]
		#友人
		それ、イカサマコインじゃないよな？[p]
		
		#自分
		んなわけあるか！[p]	

	[else]
		#自分
		昨日調べてみたけど、やっぱりお前のコインは普通のコインだったよ。[p]
		
		[chara_mod  name="boy" face="default" time=0]
		[chara_shake name="boy" count=1 swing=20 time=300]
		#友人	
		だろ？[l][r]
		[chara_mod  name="boy" face="smile" time=0]
		[chara_shake name="boy" count=1 swing=20 time=300]
		正々堂々と勝負する！それが俺のモットーだからな。[l][r]
		小細工なんてしないさ。[p]
	
		#自分
		すまんな、疑ったりなんかして。[p]
		
		#友人
		[chara_mod  name="boy" face="default" time=0]
		[chara_shake name="boy" count=1 swing=20 time=300]
		いいよそんな気にしなくても。[l][r]
		それじゃ今日も帰りにやってく？[l][r]
		[chara_shake name="boy" count=1 swing=20 time=300]
		[chara_mod  name="boy" face="smile" time=0]
		ま、今日も俺が勝つけどね♪[p]
		
		#自分
		なにをーー！！！[p]
	[endif]	
[jump  storage="coin.ks"  target="*scenario-end"  ]
[s]


*incorrect

	[image layer=2 page=fore storage=incorrect.png time="300"]
	[wait time=500]
	[freeimage layer=2 page=fore time=300 wait=true]

	[bg  time="300"  method="crossfade"  storage="&f.sim.state.bgimage + '_bg1.png'"  ]

	[chara_mod  name="boy" face="angry" time=0]
	[chara_show  name="boy" width=640 time="300" top="120" left="160" wait="true"  ]

	[tb_show_message_window  time="300"  ]
	[chara_shake name="boy" count=1 swing=20 time=300]
	#友人
	残念hogehoge。[l][r]
	「アレをコレしてくれたら」何か分かったかもしれないけどなあ。[p]

[jump  storage="coin.ks"  target="*scenario-end"  ]
[s]


*scenario-end
	[tb_hide_message_window  time="300"  ]
	[chara_hide  name="boy"  time="300"  wait="true"  ]
	[glink  name="sys-btn"  storage="coin.ks"  size="20" width="100" text="もう1回"  x="240"  y="298"  target="*back-top"  ]
	[glink  name="sys-btn" storage="coin.ks"  size="20"  width="100" text="タイトルヘ"  x="536"  y="298"  target="*backtitle"  ]
[s]


*back-top
[cm]

[eval exp="f.chance=0"]
[eval exp="f.exptime=0"]
[freeimage layer=2 page=fore]

[jump  storage="coin.ks"  target="*difficulty"  ]
[s]

*backtitle

[cm]
[freeimage layer=2 page=fore]
;[hide_incorrect_message_window time=100]
[jump  storage="coin.ks"  target="*backtitle-jump"  ]
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
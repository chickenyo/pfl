;ビルダーでシナリオごとに必ず呼び出されるシステム系のKSファイル

;show message window
[macro name="tb_show_message_window"]
	[layopt  layer="message0"  visible="true"  ]
	[layopt  layer="fixlayer"  visible="true"  ]
[endmacro]

;hide message window
[macro name="tb_hide_message_window"]
	[layopt  layer="message0"  visible="false"  ]
	[layopt  layer="fixlayer"  visible="false"  ]
[endmacro]

;float message window to right
[macro name="message_window_to_right"]
	[anim layer="message0" left="+=1000" time=300 effect=easeOutCubic ]
;	[anim layer="fixlayer" left="+=1000" time=300 effect=easeOutCubic ]
[endmacro]

;float message window to left
[macro name="message_window_to_left"]
	[anim layer="message0" left="-=1000" time=300 effect=easeOutCubic ]
;	[anim layer="fixlayer" left="-=1000" time=300 effect=easeOutCubic ]
[endmacro]

;set message window position in case of incorrect
[macro name="show_incorrect_message_window"]
	[layopt  layer="message0"  visible="true" top=-191 ]
	[layopt  layer="fixlayer"  visible="true"  ]
	[anim name=role_button opacity=0 time=0 ]	
[endmacro]

[macro name="hide_incorrect_message_window"]
	[layopt  layer="message0"  visible="false" top=0 ]
	[layopt  layer="fixlayer"  visible="false"  ]
[endmacro]


;shake character pic
[macro name="chara_shake"]
	[iscript]
		tf.swing_1 = mp.swing;
		tf.swing_2 = mp.swing*2*-1;
	[endscript]
	[keyframe name="shake"]
		[frame p=0% y="0" ]
		[frame p=25% y="&tf.swing_1" ]
		[frame p=75% y="&tf.swing_2" ]
		[frame p=100% y="&tf.swing_1" ]
	[endkeyframe]
	[kanim name="%name" keyframe="shake" count=%count|5 time=%time|500]
[endmacro]



[macro name="_tb_system_call"]
	[call storage=%storage ]
[endmacro]

[macro name="tb_image_show"]
	[image storage=%storage layer=1 page=fore visible=true y=%y x=%x width=%width height=%height time=%time ]	
[endmacro]
	
[macro name="tb_image_hide"]
	[freeimage layer=1 page=fore time=%time]	
[endmacro]

[macro name="tb_ptext_show"]

[if exp="mp.anim=='true'" ]
	[mtext layer=2 text="%text" y=%y x=%x size=%size face=%face color=%color name=%name bold=%bold time=%time fadeout=%fadeout wait=%wait in_effect=%in_effect out_effect=%out_effect]
[else]	
	[ptext layer=2 text="%text" y=%y x=%x size=%size face=%face color=%color name=%name bold=%bold time=%time   ]
[endif]

[endmacro]
	
[macro name="tb_ptext_hide"]
	[freeimage layer=2 time=%time ]
[endmacro]

[macro name="tb_eval"]
	[eval exp=%exp ]	
[endmacro]


;生ティラノ用のマーカー
[macro name="tb_start_tyrano_code"]
[endmacro]

[macro name="_tb_end_tyrano_code"]
[endmacro]

[macro name="lr"]
[l][r]
[endmacro]



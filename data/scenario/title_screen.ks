[_tb_system_call storage=system/_title_screen.ks]
;[deffont face=mplus bold=false]
;[resetfont]

[hidemenubutton]
[eval exp="f.totalplaytime=0"]
[eval exp="f.cplaytime=0"]
[eval exp="f.fplaytime=0"]
[eval exp="f.splaytime=0"]
[tb_hide_message_window  ]
;[bg  storage="gaussian_1.png"  ]
[bg  storage="grid.gif"  ]

*scenario-index
[clearstack]
[cm]
[glink name="scenario-list, glink1" storage="title_screen.ks" size=20 x=-1000 y=160 width=800 target="*coin" text="イカサマ・コインを探せ！"  ]
[glink name="scenario-list, glink2" storage="title_screen.ks" size=20 x=1000 y=288 width=800 target="*factory" text="生産にバラツキのあるラインを発見せよ！"  ]
[glink name="scenario-list, glink3" storage="title_screen.ks" size=20 x=-1000 y=416 width=800 target="*store"  text="お客さんが待たなくてよいレジの個数って？"  ]

@anim name="glink1" left=60 time=300 method="easeInSine"
@anim name="glink2" left=60 time=300 method="easeInSine"
@anim name="glink3" left=60 time=300 method="easeInSine"
[s  ]

*coin
	[jump  storage="coin.ks"  target=""  ]
[s  ]

*factory
	[jump  storage="factory.ks"  target=""  ]
[s  ]

*store
	[jump  storage="store.ks"  target=""  ]
[s  ]
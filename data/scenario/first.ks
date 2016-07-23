[layopt layer=message0 page=fore visible=false]

;メニューボタン非表示
;[hidemenubutton]


;ゲームに必要なライブラリ読み込み
[call storage="system/tyrano.ks"]
[call storage="system/builder.ks"]
[call storage="system/chara_define.ks"]

;live2D対応


[layopt layer=2 visible=true]
;[layopt layer="message0" visible=false]
[call storage="system/message_window.ks"]

;タイトルの設定
[title name="統計ゲーム"]

;button

;[button name="role_button" role="skip" graphic="button/skip.gif" x=350 y=400]
;[button name="role_button" role="backlog" graphic="button/log.gif" x=590 y=400]
;[button name="role_button" role="window" graphic="button/close.gif" x=670 y=400]
;[button name="role_button" role="menu" graphic="button/menu.gif" x=750 y=400]
;[button name="role_button" role="skip" graphic="buttons/skip.png" text="skip" x=660 y=550 width=80 visible=false]
;[button name="role_button" role="backlog" graphic="buttons/log.png" text="log" x=750 y=550 width=80 visible=false]
;[button name="role_button" role="title" graphic="buttons/title.png" text="menu" x=840 y=550 width=80 visible=false]
[button name="role_button" role="skip" graphic="buttons/skip.png" text="skip" x=660 y=395 width=80 visible=false]
[button name="role_button" role="backlog" graphic="buttons/log.png" text="log" x=750 y=395 width=80 visible=false]
[button name="role_button" role="title" graphic="buttons/title.png" text="menu" x=840 y=395 width=80 visible=false]


;タイトル画面表示
[jump storage="title_screen.ks"]



;--------------------------

[s]





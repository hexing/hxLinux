#!/bin/sh

#三不五時下個維護的指令可以讓 Git 佔的空間變小：
#view plaincopy to clipboardprint?
git count-objects  

#Git 會回答類似: 11 objects, 44 kilobytes 這表示 11 個 object 散掉了， 浪費了 44 kilobytes 的空間。 要解決這個問題就下指令：
#view plaincopy to clipboardprint?
git gc  

#下這個指令來維持 Git 的健康， 它怎麼維持的我也不知道：
#view plaincopy to clipboardprint?
git fsck --full 

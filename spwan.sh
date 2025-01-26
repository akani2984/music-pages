#!/bin/bash
re=`ls music`
re2=`echo "$re" | wc -l`
n=0
cat > index.html <<EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://unpkg.com/mdui@1.0.2/dist/css/mdui.min.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<title>Music Pages</title>
</head>
<body>
<div id="main" class="mdui-container">
<a onclick="luanxu()" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-indigo">乱序播放</a>
<a onclick="xunhuan()" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-indigo">循环播放</a>
<a onclick="shunxu()" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-indigo">顺序播放</a>
<audio autoplay id='play' controls class='mdui-center' autoplay></audio>
<h3 id='current'></h3>
<table class="mdui-table-col-numeric mdui-table" id="table" ><thead><tr><th>文件名</th><th>操作</th></tr></thead><tbody>
EOF

echo "$re" | while read line; do
cat >> index.html <<EOF
<tr><td>$line</td><td><a id="$n" onclick="play('$line','$n')" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-indigo">播放</a></td></tr>'
EOF
n=$(($n + 1))
done



cat >> index.html <<EOF

</table>
</div>
<script>
sum = $re2
uid = 0 
mode = 'shunxu';
function luanxu() {
    mode = 'luanxu';
}
function xunhuan() {
    mode = 'xunhuan';
}
function shunxu() {
    mode = 'shunxu';
}
function play(name,uuid) {
   document.getElementById('current').innerHTML = '正在播放：' + name
   document.getElementById('play').src = 'music/' + name;
   uid = Number(uuid)
}
   document.getElementById("play").addEventListener('ended', function () {
       if(mode=='luanxu') {
       sid = Math.floor(Math.random()*sum);
       document.getElementById(sid).onclick()
       }
       if(mode=='shunxu') {
       console.log(uid)
       uid = uid + 1
       document.getElementById(uid).onclick()
       }
       if(mode=='xunhuan') {
       document.getElementById(uid).onclick()
       }
   }, false);

</script>
</div>
<script src="https://unpkg.com/mdui@1.0.2/dist/js/mdui.min.js"></script>
</body>
</html>
EOF

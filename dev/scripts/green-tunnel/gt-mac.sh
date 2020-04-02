#!/bin/bash
2
​
3
# Instalasi Green Tunnel untuk Mac
4
​
5
about(){
6
  echo "Name of File  : Green-Tunnel"
7
  echo "Version       : 2020.4 (ALPHA)"
8
  echo "Need Tester   : MacOS (OSX)"
9
  echo ""
10
  echo "Built with love by Icaksh for BEBASID"
11
}
12
​
13
install_all(){
14
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
15
  brew install node
16
  brew install tmux
17
  npm i -g green-tunnel
18
}
19
​
20
open_gt(){
21
  tmux has-session -t 6f4f9a675d5c67aa28350b0276bf911d 2>/dev/null
22
  if [ $? != 0 ]; then
23
    tmux new-session -d -s 6f4f9a675d5c67aa28350b0276bf911d -x 252 -y 29
24
  else
25
    tmux kill-session -t 6f4f9a675d5c67aa28350b0276bf911d
26
    tmux new-session -d -s 6f4f9a675d5c67aa28350b0276bf911d -x 252 -y 29
27
  fi
28
  random=$(jot -i 6000-8000 -n 1)
29
  tmux split-window -v
30
  tmux send-keys -t 1 "gt --ip 127.0.0.1 --port $random --dns-server https://doh.dnslify.com/dns-query --system-proxy false --silent true -v 'green-tunnel:*'" Enter
31
  browser="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
32
  killall 'Google Chrome'
33
  tmux split-window -h
34
  tmux send-keys -t 2 "$browser netflix.com --proxy-server=127.0.0.1:$random" Enter
35
  fi
36
  tmux send-keys -t 0 "bebasid-gt 6f4f9a675d5c67aa28350b0276bf911d $random" Enter
37
  tmux select-pane -t 0
38
  tmux a
39
}
40
​
41
case $1 in
42
  start )
43
    if ! [[ -x $(type -v gt) ]]; then
44
      echo "Install Dulu Green-Tunnelnya"

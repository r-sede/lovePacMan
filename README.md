# PACMAN love2d remake

A pacman remake based on the NES version (1993)
made with [love2d](https://love2d.org/) <small>*(with love)*</small> in  pure spaghetti style

source: [the Pac-Man dossier](https://www.gamasutra.com/view/feature/3938/the_pacman_dossier.php?print=1)


![pacMan remake screenshot](https://github.com/r-sede/lovePacMan/raw/master/assets/img/gameScreen.jpg ":v")

### TODO:
- [ ] add other ghosts
- [ ] add Fx/Music
- [ ] show score, lives, 'Ready!' etc ...
- [ ] add high score file
- [ ] fix frightened ghost texture
- [x] add menu to title screen (play/scores)
- [ ] add tunnel 
- [ ] correct the score when Pac-Man eats a ghost
- [ ] add bonus (fruits)
- [ ] better pacMan control ? :/

---
## control:
**arrow key:** move pacMan ( spam the key  )

**esc:** quit game

**d:** toggle debug info

---

## windows:
unzip  build/lovePacMan.zip

run lovePacMan.exe

## linux:

install love2d package for your distrib

*ex deb package:*
```
$ sudo add-apt-repository ppa:bartbes/love-stable
$ sudo apt-get update
```

```
$ git clone https://github.com/r-sede/lovePacMan.git
$ cd lovePacMan
$ love .
```
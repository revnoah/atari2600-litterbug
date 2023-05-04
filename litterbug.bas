
 rem ** Litterbug
 rem ** by Noah J Stewart

 set kernel_options no_blank_lines

 scorecolor=$04

 COLUP0=$C4
 COLUP1=$C8
 COLUBK=$80
 COLUPF=$A9
 NUSIZ0=$35
 CTRLPF=$31

 const screenWidth = 159
 const screenHeight = 191
 const minPlayer0x = 20
 const maxPlayer0x = 130
 const minPlayer0y = 40
 const maxPlayer0y = 90
 const minBallX = 0
 const maxBallX = 160
 const minBallY = 40
 const maxBallY = 80

 player0x=90
 player0y=60
 score=0
 ballx=0
 bally=0
 ballheight=4
 missile0height=8
 missile1height=8
 missile0x=0
 missile0y=0
 missile1x=0
 missile0x=0
 
 const font = whimsey
 const pfscore = 1
 pfscore1 = 21
 pfscore2 = 255

  playfield:
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXX....XXXXXXXXX..XXXXXX....XXX
XXX....XXXX...XX..XX...X....XXX
X.......XX....XX..XX...X....XXX
...............................
...............................
...............................
...............................
...............................
...............................
...............................
end

 player0:
 %00000000
 %01000001
 %01000001
 %00100010
 %00011100
 %00001000
 %00001001
 %00001010
 %01111100
 %00000100
 %00001100
 %00011110
 %00011110
 %00011110
 %00001100
 %00000000
end

 player1:
 %10000001
 %10101001
 %10101001
 %11111111
 %01111110
 %00011000
 %00111100
 %00011000
end

mainloop

  if joy0up && player0y > minPlayer0y then gosub movePlayerUp
  if joy0down && player0y < maxPlayer0y then gosub movePlayerDown
  if joy0left && player0x > minPlayer0x then gosub movePlayerLeft
  if joy0right && player0x < maxPlayer0x then gosub movePlayerRight

  if collision(ball, player0) then gosub hitBall
  if collision(missile0, player0) then gosub hitMissile0
  if collision(missile1, player0) then gosub hitMissile1

  if ballx = 0 then gosub positionBall
  if missile0x = 0 then gosub positionMissile0
  if missile1x = 0 then gosub positionMissile1
  if player1x = 0 then gosub positionLitterbug

  drawscreen

  goto mainloop

end
  return

movePlayerUp
  player0y = player0y - 1
  
  return

movePlayerDown
  player0y = player0y + 1

  return

movePlayerLeft
  player0x = player0x - 1
  REFP0 = 0

  return

movePlayerRight
  player0x = player0x + 1
  REFP0 = 8

  return

hitBall
  score = score + 10
  gosub positionBall

  return

hitMissile0
  score = score + 10
  gosub positionMissile0

  return

hitMissile1
  score = score + 10
  gosub positionMissile1

  return

positionLitterbug
  player1x = (rand&63) + 20
  player1y = (rand&31) + 40

  return

positionBall
  ballx = (rand&63) + 20
  bally = (rand&31) + 40

  return

positionMissile0
  missile0x = (rand&63) + 20
  missile0y = (rand&31) + 40

  return

positionMissile1
  missile1x = (rand&63) + 20
  missile1y = (rand&31) + 40

  return

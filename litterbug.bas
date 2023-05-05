
 rem ** Litterbug
 rem ** by Noah J Stewart

 set kernel_options no_blank_lines

 scorecolor=$04

 COLUBK=$A9
 COLUPF=$80
 COLUP0=$C4
 COLUP1=$C8
 NUSIZ0=$35
 CTRLPF=$21

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
 dim bugNum = 1
 dim playingGame = 1
 dim currentTarget = 0

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
  if collision(player1, player0) then gosub hitLitterbug
  if collision(missile0, player0) then gosub hitMissile0
  if collision(missile1, player0) then gosub hitMissile1
  if collision(missile0, player1) then gosub hitLitterbugMissile0
  if collision(missile1, player1) then gosub hitLitterbugMissile1

  if !ballx then gosub positionBall
  if !missile0x then gosub positionMissile0
  if !missile1x then gosub positionMissile1
  if !player1x then gosub positionLitterbug

  if !pfscore1 && playingGame then gosub moveLitterbug

  if switchreset then goto startGame
  if joy0fire && !playingGame then goto startGame

  if !pfscore1 && playingGame then gosub gameOver

  if bugNum = 1 then bugNum = 2

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

moveLitterbug
  rem if currentTarget = 0 then currentTarget = (rand&3)
  rem if currentTarget = 1 then gosub moveLitterbugPlayer
  rem if currentTarget = 2 then gosub moveLitterbugMissile0
  rem if currentTarget = 3 then gosub moveLitterbugMissile1

  if player0x < player1x then player1x = player1x - 1 else player1x = player1x + 1
  if player0y < player1y then player1y = player1y - 1 else player1y = player1y + 1
  player1x = player1x : player1y = player1y

  return

moveLitterbugPlayer
  if player0x < player1x then player1x = player1x - 1 else player1x = player1x + 1
  if player0y < player1y then player1y = player1y - 1 else player1y = player1y + 1
  player1x = player1x : player1y = player1y

  return

moveLitterbugMissile0
  if missile0x < player1x then player1x = player1x - 1 else player1x = player1x + 1
  if missile0y < player1y then player1y = player1y - 1 else player1y = player1y + 1
  player1x = player1x : player1y = player1y

  return

moveLitterbugMissile1
  if missile1x < player1x then player1x = player1x - 1 else player1x = player1x + 1
  if missile1y < player1y then player1y = player1y - 1 else player1y = player1y + 1
  player1x = player1x : player1y = player1y

  return

hitLitterbug
  pfscore1 = pfscore1/4

  gosub positionLitterbug

  return

hitBall
  if playingGame then score = score + 10
  gosub positionBall

  return

hitMissile0
  if playingGame then score = score + 10
  gosub positionMissile0

  return

hitMissile1
  if playingGame then score = score + 10
  gosub positionMissile1

  return

hitLitterbugMissile0
  gosub positionMissile0

  return

hitLitterbugMissile1
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

gameOver
  COLUBK=$45
  playingGame = 0

  return

startGame
  playingGame = 1

  COLUBK=$80

  pfscore1 = 21
  pfscore2 = 255

  gosub positionBall
  gosub positionMissile0
  gosub positionMissile1
  gosub positionLitterbug

  goto mainloop

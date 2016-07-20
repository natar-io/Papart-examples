# War. Game. WarGame!

WarGame uses colored objects to shoot particles! Who will win, between attacking turrets and defending walls?

# The board

The board has 2 printed sheet: `player1.svg` (left) and `game.svg` (top) - and a plastic paper.

![WarGame Board](https://github.com/potioc/Papart-examples/blob/master/apps/WarGame/wargame_board.jpg)

The `game menu` sheet has 4 color detection spaces:
* slot 1 defines attacking turrets on player side, and can symbolize targets on the battlefield,
* slot 2 defines walls on the battlefield;
* slot 3 defines a disturbing field that force particules to go towards the top,
* slot 4 determines a disturbing area that forces particules to go towards the bottom.

# In GAME

For this first example, we have chosen that the blue objects will be attacking and the green items will be defending.

Blue turrets in player area are launching particules to the right on the green walls. 
Particules are bouncing on the walls and they undergo the disturbation fields drawn with the marker.

![WarGame Blue Attack](https://github.com/potioc/Papart-examples/blob/master/apps/WarGame/wargame_blue.jpg)

## Other example

Here we set the attacking team to orange and the walls are blue.

![WarGame Orange Attack](https://github.com/potioc/Papart-examples/blob/master/apps/WarGame/wargame_orange.jpg)

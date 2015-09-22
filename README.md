# matlab_DA_impire_load_gamedata
auto-import full impire game data

Functions to auto-import Impire-VIS.TRACK-gamedata-files to workspace!
This work is the result of my diploma-project "A quantitative analysis of goal-scoring situations in football."
© Felix Hünger.

SavePosToBin loads the complete game into workspace and saves it to files with prefix savePrefix.

parseBall Reads X,Y and Speed parameter of ball from a VIS.TRACK pos/txt file:
- First input parameter is the section to read (1,2,3,4)
- Second input parameter is the file id. (the result of fopen)
- Result is the a matrix with size [3xn, n is the number of frames in this section; (x, y, speed)] 

parseTeam Reads X,Y and Speed parameter of one player from a VIS.TRACK pos/txt file:
- First input parameter is the section to read (1,2,3,4)
- Second input parameter is the file id. (the result of fopen)
- Third input parameter define the team (1,2)
- Fourth input parameter define the player numer (1-11)
- Result is the a matrix with size [3xn, n is the number of frames in this section; (x, y, speed)]


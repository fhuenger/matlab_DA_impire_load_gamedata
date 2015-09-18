function [ result ] = parseTeam( section,fid,team,player )
%parseTeam Reads X,Y and Speed parameter of one player from a VIS.TRACK pos file
%   First input parameter is the section to read (1,2,3,4)
%   Second input parameter is the file id. (the result of fopen)
%   Third input parameter define the team (1,2)
%   Fourth input parameter define the player numer (1-11)
%   Don't forget to close the file after reading. 
%   Result is the a matrix with size [3xn] (x, y, speed)(n is the number of frames in
%   this section
%
% AUS FSCANF (AUS G MACHE D!!! THOMAS C** SEITE 207

player_x=[];player_y=[];player_speed=[]; referees=[]; k = -1;
while ~feof(fid),
    % parse Frame  
    frame = fscanf(fid, '%d , %d , %d;', 3);
    if(size(frame)==0)
      break
    end
    %parse Team
    for teamCount=1:2
        fscanf(fid, '%[#]',1);
        for playerCount=1:11
            if ((teamCount==team) && (frame(3)==section) && (playerCount==player)),
                playerTmp=fscanf(fid, '%d,%d,%d,%d;', 4);
                player_x=[player_x int16(playerTmp(2)*10000)]; %#ok<AGROW>
                player_y=[player_y int16(playerTmp(3)*10000)]; %#ok<AGROW>
                player_speed=[player_speed int16(playerTmp(4)*100)]; %#ok<AGROW>
            else
                fscanf(fid, '%d,%d,%d,%d;', 4);
            end
        end
    end
    %parse Referees
    for refereesCount=1:3
    fscanf(fid, '%[#]',1);
    referees = fscanf(fid, '%d,%d,%d;', 3);
    end
    %parse Ball
    fscanf(fid, '%[#]',1);
    ball = fscanf(fid, '%d,%d,%d,%d,%d,%d;', 6); %raute zum schluss raus genommen nach 6g
%     if k == 1;
    %parse Additional Info
    if frame == [0;1;1]
    fscanf(fid, '%[#]',1);
    additional_info = fscanf(fid, '%d,%d,%d;', 3);
    else fscanf(fid, '%[#]',1);
    end
end
result = [player_x; player_y; player_speed]';
end


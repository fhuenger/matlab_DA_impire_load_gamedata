function [ result ] = parseTeam( section,fid,team,player )

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
    ball = fscanf(fid, '%d,%d,%d,%d,%d,%d;', 6);
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
function [ result ] = parseBall( section,fid )
%parseBall Reads X,Y and Speed parameter of ball from a VIS.TRACK pos file
%   First input parameter is the section to read (1,2,3,4)
%   Second input parameter is the file id. (the result of fopen)
%   Don't forget to close the file after reading. 
%   Result is the a matrix with size [3xn](x, y, speed) (n is the number of frames in
%   this section
ball_x=[];ball_y=[];ball_z=[];ball_speed=[];ball_flag=[];ball_possesion=[];
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
                fscanf(fid, '%d,%d,%d,%d;', 4);
            end
    end
     %parse Referees
    for refereesCount=1:3
    fscanf(fid, '%[#]',1);
    referees=fscanf(fid, '%d,%d,%d;', 3);
    end
    %parse Ball
    fscanf(fid, '%[#]',1);
    %save Ball
    if(frame(3)==section),
        ballTmp=fscanf(fid, '%d,%d,%d,%d,%d,%d;#', 6);
        ball_x=[ball_x int16(ballTmp(1)*10000)]; %#ok<AGROW>
        ball_y=[ball_y int16(ballTmp(2)*10000)]; %#ok<AGROW>
        ball_z=[ball_z int16(ballTmp(3)*10000)]; %#ok<AGROW>
        ball_speed=[ball_speed int16(ballTmp(4)*100)]; %#ok<AGROW>
        ball_flag=[ball_flag int16(ballTmp(5)*100)]; %#ok<AGROW>
        ball_possesion=[ball_possesion int16(ballTmp(6))]; %#ok<AGROW>
    else
        fscanf(fid, '%d,%d,%d,%d,%d,%d;', 6);
    end
    if frame==[0;1;1]
    fscanf(fid, '%[#]',1);
    fscanf(fid, '%d,%d,%d;', 3);
    else fscanf(fid, '%[#]',1);
    end
end
result=[ball_x; ball_y; ball_z; ball_speed; ball_flag; ball_possesion]';
%result=[ball_x; ball_y; ball_speed; ball_flag; ball_possesion];
end


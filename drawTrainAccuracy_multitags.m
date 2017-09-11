function drawTrainAccuracy_multitags(fileName)
clc;
% load the log file of caffe model
fid = fopen(fileName, 'r');
tline = fgetl(fid);

%get arrays to draw figures
lossIter = [0];                 %loss横坐标
lossArray = [0];            %loss纵坐标

%record the last line
lastLine = '';

%read line
while ischar(tline)
    %%%%%%%%%%%%%% the accuracy line %%%%%%%%%%%%%%
    k1 = strfind(tline, 'Train net output');
    if (k1)
        k = strfind(tline, 'loss');
        accuracyBool = false;
        if (k)
            % If the string contain test and accuracy at the same time
            % The bias from 'accuracy' to the float number
            indexStart = k + 7; 
            indexEnd = strfind(tline, '(') - 2;
            str = tline(indexStart : indexEnd);
            accuracyBool = true;
        end
        
        % Get the number of index
        k = strfind(lastLine, 'Iteration');
        accuracyIterBool = false;
        if (k)
            indexStart = k + 10;
            indexEnd = strfind(lastLine, ',') - 1;
            str2 = lastLine(indexStart : indexEnd);
            accuracyIterBool = true;
        end
        
        % Concatenation of two string
        if accuracyBool && accuracyIterBool
            lossArray = [lossArray, str2num(str)];
            lossIter  = [lossIter, str2num(str2)];
            %res_str = strcat(str2, '/', str);
        end
    end
       
    lastLine = tline;
    tline = fgetl(fid);    
end
lossArray = lossArray(2:end);
lossIter = lossIter(2:end);
%draw figure
figure;h2 = plot(lossIter, lossArray, 'r*-');title('iteration vs  train loss');	%绘制loss曲线

function drawTrainAccuracy_multitask(fileName)
clc;
% load the log file of caffe model
fid = fopen(fileName, 'r');
tline = fgetl(fid);

%get arrays to draw figures
lossIter = [0];                         %loss横坐标
lossArrayAds = [0];               %loss纵坐标
lossArrayMulti = [0];             %loss纵坐标
lossArraySingle = [0];            %loss纵坐标
lossArrayAll = [0];                   %loss纵坐标

%read line
while ischar(tline)
    %%%%%%%%%%%%%% all loss %%%%%%%%%%%%%%
    k1 = strfind(tline, 'Iteration');
    if (k1)
       k2 = strfind(tline, 'loss');
       if (k2)
           indexStart = k2 + 7;
           indexEnd = size(tline);
           str1 = tline(indexStart:indexEnd(2));
           indexStart = k1 + 10;
           indexEnd = strfind(tline, ',') - 1;
           str2 = tline(indexStart:indexEnd);
          % res_str1 = strcat(str2, '/', str1);
           lossIter  = [lossIter,  str2num(str2)];
           lossArrayAll = [lossArrayAll, str2num(str1)];
       end
    end
    
    %%%%%%%%%%%%%% ads loss %%%%%%%%%%%%%%
    k1 = strfind(tline, 'loss/ads');
    if (k1)
           indexStart = k1 + 11;
           indexEnd = strfind(tline, '(') - 2;
           str1 = tline(indexStart : indexEnd);
           lossArrayAds = [lossArrayAds, str2num(str1)];
    end
    
    %%%%%%%%%%%%%% all loss %%%%%%%%%%%%%%
    k1 = strfind(tline, 'loss/multi-tags');
    if (k1)
           indexStart = k1 + 18;
           indexEnd =strfind(tline, '(') - 2;
           str1 = tline(indexStart : indexEnd);
           lossArrayMulti = [lossArrayMulti, str2num(str1)];
    end
    
    %%%%%%%%%%%%%% all loss %%%%%%%%%%%%%%
    k1 = strfind(tline, 'loss/single-tag');
    if (k1)
           indexStart = k1 + 18;
           indexEnd = strfind(tline, '(') - 2;
           str1 = tline(indexStart : indexEnd);
           lossArraySingle = [lossArraySingle, str2num(str1)];
    end
        
    tline = fgetl(fid);    
end
   lossIter = lossIter(2:end);
   lossArrayAll = lossArrayAll(2:end);
   lossArrayAds = lossArrayAds(2:end);
   lossArrayMulti = lossArrayMulti(2:end);
   lossArraySingle = lossArraySingle(2:end);
%draw figure
figure;h = plot(lossIter, lossArrayAll, 'r-', lossIter, lossArrayAds, 'b-', lossIter,lossArrayMulti, 'm-', lossIter, lossArraySingle, 'y--');
title('iteration vs loss');	%绘制test accuracy曲线
legend(h,'all loss','ads loss','multi loss', 'single loss') %添加图例  

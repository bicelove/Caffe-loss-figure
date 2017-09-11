function drawTestAccuracy_multitags(fileNameList)
clc;

fidList = fopen(fileNameList, 'r');
tlineList = fgetl(fidList);

lossIter = [0];                         %loss横坐标
lossArrayMultiP = [0];             %loss纵坐标
lossArrayMultiR = [0];             %loss纵坐标
lossArrayMultiF1 = [0];             %loss纵坐标
numLog = 0;
numMulti = 0;

while ischar(tlineList)
    % load the log file of caffe model
    fid = fopen(tlineList, 'r');
    tline = fgetl(fid);
    numMulti = 0;
    %read line
    while ischar(tline)
        %%%%%%%%%%%%%% all loss %%%%%%%%%%%%%%
        k = strfind(tline, 'Batch');
        if (k)
            tline = fgetl(fid);    
            continue;
        else
            %%%%%%%%%%%%%% all loss %%%%%%%%%%%%%%
            k1 = strfind(tline, 'top-1/loss');
            if (k1)
                   numMulti = numMulti + 1;
                   indexStart = k1 + 13;
                   indexEnd = length(tline);
                   str1 = tline(indexStart : indexEnd);
                   if(numMulti  == 1)
                        lossArrayMultiP = [lossArrayMultiP; str2num(str1)];
                   elseif(numMulti == 2)
                        lossArrayMultiR = [lossArrayMultiR; str2num(str1)];                       
                   elseif(numMulti == 3)
                        lossArrayMultiF1 = [lossArrayMultiF1; str2num(str1)];                       
                   end
            end
            
        end
        tline = fgetl(fid);    
    end
    
    numLog = numLog +1;
    tlineList = fgetl(fidList);
end 
   lossArrayMultiP = lossArrayMultiP(2:end);
   lossArrayMultiR = lossArrayMultiR(2:end);
   lossArrayMultiF1 = lossArrayMultiF1(2:end);
   lossIter = [1 : numLog];
   %lossIter = [5000,10000,15000,20000,25000,30000,35000,40000,45000,50000,55000,60000,65000,70000,75000,80000,85000,90000,95000,100000,105000,110000,115000,119537,120000,125000,130000,135000,...
    %  140000,145000,150000,155000,160000,165000,170000,175000,180000,185000,190000,195000,200000,205000,210000,215000,220000,
    % 225000, 230000,235000,240000,245000];
    %draw figure
    figure;h = plot( lossIter, lossArrayMultiP, 'b-',  lossIter, lossArrayMultiR,  'b-', lossIter,lossArrayMultiF1, 'm-');
    title('iteration vs accuracy');	%绘制test accuracy曲线
    legend(h, 'multiP acc','multiR acc','multiF1 acc') %添加图例      
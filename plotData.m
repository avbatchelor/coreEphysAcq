function plotData(stim,settings,data)

figure(1) 
setCurrentFigurePosition(2)

sampTime = (1:length(data.voltage))./settings.sampRate.in;

h(1) = subplot(4,1,1); 
plot(sampTime,data.speakerCommand) 
ylabel('Voltage (V)') 
title('Sound Stimulus') 

h(2) = subplot(4,1,2);
gray = [192 192 192]./255;
startPadEnd = stim.startPadDur*settings.sampRate.in; 
DCOffset = mean(data.piezoSG(1:startPadEnd));
plot(stim.timeVec,DCOffset + stim.stimulus,'Color',gray)
hold on 
plot(sampTime,data.piezoSG)
ylabel('Voltage (V)') 
title(['Piezo: ',stim.description]) 
hold off
ylim([0 10])

h(3) = subplot(4,1,3); 
plot(sampTime,data.voltage) 
title('Voltage') 
ylabel('Voltage (mV)')

h(4) = subplot(4,1,4); 
plot(sampTime,data.current)
xlabel('Time (s)') 
title('Current') 
ylabel('Current (pA)') 

linkaxes(h,'x') 





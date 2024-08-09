function Base_case
clear all
clc
[PL,QL,VD,V,VSI]=Load_Flow; % Load Flow 

%% Results
disp('                            ')
disp('%%%%%%%%%%%%%%%%%%%Base Case Results %%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('------------------------------------------------------')
disp(['Power-Loss (KW):                       ' num2str(round(PL,2))]);
disp(['Reactive Power-Loss (KW):              ' num2str(round(QL,2))]);
disp(['Voltage Deviation:                     ' num2str(round(VD,2))]);
disp(['Voltage Stabiliy Index:                ' num2str(round(VSI,2))]);
disp('------------------------------------------------------')
figure (1);
plot(V,LineWidth=1.5)
title('Voltage Profile')
xlabel('Bus');
set(gca, 'XTick', 1:length(V)); % Set x-axis ticks to match the number of categories
xlim([0.5, length(V) + 0.5]); % Adjust x-axis limits to remove space before the first bar
ylabel('Voltage');
grid on;
end
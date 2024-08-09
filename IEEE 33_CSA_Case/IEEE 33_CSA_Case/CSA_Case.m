function CSA_Case
clear all
clc
[g_best,ConvergenceCurves]=CrowSearchAlgorithm;
[Fit,PL,QL,VD,V,VSI,Pl,Ql,no]=Load_Flow(g_best); % Load Flow 
V_base=load('VOLT_BASE.m');
V_pso=load('V_PSO.m');
P_base=load('P_BASE.m');
Q_base=load('Q_BASE.m');
P_pso=load('P_PSO.m');
Q_pso=load('Q_PSO.m');
Best_COST=load('Best_cost.m');
%% Results
disp('                            ')
disp('%%%%%%%%%%%%%%%%%%% CSA Results with capacitor sizing & placement %%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('------------------------------------------------------')
disp(['Capacitor Size (Mvar):                 ' num2str(round(g_best(1)/1000,4))]);
disp(['Capacitor Location (Bus):              ' num2str(round(g_best(2),0))]);
disp(['Fitness Value (PU):                    ' num2str(round(Fit,4))]);
disp('------------------------------------------------------')
disp('                            ')
disp('%%%%%%%%%%%%%%%%%%% CSA System Results %%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('------------------------------------------------------')
disp(['Power-Loss (KW):                       ' num2str(round(PL,2))]);
disp(['Reactive Power-Loss (Kvar):              ' num2str(round(QL,2))]);
disp(['Voltage Deviation:                     ' num2str(round(VD,2))]);
disp(['Voltage Stabiliy Index:                ' num2str(round(VSI,2))]);
disp('------------------------------------------------------')
% figure (1);
% plot(V,'c',LineWidth=1.5)
% set(gca,'XTick',1:1:no);
% %plot(V,LineWidth=1.5)
% hold on
% plot(V_base,'b',LineWidth=1.5)
% title('Voltage Profile')
% xlabel('Bus');
% ylabel('Voltage');
% legend('CSA Case','Base Case')
% grid on;
% hold off
figure (3);
plot(ConvergenceCurves,LineWidth=1.5)
hold on
plot(Best_COST,LineWidth=1.5)
title('Convergence curves for PSO and CSA')
xlabel('Iteration');
ylabel('Best Value');
legend('CSA Case','PSO Case')
grid on;
% figure (6);
% %bar(Pl*100000,LineWidth=1.5)
% bar(1:length(Pl*100000),Pl*100000,'c');
% set(gca,'XTick',1:1:no)
% title('Active Power Loss CSA')
% xlabel('Bus');
% ylabel('Power (Kw)');
% grid on;
% figure (7);
% %bar(Ql*100000,LineWidth=1.5)
% bar(1:length(Ql*100000),Ql*100000,'c');
% set(gca,'XTick',1:1:no)
% title('Reactive Power Loss CSA')
% xlabel('Bus');
% ylabel('Power (Kvar)');
% grid on;
figure (1);
plot(V,LineWidth=1.5)
hold on
plot(V_base,LineWidth=1.5)
hold on
plot(V_pso,LineWidth=1.5)
title('Voltage Profile')
xlabel('Bus');
set(gca, 'XTick', 1:length(V)); % Set x-axis ticks to match the number of categories
xlim([0.5, length(V) + 0.5]); % Adjust x-axis limits to remove space before the first bar
ylabel('Voltage');
legend('CSA Case','Base Case','PSO Case')
grid on;
hold off
% figure (4);
% plot(ConvergenceCurves,LineWidth=1.5)
% title('Convergence curves')
% xlabel('Iteration');
% ylabel('Best Value');
% grid on;
figure (5);
bar(P_base,LineWidth=1.5)
hold on
bar(P_pso,LineWidth=1.5)
hold on
bar(Pl*100000,LineWidth=1.5)
title('ACTIVE Power Loss')
xlabel('Line');
set(gca, 'XTick', 1:length(Pl)); % Set x-axis ticks to match the number of categories
xlim([0.5, length(Pl) + 0.5]); % Adjust x-axis limits to remove space before the first bar
ylabel('Active Power (Kw)');
grid on;
legend('Base Case','PSO Case','CSA Case')
figure (4);
bar(Q_base,LineWidth=1.5)

hold on
bar(Q_pso,LineWidth=1.5)
hold on
bar(Ql*100000,LineWidth=1.5)
title('REACTIVE Power Loss')
xlabel('Line');
set(gca, 'XTick', 1:length(Ql)); % Set x-axis ticks to match the number of categories
xlim([0.5, length(Ql) + 0.5]); % Adjust x-axis limits to remove space before the first bar
ylabel('Reactive Power (Kvar)');
grid on;
legend('Base Case','PSO Case','CSA Case')
end
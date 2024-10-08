%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YOEA112
% Project Title: Implementation of Firefly Algorithm (FA) in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Firefly Algorithm (FA) in MATLAB (URL: https://yarpiz.com/259/ypea112-firefly-algorithm), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%



%% Problem Definition
function [g_best,BestCost]=fa
format long;
%CostFunction = @(x) Rosenbrock(x);        % Cost Function

nVar = 2;                 % Number of Decision Variables

VarSize = [1 nVar];       % Decision Variables Matrix Size

VarMin = [1000 2];             % Decision Variables Lower Bound
VarMax = [2300 33];             % Decision Variables Upper Bound

%% Firefly Algorithm Parameters

MaxIt = 100;         % Maximum Number of Iterations

nPop = 50;            % Number of Fireflies (Swarm Size)

gamma = 1;            % Light Absorption Coefficient

beta0 = 2;            % Attraction Coefficient Base Value

alpha = 0.2;          % Mutation Coefficient

alpha_damp = 0.98;    % Mutation Coefficient Damping Ratio

delta = 0.05*(VarMax-VarMin);     % Uniform Mutation Range

m = 2;

if isscalar(VarMin) && isscalar(VarMax)
    dmax = (VarMax-VarMin)*sqrt(nVar);
else
    dmax = norm(VarMax-VarMin);
end

%% Initialization

% Empty Firefly Structure
firefly.Position = [];
firefly.Cost = [];

% Initialize Population Array
pop = repmat(firefly, nPop, 1);

% Initialize Best Solution Ever Found
GlobalBest.Cost = inf;

% Create Initial Fireflies
for i = 1:nPop
   pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
   pop(i).Cost = Load_Flow(pop(i).Position);
   
   if pop(i).Cost <= GlobalBest.Cost
       GlobalBest = pop(i);
   end
end

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);

%% Firefly Algorithm Main Loop

for it = 1:MaxIt
    
    newpop = repmat(firefly, nPop, 1);
    for i = 1:nPop
        newpop(i).Cost = inf;
        for j = 1:nPop
            if pop(j).Cost < pop(i).Cost
                rij = norm(pop(i).Position-pop(j).Position)/dmax;
                beta = beta0*exp(-gamma*rij^m);
                e = delta*unifrnd(-1, +1, VarSize);
                %e = delta*randn(VarSize);
                
                newsol.Position = pop(i).Position ...
                                + beta*rand(VarSize).*(pop(j).Position-pop(i).Position) ...
                                + alpha*e;
                
                newsol.Position = max(newsol.Position, VarMin);
                newsol.Position = min(newsol.Position, VarMax);
                
                newsol.Cost = Load_Flow(newsol.Position);
                
                if newsol.Cost <= newpop(i).Cost
                    newpop(i) = newsol;
                    if newpop(i).Cost <= BestSol.Cost
                        BestSol = newpop(i);
                    end
                end
                
            end
        end
    end
    
    % Merge
    pop = [pop
         newpop];  %#ok
    
    % Sort
    [~, SortOrder] = sort([pop.Cost]);
    pop = pop(SortOrder);
    
    % Truncate
    pop = pop(1:nPop);
    
    % Store Best Cost Ever Found
    BestCost(it) = GlobalBest.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Damp Mutation Coefficient
    alpha = alpha*alpha_damp;
    
end
g_best=GlobalBest.Position;


% %% Results
% 
% figure;
% %plot(BestCost, 'LineWidth', 2);
% semilogy(BestCost, 'LineWidth', 2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;

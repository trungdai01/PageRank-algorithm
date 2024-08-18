clear;

%% Task 1
load('materials\AdjMatrix.mat');
nnzAdjMatrix = nnz(AdjMatrix) / numel(AdjMatrix);

%% Task 2
[m, n] = size(AdjMatrix);

%% Task 3
NumNetwork = 500;
AdjMatrixSmall = AdjMatrix(1:NumNetwork, 1:NumNetwork);
coordinates = zeros(NumNetwork, 2);

for j = 1:NumNetwork
    coordinates(j, 1) = NumNetwork * rand;
    coordinates(j, 2) = NumNetwork * rand;
end

gplot(AdjMatrixSmall, coordinates, 'k-*');

%% Task 4
alpha = 0.15;
NumLinks = sum(AdjMatrixSmall, 2);
S = zeros(NumNetwork, NumNetwork);

for index = 1:NumNetwork

    if NumLinks(index) ~= 0
        S (index, :) = AdjMatrixSmall(index, :) ./ NumLinks(index);
    else
        S (index, :) = 1 ./ NumNetwork;
    end

end

E = ones(NumNetwork, NumNetwork) ./ NumNetwork;
GoogleMatrix = (1 - alpha) * S + alpha * E;

w0 = ones(1, NumNetwork) / NumNetwork;
w1 = w0 * GoogleMatrix;
w2 = w1 * GoogleMatrix;
w3 = w2 * GoogleMatrix;
w5 = w0 * (GoogleMatrix) ^ 5;
w10 = w0 * (GoogleMatrix) ^ 10;

w20 = w0 * (GoogleMatrix) ^ 20;

deltaw = w20 - w10;

%% Task 5
[VectorRight, LambdaRight] = eig(GoogleMatrix);
LambdaRight = diag(LambdaRight);

[VectorLeft, LambdaLeft] = eig(GoogleMatrix');
LambdaLeft = diag(LambdaLeft);

u1 = VectorLeft(:, 1);

%% Task 6
u1 = abs(u1) / norm(u1, 1);

%% Task 7
[MaxRank, PageMaxRank] = max(u1);

%% Task 8
MostLinks = sum(GoogleMatrix);
[MaxLinks, PageMaxLinks] = max(MostLinks);

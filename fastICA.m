% Done by: Vishnu P S
% This function performs fastICA

function [ind_comps,w] = fastICA(mixed_sig)

    [num_sources, numSamples] = size(mixed_sig);
    % Parameters
    last_pc          = num_sources;
    maxNumIterations    = 1000;
    a1 = 1.5;

    %% Mean centering

    % Adding each row
    row_sum = zeros(num_sources,1);
    for i=1:num_sources
        for j=1:numSamples
            row_sum(i) = row_sum(i) + mixed_sig(i,j);
        end
    end

    % Dividing with num.cols
    row_mean = zeros(num_sources,1);
    for i=1:num_sources
        row_mean(i) = row_sum(i)/numSamples;
    end

    % subtracting mean from each row
    mean_removed_data = zeros(num_sources,numSamples);
    for i=1:num_sources
        for j=1:numSamples
            mean_removed_data(i,j) = mixed_sig(i,j) - row_mean(i);
        end
    end

    %% Whitening

    % pca through covariance matrix & eigen decomposition
    covMatrix = (mean_removed_data * mean_removed_data')./numSamples;
    [E, D] = eigs (covMatrix,last_pc);
    tolerance = 1e-7;
    selD = sum(diag(D) > tolerance);
    D = D(1:selD,1:selD);
    E = E(:,diag(D) > tolerance);
    whit_mat = inv(sqrt(D))*E';
    whitened_data = whit_mat*mean_removed_data;
    num_sources = size(whitened_data,1);

    guess = eye(size(whitened_data,1),size(whitened_data,2));
    B = zeros(num_sources);

    for j = 1:num_sources
       
        w=whit_mat*guess(:,j);
        wOld = zeros(size(w));

        for i = 1 : maxNumIterations

                w = w - B * B' * w; %orthogonalization
                w = w / norm(w);

                if (abs(dot(w,wOld))>0.9)
                    B(:, j) = w;
                    W(j,:) = w' * whit_mat;
                    break;
                end

                wOld = w;

                hypTan = tanh(a1 * whitened_data' * w);
	            w = (whitened_data * hypTan - a1 * sum(1 - hypTan .^ 2)' * w) / numSamples;
                w = w / norm(w);                
        end
    end
    ind_comps = W * mean_removed_data + (W * row_mean);
end

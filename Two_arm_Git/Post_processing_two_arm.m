% MATLAB post processing Two Arm

% clear workspace and the command window 
clear;clc;close all

% cumulative reward loading
cum_reward = readmatrix("reward_j.txt");
cum_reward_L = readmatrix("reward_L.txt");
cum_reward_R = readmatrix("reward_R.txt");
success_term = cum_reward(cum_reward > 0);
var_cum_reward = var(cum_reward);

% arrays determing points of terminations 
cum_rew_term = zeros(length(cum_reward)+1,1);
for i = 2:length(cum_reward)
    if (cum_reward(i) > 0)
        cum_rew_term(i) = cum_rew_term(i-1) + 1;
    else 
        cum_rew_term(i) = cum_rew_term(i-1);
    end
end 
if (cum_reward(end) > 0)
    cum_rew_term(end) = cum_rew_term(end-1) + 1;
end 
cum_rew_term(1) = [];

% final Euclidean distance 
fEuclid = readmatrix("fEuclid_j.txt");
var_fEuclid = var(fEuclid);
fE_conv = fEuclid(fEuclid < 0.02);

% final Euclidean distance (Left)  
fEuclidL = readmatrix("fEuclid_L_j.txt");
var_fEuclidL = var(fEuclidL);
fE_L_conv = fEuclidL(fEuclidL < 0.02);

% final Euclidean distance (Right)
fEuclidR = readmatrix("fEuclid_R_j.txt");
var_fEuclidR = var(fEuclidR);
fE_R_conv = fEuclidR(fEuclidR < 0.02);

% final Quaternion difference 
fQuat = readmatrix("fQuat_j.txt");
var_fQ = var(fQuat);
fQ_conv = fQuat(fQuat < 0.2);

% final Quaternion difference (Left)
fQuatL = readmatrix("fQuat_L_j.txt");
var_fQL = var(fQuatL);
fQ_convL = fQuatL(fQuatL < 0.2);

% final Quaternion difference (Right)
fQuatR = readmatrix("fQuat_R_j.txt");
var_fQR = var(fQuatR);
fQ_convR = fQuatR(fQuatR < 0.2);

% fitting a polynomial to the data (Two arms)
[p_r, S_r] = polyfit(1:length(cum_reward),cum_reward,2);
[p_fE, S_fE] = polyfit(1:length(fEuclid),fEuclid,2);
[p_fQ, S_fQ] = polyfit(1:length(fQuat),fQuat,2);

% fitting a polynomial to the data (Left arm) 
[p_rL, S_rL] = polyfit(1:length(cum_reward_L),cum_reward_L,2);
[p_fEL, S_fEL] = polyfit(1:length(fEuclidL),fEuclidL,2);
[p_fQL, S_fQL] = polyfit(1:length(fQuatL),fQuatL,2);

% fitting a polynomial to the data (Right arm) 
[p_rR, S_rR] = polyfit(1:length(cum_reward_R),cum_reward_R,2);
[p_fER, S_fER] = polyfit(1:length(fEuclidR),fEuclidR,2);
[p_fQR, S_fQR] = polyfit(1:length(fQuatR),fQuatR,2);

% calculating the best fit y axis values (Two arms)
[y_r, delta_r] = polyval(p_r,1:length(cum_reward),S_r);
[y_fE, delta_fE] = polyval(p_fE,1:length(fEuclid),S_fE);
[y_fQ, delta_fQ] = polyval(p_fQ,1:length(fQuat),S_fQ);

% calculating the best fit y axis values (Left arm)
[y_rL, delta_rL] = polyval(p_rL,1:length(cum_reward_L),S_rL);
[y_fEL, delta_fEL] = polyval(p_fEL,1:length(fEuclidL),S_fEL);
[y_fQL, delta_fQL] = polyval(p_fQL,1:length(fQuatL),S_fQL);

% calculating the best fit y axis values (Left arm)
[y_rR, delta_rR] = polyval(p_rR,1:length(cum_reward_R),S_rR);
[y_fER, delta_fER] = polyval(p_fER,1:length(fEuclidR),S_fER);
[y_fQR, delta_fQR] = polyval(p_fQR,1:length(fQuatR),S_fQR);

% moving filter coefficients
filt_coeffs = ones(1, 1000) / 1000; 
% moving filter reward (Two arms)
filt_cum_rewards = filter(filt_coeffs, 1, cum_reward);

% moving filter reward (Left)
filt_cum_rewardsL = filter(filt_coeffs, 1, cum_reward_L);

% moving filter reward (Right)
filt_cum_rewardsR = filter(filt_coeffs, 1, cum_reward_R);

% moving filter final Euclidean distance (Two arm)
filt_e_dist = filter(filt_coeffs, 1, fEuclid);

% moving filter final Euclidean distance (Left)
filt_e_distL = filter(filt_coeffs, 1, fEuclidL);

% moving filter final Euclidean distance (Right)
filt_e_distR = filter(filt_coeffs, 1, fEuclidR);

% moving filter final Quaternion difference (Two arms)
filt_q_diff = filter(filt_coeffs, 1, fQuat);

% moving filter final Quaternion difference (Left)
filt_q_diffL = filter(filt_coeffs, 1, fQuatL);

% moving filter final Quaternion difference (Right)
filt_q_diffR = filter(filt_coeffs, 1, fQuatR);

% plotting actual training data
figure;
subplot(3,2,1)
plot(1:length(cum_reward),cum_reward,'.')
xlabel("Episode Number")
ylabel("Cumulative Reward")
title("Cummalative Rewards VS Episode Number (R1)")

subplot(3,2,3)
plot(1:length(fEuclid),fEuclid,'.')
xlabel("Episode Number")
ylabel("Final Euclidean Distance (m)")
title("Final Euclidean Distance VS Episode Number (R1)")

subplot(3,2,4)
plot(1:length(fEuclidL),fEuclidL,'.')
xlabel("Episode Number")
ylabel("Final Euclidean Distance (m)")
title("Final Euclidean Distance (L) VS Episode Number (R1)")

subplot(3,2,5)
plot(1:length(fQuat),fQuat,'.')
xlabel("Episode Number")
ylabel("Final Quaternion Difference (rad)")
title("Final Quaternion Difference VS Episode Number (R1)")

subplot(3,2,6)
plot(1:length(fQuatL),fQuatL,'.')
xlabel("Episode Number")
ylabel("Final Quaternion Difference (rad)")
title("Final Quaternion Difference (L) VS Episode Number (R1)")

% plotting Quadratic LOBF 
figure;
subplot(3,2,1)
plot(1:length(cum_reward),y_r)
xlabel("Episode Number")
ylabel("Cumulative Reward")
title("LOBF Cummalative Rewards VS Episode Number (R1)")

subplot(3,2,2)
plot(1:length(cum_reward),cum_rew_term)
xlabel("Episode Number")
ylabel("Number of terminations")
title("Number of terminations VS Episode Number (R1)")

subplot(3,2,3)
plot(1:length(fEuclid),y_fE)
xlabel("Episode Number")
ylabel("Final Euclidean Distance (m)")
title("LOBF Final Euclidean Distance VS Episode Number (R1)")

subplot(3,2,4)
plot(1:length(fEuclidL),y_fEL)
xlabel("Episode Number")
ylabel("Final Euclidean Distance (m)")
title("LOBF Final Euclidean Distance (L) VS Episode Number (R1)")

subplot(3,2,5)
plot(1:length(fQuat),y_fQ)
xlabel("Episode Number")
ylabel("Final Quaternion Difference (rad)")
title("LOBF Final Quaternion Difference VS Episode Number (R1)")

subplot(3,2,6)
plot(1:length(fQuatL),y_fQL)
xlabel("Episode Number")
ylabel("Change in Quaternion Difference (rad)")
title("LOBF final Quaternion Difference (L) VS Episode Number (R1)")

% plotting almost all meaningful graphs 
figure;
subplot(3,3,1)
plot(1:length(cum_reward),cum_reward,'.')
xlabel("Episode Number")
ylabel("Cumulative Reward")
title("Cummalative Rewards VS Episode Number (R1)")

subplot(3,3,2)
plot(1:length(cum_reward),y_r)
xlabel("Episode Number")
ylabel("Cumulative Reward")
title("LOBF Cummalative Rewards VS Episode Number (R1)")

subplot(3,3,3)
plot(1:length(cum_reward),filt_cum_rewards)
xlabel("Episode Number")
ylabel("Cumulative Reward")
title("MA Cummalative Rewards VS Episode Number (R1)")

subplot(3,3,4)
plot(1:length(fEuclid),fEuclid,'.')
xlabel("Episode Number")
ylabel("F Euclidean Distance (m)")
title("Final Euclidean Distance VS Episode Number (R1)")

subplot(3,3,5)
plot(1:length(fEuclid),y_fE)
xlabel("Episode Number")
ylabel("F Euclidean Distance (m)")
title("LOBF Final Euclidean Distance VS Episode Number (R1)")

subplot(3,3,6)
plot(1:length(fEuclid),filt_e_dist)
xlabel("Episode Number")
ylabel("F Euclidean Distance (m)")
title("MA Final Euclidean Distance VS Episode Number (R1)")


subplot(3,3,7)
plot(1:length(fQuat),fQuat,'.')
xlabel("Episode Number")
ylabel("F Quaternion Difference (rad)")
title("Final Quaternion Difference VS Episode Number (R1)")

subplot(3,3,8)
plot(1:length(fQuat),y_fQ)
xlabel("Episode Number")
ylabel("F Quaternion Difference (rad)")
title("LOBF Final Quaternion Difference VS Episode Number (R1)")

subplot(3,3,9)
plot(1:length(fQuat),filt_q_diff)
xlabel("Episode Number")
ylabel("F Quaternion Difference (rad)")
title("MA Final Quaternion Difference VS Episode Number (R1)")
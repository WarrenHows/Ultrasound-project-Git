% MATLAB post processing J R1

% clear workspace and the command window 
clear;clc;close all

% cumulative reward loading
cum_reward = readmatrix("reward_j1.txt");
var_cum_reward = var(cum_reward);

% final Euclidean distance  
fEuclid = readmatrix("fEuclid_j1.txt");
var_fEuclid = var(fEuclid);
fE_conv = fEuclid(fEuclid < 0.02);

% the change in Euclidean difference 
cEuclid = readmatrix("cEuclid_j1.txt");
var_cE = var(cEuclid);

% final Quaternion difference 
fQuat = readmatrix("fQuat_j1.txt");
var_fQ = var(fQuat);
fQ_conv = fQuat(fQuat < 0.2);

% the change in Quaternion difference
cQuat = readmatrix("cQuat_j1.txt");
var_cQ = var(cQuat);

% fitting a polynomial to the data 
[p_r, S_r] = polyfit(1:length(cum_reward),cum_reward,2);
[p_fE, S_fE] = polyfit(1:length(fEuclid),fEuclid,2);
[p_cE, S_cE] = polyfit(1:length(cEuclid),cEuclid,2);
[p_fQ, S_fQ] = polyfit(1:length(fQuat),fQuat,2);
[p_cQ, S_cQ] = polyfit(1:length(cQuat),cQuat,2);

% calculating the best fit y axis values
[y_r, delta_r] = polyval(p_r,1:length(cum_reward),S_r);
[y_fE, delta_fE] = polyval(p_fE,1:length(fEuclid),S_fE);
[y_cE, delta_cE] = polyval(p_cE,1:length(cEuclid),S_cE);
[y_fQ, delta_fQ] = polyval(p_fQ,1:length(fQuat),S_fQ);
[y_cQ, delta_cQ] = polyval(p_cQ,1:length(cQuat),S_cQ);

% moving filter reward
filt_r_coeffs = ones(1, 1000) / 1000;
filt_cum_rewards = filter(filt_r_coeffs, 1, cum_reward);

% moving filter final Euclidean distance
filt_e__coeffs = ones(1, 1000) / 1000;
filt_e_dist = filter(filt_e__coeffs, 1, fEuclid);

% moving filter final Quaternion difference 
filt_q_coeffs = ones(1, 1000) / 1000;
filt_q_diff = filter(filt_q_coeffs, 1, fQuat);

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
plot(1:length(cEuclid),cEuclid,'.')
xlabel("Episode Number")
ylabel("Change in Euclidean Distance (m)")
title("Change in Euclidean Distance VS Episode Number (R1)")

subplot(3,2,5)
plot(1:length(fQuat),fQuat,'.')
xlabel("Episode Number")
ylabel("Final Quaternion Difference (rad)")
title("Final Quaternion Difference VS Episode Number (R1)")

subplot(3,2,6)
plot(1:length(cQuat),cQuat,'.')
xlabel("Episode Number")
ylabel("Change in Quaternion Difference (rad)")
title("Change in Quaternion Difference VS Episode Number (R1)")

% plotting LOBF 
figure;
subplot(3,2,1)
plot(1:length(cum_reward),y_r)
xlabel("Episode Number")
ylabel("Cumulative Reward")
title("LOBF Cummalative Rewards VS Episode Number (R1)")

subplot(3,2,3)
plot(1:length(fEuclid),y_fE)
xlabel("Episode Number")
ylabel("Final Euclidean Distance (m)")
title("LOBF Final Euclidean Distance VS Episode Number (R1)")

subplot(3,2,4)
plot(1:length(cEuclid),y_cE)
xlabel("Episode Number")
ylabel("Change in Euclidean Distance (m)")
title("LOBF Change in Euclidean Distance VS Episode Number (R1)")

subplot(3,2,5)
plot(1:length(fQuat),y_fQ)
xlabel("Episode Number")
ylabel("Final Quaternion Difference (rad)")
title("LOBF Final Quaternion Difference VS Episode Number (R1)")

subplot(3,2,6)
plot(1:length(cQuat),y_cQ)
xlabel("Episode Number")
ylabel("Change in Quaternion Difference (rad)")
title("LOBF Change in Quaternion Difference VS Episode Number (R1)")

% plotting all meaningful graphs 

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
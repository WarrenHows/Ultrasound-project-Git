# Reinforcement Learning for Dual Probe Ultrasound application 
This project is currently made up of two seperate but related objectives. 
These two objectives are to provide the groundwork for a Reinforcement Learning algorithm which can eventually perform autonomous ultrasound scans for foetal abnormality detection. 
The first, present in One_arm_git, is the creation of an RL Environment for the training of one of the Dual Probe robot's arms to move to target position and orientations in 3D space.
The second, present in Two_arm_git, is the creation of an RL Environment for the training of both of the Dual Probe robot's to move to target positions and orientations.   
The current objectives are an attempt for the robot to learn how to move efficiently within its desired workspace which is essential for foetal sonograms. 

## One_arm_git explained
The file "JRun" is the main script containing the Environment instantiation and the RL Aglorithm instantiation. The training is also done (directly) from the script as well. 
The folder "Housden created STL and URDF 5" contains all of the robots contents. The URDF file and the STL files which are needed for the robots training.
The file "post_processing_j_R1" contains MATLAB code which when run after training has been completed, plots and analyses the training results.

## Two_arm_git explained 
The file "TwoArm" is the main script containing the Environment instantiation and the RL Aglorithm instantiation. The training is also done (directly) from the script as well.
There are two URDF files present, "TwoArm" and "TwoArm_col". "TwoArm" when simulated cannot account for collisions whereas "TwoArm_col" can. 
The text file present "TwoArmCommented" contains comments in the URDF file for a breakdown of how the URDF is written.
The file "post_processing_two_arm_R1" contains MATLAB code which when run after training has been completed, plots and analyses the training results.

## Useful Resources for RL 
Multi-Agent and PPO: https://huggingface.co/learn/deep-rl-course/en/unitbonus3/generalisation
Reinforcement Learning beginning to end: Open AI Spinning Up and Hugging Face Reinforcement Learning Tutorial 

## To work on
The code works for training the 1 arm robot however the 2 arm robot training does not seem to work and hits peak performance roughly after 3 million timesteps of training. Training is incredibly long and computationally taxing. A new reward function needs to be devised for the 2 arm robot to succesfully be trained as the current one does not work for this purpose. The code also is believed to have inefficiencies such as using lists instead of numpy arrays and the use of loops instead of vectorisation and etc. Also the code can be simplified in many ways which may remove unknown problems in the code. For example all normalisation is done manually using normalise functions however using scikit learn functions such as standard scaler as an alternative could make the code more understandable and address any mistakes that may have been made when I implmented all of these functions naively.  

# M-Scripts
MATLAB/GNU Octave M-files for models and controllers used in lectures on mechatronic systems **MTS**.
Tested with MATLAB + CST and with GNU Octave + Control- + Symbolic-Package.

File | Description
--- | ---
**Antrieb.m** | LS (Least Squares Method) applied to model of DC-motor with all data
**Antrieb_Ausg_Vekt.csv** | Output vector for RLS of DC-motor
**Antrieb_Messmatr.csv** | Measurement matrix for RLS of DC-motor
**Antrieb_RLS.m** | RLS (Recursive Least Squares) applied to model of DC-motor
**cont2dis.m** | MTS I: Z transformation with MATLAB / Octave
**ElemUebertr.m** | MTS I: Basic transfer elements
**P_T2.m** | Pole Zero Map of example control system, continuous and discrete
**RK_DB_F.m** | Discrete control loop with Dead-Beat controller for follow up control without dead time
**RK_DB_F_d.m** | Discrete control loop with Dead-Beat controller for follow up control with discrete dead time
**RK_DB_S.m** | Discrete control loop with Dead-Beat controller for disturbance control without dead time
**RK_DB_S_d.m** | Discrete control loop with Dead-Beat controller for disturbance control with discrete dead time
**RK_MV.m** | Discrete control loop with Minimal-Variance controller for disturbance control without dead time

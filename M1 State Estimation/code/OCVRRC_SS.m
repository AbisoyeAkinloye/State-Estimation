function [V_vec, SoC_vec] = OCVRRC_SS(Current)
    % model paramters
    R1 = 0.0045; 
    R0 = 0.0096; 
    C1 = 3860.14;
    Tao = C1 * R1;
    Cn = 5.4 * 3600;
    DeltaT = 1;
    
    soc_ocv = readtable("../data/soc_ocv_profile-3.csv","VariableNamingRule","preserve");
    soc_ocv = table2array(soc_ocv);

    % initialization
    SoC_init = 0.2;
    V1_init = 0;
    X = [V1_init; SoC_init];

    % state space matrices
    A = [1-DeltaT/Tao 0; 0 1];
    B = [DeltaT/C1; DeltaT/Cn];

    % Accumulator
    V_vec = [];
    SoC_vec = [];

    % model
    Current = table2array(Current);
    for k = 1:length(Current)
        U = Current(k);
        X = A*X + B*U;
        
        SoC = X(2);
        OCV = pchip(soc_ocv(:,1), soc_ocv(:,2), SoC);
        V1 = X(1);

        TerminalVoltage = OCV - (R0 * U) - V1;

        V_vec = [V_vec; TerminalVoltage];
        SoC_vec = [SoC_vec; SoC];

    end
end
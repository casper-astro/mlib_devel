adc0_file = fopen('adc0_data.txt','r');
adc0_all = fscanf(adc0_file, '%i');
adc0_i = adc0_all(1:4096);
adc0_q = adc0_all(4097:8192);

adc1_file = fopen('adc1_data.txt','r');
adc1_all = fscanf(adc1_file, '%i');
adc1_i = adc1_all(1:4096);
adc1_q = adc1_all(4097:8192);

adc2_file = fopen('adc2_data.txt','r');
adc2_all = fscanf(adc2_file, '%i');
adc2_i = adc2_all(1:4096);
adc2_q = adc2_all(4097:8192);

adc3_file = fopen('adc3_data.txt','r');
adc3_all = fscanf(adc3_file, '%i');
adc3_i = adc3_all(1:4096);
adc3_q = adc3_all(4097:8192);

%figure
%plot(adc0_i)
%figure
%plot(adc0_q)

% adc0_i_fft = fft(adc0_i);
% figure 
% plot(0:4095, abs(adc0_i_fft))
% adc0_q_fft = fft(adc0_q);
% figure
% plot(0:4095, abs(adc0_q_fft))
% 
% adc1_i_fft = fft(adc1_i);
% figure 
% plot(0:4095, abs(adc1_i_fft))
% adc1_q_fft = fft(adc1_q);
% figure
% plot(0:4095, abs(adc1_q_fft))
% 
% adc2_i_fft = fft(adc2_i);
% figure 
% plot(0:4095, abs(adc2_i_fft))
% adc2_q_fft = fft(adc2_q);
% figure
% plot(0:4095, abs(adc2_q_fft))
% 
% adc3_i_fft = fft(adc3_i);
% figure 
% plot(0:4095, abs(adc3_i_fft))
% adc3_q_fft = fft(adc3_q);
% figure
% plot(0:4095, abs(adc3_q_fft))

adc0_comp = adc0_i + i * adc0_q;
adc0_fft = fft(adc0_comp);
figure 
plot(0:4095, abs(adc0_fft))
adc1_comp = adc1_i + i * adc1_q;
adc1_fft = fft(adc1_comp);
figure 
plot(0:4095, abs(adc1_fft))
adc2_comp = adc2_i + i * adc2_q;
adc2_fft = fft(adc2_comp);
figure 
plot(0:4095, abs(adc2_fft))
adc3_comp = adc3_i + i * adc3_q;
adc3_fft = fft(adc3_comp);
figure 
plot(0:4095, abs(adc3_fft))




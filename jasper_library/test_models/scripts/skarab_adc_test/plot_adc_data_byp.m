% This MATLAB script is used to plot the synchronised ADC sample data that was captured and stored in text files by the skarab_adc_test.py Python script. It reads the sample data of each channel stored in the adc_data_byp/ directory and then overlays it all on the same plot.

files = dir(fullfile("adc_data_byp", '*.txt'));
files.name;
format long
figure
hold on
for itr = 1:length(files)
	adc_file = fopen(strcat('adc_data_byp/',files(itr).name),'r');
	adc_samples = fscanf(adc_file, '%f');
	plot(adc_samples);
end
hold off
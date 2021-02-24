files = dir(fullfile("adc_data", '*.txt'));
files.name

figure
hold on
for itr = 1:length(files)
	adc_file = fopen(strcat('adc_data/',files(itr).name),'r');
	adc_samples = fscanf(adc_file, '%f');
	plot(adc_samples)
end
hold off

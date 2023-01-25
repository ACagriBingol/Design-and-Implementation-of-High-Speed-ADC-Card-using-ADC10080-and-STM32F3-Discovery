clc ; close all ; clear;

fs=14e6;

% Set up serial port communication
s = serialport('COM11', 115200,"Timeout",1000);  % Replace 'COM1' with the correct port name on your system

% Set up variables
max_array_size = 16384;  % Maximum size of the array
array = zeros(1, max_array_size);  % Initialize the array
array_index = 1;  % Index of the next element to be added to the array

while true
  % Read data from the serial port
  data = read(s,6,"string");
  % Convert data from string to integer
  value = str2double(data);
  
  value=value*0.0029296875;
  
  % Save value to the array
  array(array_index) = value;
  array_index = array_index + 1;
  
  % If the array is full, stop reading data
  if array_index > max_array_size
    break;
  end
end


% Plot the data in the array
figure
plot(array);

% Apply FFT to the data in the array
array_fft = fft(array);
m=length(array_fft);
freq=(-m/2:((m/2)-1))*fs/(m-1);

% Plot the magnitude of the FFT
figure
plot(freq,fftshift(abs(array_fft)));%freq - domain

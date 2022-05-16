%% Reading Audio File

% Datastore for collection of readable audio files in current MATLAB folder
ADS = audioDatastore(cd,'FileExtensions',{'.wav','.ogg','.oga','.flac','.au',...
    '.aiff','.aif','.aifc','.mp3','.m4a','.mp4'});

% Initializing 'myaudiofiles' cell array
myaudiofiles = cell(1,size(ADS.Files,1));

% Finding and displaying filenames of readable audio files and storing them in 'myaudiofiles'
fprintf('\nAudio Files:\n')
for i=1:size(ADS.Files,1)
    [~,name,ext] = fileparts(ADS.Files{i});
    myaudiofiles{i}=[name,ext];
    fprintf([num2str(i),'. ',myaudiofiles{i},'\n'])
end

% Reading audio file based on user input
infile = input('\nEnter the number corresponding to the audio file to be loaded: ');
if ismember(infile,[1:size(ADS.Files,1)])
    [in,fs] = audioread(myaudiofiles{infile});
    fprintf(['"',myaudiofiles{infile},'" successfully loaded.\n\n'])
else
    error('File Not Found.')
end

%% Parameter Settings
        preset = input(['\nSimple Equalizer Presets:\n0. Flat\n1. +10dB Low Boost\n2. +10dB '...
            'Mid Boost\n3. +10dB High Boost\n4. -10dB Low Cut\n5. -10dB Mid Cut\n6. -10dB '...
            'High Cut\n7. Custom\n\n'...
            'Select the number corresponding to the preset of your choice: ']);
        [G_low,G_mid,G_high] = EqParameters(preset);
        

%% Function Call


        [h_low,h_mid,h_high,h_eq,w,b,a] = EqFunc(fs,G_low,G_mid,G_high);


%% Output Demonstration

out = filter(b,a,in);
out = out./max(max(abs(out)));

% Created Equalizing Filter Response
        figure('Name','Simple Equalizer')
        subplot(2,1,1)
        semilogx(fs*w/(2*pi),20*log10(abs(h_low)),'Color',[0 0.447 0.741],'LineWidth',2)
        hold on
        semilogx(fs*w/(2*pi),20*log10(abs(h_mid)),'Color',[0.85 0.325 0.098],'LineWidth',2)
        semilogx(fs*w/(2*pi),20*log10(abs(h_high)),'Color',[0.929 0.694 0.125],'LineWidth',2)
        hold off
        grid on
        xlim([20 20000])
        title('Individual Filter Responses')
        xlabel('Frequency (in Hz)')
        ylabel('Gain (in dB)')
        legend('Low Shelf','Mid Peak','High Shelf','Location','best')
        subplot(2,1,2)
        semilogx(fs*w/(2*pi),20*log10(abs(h_eq)),'Color','k','LineWidth',2)
        grid on
        xlim([20 20000])
        title('Equalizer Amplitude Response')
        xlabel('Frequency (in Hz)')
        ylabel('Gain (in dB)')

% Input & Output Audio Playback
fprintf('\nPlaying original audio. Press any key in command window to continue...\n')
sound(in,fs)
pause
fprintf('Playing equalized audio...\n')
sound(out,fs)
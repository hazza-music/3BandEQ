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
    fprintf(['"',myaudiofiles{infile},'" successfully loaded.\n'])
else
    error('File Not Found.')
end

%% Parameter Settings
% Obtaining Cutoff Frequencies
lowCutoff = input(['\nPlease enter Low Cutoff Frequency (200 is a good base)\nFrequency: ']); % 200 for low
highCutoff = input(['\nPlease enter High Cutoff Frequency (5000 is a good base)\nFrequency: ']); % 5000 for low

        preset = input(['\nSimple Equalizer Presets:\n0. Flat\n1. +10dB Low Boost\n2. +10dB '...
            'Mid Boost\n3. +10dB High Boost\n4. -10dB Low Cut\n5. -10dB Mid Cut\n6. -10dB '...
            'High Cut\n7. Custom\n\n'...
            'Select the number corresponding to the preset of your choice: ']);
        [G_low,G_mid,G_high] = EqParameters(preset);
        outputText = presetToType(preset);

%% Function Call
        [h_low,h_mid,h_high,h_eq,w,b,a] = EqFunc(fs,G_low,G_mid,G_high, lowCutoff, highCutoff);

%% Loudness Option

loudnessChoice = input(['\nLoudness Control?\n0. No\n1. Yes\nSelect your choice: ']);

%% Output Demonstration

out = filter(b,a,in);
out = out./max(max(abs(out)));
out = LoudnessWeighting(loudnessChoice, in, fs);

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
%% Saving Output Audio File

% Generating created audio filename based on user response
    out_filename = [myaudiofiles{infile}(1:find(ismember(myaudiofiles{infile},'.'),1,'last')-1),...
        '_EQ_',outputText,'.wav'];

% Saving audio file
audiowrite(out_filename,out,fs)
fprintf(['\n"',out_filename,'" successfully saved.\n\n'])
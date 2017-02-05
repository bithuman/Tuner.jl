function FrequencyView()
	 Plots.gr()
	 stream = PortAudio.PortAudioStream() 
	 factor = 10
 	 num_samples = Int(44100/factor)
     xaxis = (0:1:num_samples-1)*factor
	 while(true)  
       d = PortAudio.read(stream.source, num_samples)
       yaxis = abs(fft(d.data[:,1]))/maximum(abs(fft(d.data[:,1])))
       Plots.plot(xaxis,yaxis,
       xlim =(-10,1200),
       ylim = (0,1),
       xticks = 0:100:1200,
       lab = string(peak_freak(d.data[:,1],factor)),
       )
       Plots.gui()
     end
end

function peak_freak(data,factor)
	num_samples = length(data)
	return indmax(abs(fft(data))[1:1:Int(floor(.5*num_samples))])*factor
end
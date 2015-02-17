require 'thin'
require 'sinatra'
require 'sinatra/streaming'
require 'json'
require 'eventmachine'
require 'em-http-request'

set :server, 'thin'

log_file = "dtrace.log"

get '/' do
  erb :index
end


# Stream output from DTrace.  
# For this to work, first make sure the DTrace is running. Currently the way this is set up is to have DTrace (which requires sudo) output to a log file in real time, and then read from the tail of the log file. From the project directory run: 
# sudo DTrace -n 'syscall::open*:entry { printf("[%s],%s",execname,copyinstr(arg0)); }' > dtrace.log

get '/log' do
  content_type 'text/event-stream'
  
  stream(:keep_open) do |out|
  	
  	num_lines = `wc -l #{log_file}`.split(" ").first.to_i
  	cursor = num_lines # Represents the first line that has not been read

    while true do

    	num_lines = `wc -l #{log_file}`.split(" ").first.to_i # Total number of lines in the growing log file
    	logtail = `tail -n +#{cursor} #{log_file}` # Fetch all lines from the cursor to EOF
    	cursor = num_lines 						   # Advance the cursor

    	logtail.split("\n").each do |line|
    		out << "data: #{line}\n\n" unless out.closed?
    		sleep 0.02
    	end 
    	sleep 0.5
    end

  end
end
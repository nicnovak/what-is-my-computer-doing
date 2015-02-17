# What The F--- Is My Computer Doing?

*What The F--- Is My Computer Doing?* is a simple DTrace visualizer built with AngularJS. First, DTrace kernel probes are used to produce a stream of the processes currently running on your computer and which files they are accessing in real-time. Then, the stream is visualized using a simple sinatra/HTML/Angular app. 

## Getting Started

The app parases the tail of a log produced by running DTrace, so you'll first need to start up DTrace (requires sudo). In root directy of the app, run:

`sudo DTrace -n 'syscall::open*:entry { printf("[%s],%s",execname,copyinstr(arg0)); }' > dtrace.log`

Once DTrace is running and producing the log, fire up the app:

`ruby app.rb`

And navigate to `localhost:4567` in your browser. 
# What The F--- Is My Computer Doing?

*What The F--- Is My Computer Doing?* is an experiment -- a simple DTrace visualizer built with AngularJS. DTrace kernel probes are used to produce a stream of the processes that are currently running on your computer, and which files they are accessing in real-time. Then, the stream is visualized using a simple sinatra/HTML/Angular app. 

At a glance you can see which processes are actively accessing files (and how actively based on the size of the process name), as well as which files it's touching. 

Everything is shown real-time. It's useful to see what that sneaky program is doing in the background, where those pesky config files are located, and it's just plain fun to watch.

#### Watch It In Action:

![Demo](https://raw.githubusercontent.com/nicnovak/what-is-my-computer-doing/master/media/demo.gif)

## Getting Started

The app parses the tail of a log produced by running DTrace, so you'll first need to start up DTrace (requires sudo). In root directy of the app, run:

`sudo DTrace -n 'syscall::open*:entry { printf("[%s],%s",execname,copyinstr(arg0)); }' > dtrace.log`

This will start the output of DTrace into `dtrace.log`.

Once DTrace is running and producing the log, you can fire up the app:

`ruby app.rb`

And navigate to `localhost:4567` in your browser. 

## Features

Data is displayed in three columns.

-   Column 1: Shows the processes that are currently active on your computer. Processes inactive for 5 seconds will turn grey. Click a process to see what files it's accessing. Thhe process name will become larger or smaller depending on how active it is.
-   Column 2: Shows the files that are currently being accessed by the selcted process in real time. Files that have not been accessed in 5 seconds turn grey.
-   Column 3: The raw DTrace log output streams here.


## Future plans

Networking visualizer, graphical representation of files...
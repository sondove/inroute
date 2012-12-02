#inroute
Simple shell wrapper for [inotifywait] (https://github.com/rvoicilas/inotify-tools)


#Use 

Take as first argument the folder to watch. Currently only listents to modify,moved _ to,create events but this can be modified in the script.

The script also contains an array of regex -> command bindings. This is just a long bash array where every two elements are trated as the regex -> command pair.

I'm sure there are potential for incorrect shell escapes so be very careful if using this for removing or moving files.


##Example
See below for an example run using the the following command in the testdir folder: `touch testfile.txt;sleep 1;echo "A" > testfile.txt;sleep 1;mv testfile.txt testfile2.txt`


    sondove@atlas:(master)~/projects/inroute$ ./inroute.sh testdir/
    ./inroute.sh listening for modify,moved_to,create on testdir/
    
    Timestamp            Event                File                 Regex                Command                                 
    2012-12-02 23:17:16  CREATE               testfile.txt         .*                   echo "$event made to $path/$file" >> output.txt
    2012-12-02 23:17:17  MODIFY               testfile.txt         .*                   echo "$event made to $path/$file" >> output.txt
    2012-12-02 23:17:18  MOVED_TO             testfile2.txt        .*                   echo "$event made to $path/$file" >> output.txt
    ^C
    sondove@atlas:(master)~/projects/inroute$ cat output.txt 
    CREATE made to testdir//testfile.txt
    MODIFY made to testdir//testfile.txt
    MOVED_TO made to testdir//testfile2.txt
    sondove@atlas:(master)~/projects/inroute$ 


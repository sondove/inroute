inroute
=======

Simple shell wrapper for inotifywait


use 
--
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


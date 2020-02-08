
Xtract script
Version 0.2b

Beer license.  Written for the heck of it.

==========
MOTIVATION
==========

Xtract is a small program I wrote to learn the basics of TCP/IP protocols, and to address certain shortcomings and inefficiencies in the way that Wireshark handles network data. It demonstrates how Wireshark's powerful network traffic analysis capabilities may be combined with the file carving capabilities of programs such as Foremost and NetworkMiner in a manner that is portable and extensible (hence the choice of Perl).  Specifically it offers:

 1. Automated extraction of network stream sessions.  There is no way to automatically pull the contents of TCP/IP streams out of Wireshark without manually clicking through the files.  This is inefficient for large pcap files.  Xtract will pull out UDP/TCP streams and output these streams in a way that greatly facilitates browsing stream traffic.  

 2. Visualization of networks.  As far as I know Wireshark includes no capability to provide link diagrams of network activity captured in pcap files.  Xtract can use GraphViz and Pajek to generate static and interactive diagrams of network behavior.  These diagrams can offer a quick overview of the topology implicit in a network capture file.  See http://d0rkl0rd.net/->Dorkery->"Social Network Analysis On Pcap Files Using Pajek" for an example of how Pajek can be used to help visualized pcap networks.  It would be interesting to explore what other SNA techniques, if any, can be useful applied to better understanding network data. 

 3. Integration of file carving capability.  Xtract is written in a way that makes it easy to write plugins to extract artbitrary file types from captures.  A simple example of a module to extract JPEG files from network traffic is included as "jpegman.pm".  See "How to Write Additional Modules" for details on how to add these modules.


============
REQUIREMENTS
============

The script suite is intended to be highly portable and easily deployed, so requirements are minimal.  If you want to use the network display capability you will need an installation of GraphViz that includes the command-line tools.*  Otherwise any standard Perl 5 installation should be fine.:)

* If you want to open the resultant GraphViz files automatically (and are not running OSX) you will need to adjust the command for opening the *.gv file, which is customizable in xtract.conf file.  Otherwise you may get complaints about how the "open" command is missing from your system.

============
KNOWN ISSUES
============

Other than completely sucking?

Clearly, my approach of generating analytics (session dumps, network diagrams) based on unique IP addresses is flawed. Would be very interesting to cook up some sauce to (a) format tunneling activity (i.e. local:1 -> local: 2) in a meaningful way to the person doing analysis and even better (b) to write some heuristics to reconstruct tunneled channels automatically. 

Something to work on but I don't feel too bad since Wireshark sucks at this too.

* UPDATE: Took out part (a) over the weekend.  What's interesting is that even when you combine dumps from all interfaces involved in a tunnel transaction (eg client->tunneled port->SSH server->local listener) there still seems to be a "step missing" between forwarding of traffic back to the client and the forwarding to the local listener.  I was expecting to be able to perform analysis along the lines of Port A talks to Port B, Port B talks to Port C, therefore traffic involving Ports A,B,C is part of a tunnel.  Apparently I'm going to have to do more research into the mechanics of tunneling before I can figure out the right of data to visualize this activity better.  If anyone has a  bright idea about how to solve this please let me know.:)

=====
USAGE
=====

1. Before running the first time, you must set the absolute path to the "modules" directory inside the main "xtract" program.  

use lib "/path/to/xtract/modules/" -> "whatever the correct path is"

And change the $ROOT value to the directory immediately above the directory, wherever the xtract.conf file is contained.

2. type "xtract" at the command line to get a list of the main program options.  type "xtract [COMMAND]" to get a list of any sub-options available for main program options.

3. xtract.conf contains human-readable names for various TCP,UDP,ICMP,IGMP protocols according to port number, together with various commands for file creation / opening that are system-specific.  Please feel free to amplify/adjust according to your own needs.

===============================
HOW TO WRITE ADDITIONAL MODULES
===============================

Xtract is designed to maximize decentralization of program functions into separate modules "sessionman","jpegman",etc.  I find Perl's implementation of object oriented programming to be very clumsy, and so these modules are by and large simple collection of subroutines specific to a general task eg xtracting JPEG files, TCP/IP streams, etc.

The general workflow is as follows: Xtract -> send file handle to, receive file data from myIO::read_binfile -> pass file data to dataman::IsolateContents -> receive results from dataman::IsolateContents -> pass results to myIO::ReturnOuptut.  To add a new module you need to start with dataman.pm.

1. To add a new module eg "xtract [file] EXE" you would add the following line in %function_pointer:

my %function_pointer = (
           ...,
	   "EXE" => \&exeman::ProcessExe,
	   ...,);

2. Dataman calls these function pointers in the following manner:

   &$function_pointer($data_array_ref,$additional_arguments)

$data_array_ref is a pointer to an array containing pointers to the data contents of each file being examined.  Usually, for single-file data, this array will contain one scalar pointer to one file's worth of binary data: ${@$indata_ref[0]} = $indata_ref is dereferenced to an @array, $array[x] contains one scalar $pointer which is dereferenced as $$pointer by the bottom-level processor.  $additional_arguments is a pointer to any additional arguments that may have been passed from the command line.

3. Once your module receives these pointers from Dataman, it does whatever it wants to:

   sub ProcessExe {
       my $in_data_ref = shift;
       my $args_ref = shift;

       (my @EXEs) = ${@$in_data_ref[0]} =~ /(^MZ.*?)/sg;       # usually ${@$in_data_ref[0]} will suffice for single file-input.  

       # NOTE: It is very important that you use minimal matching i.e. ".*?" not ".*" to capture variable content.  Otherwise carving will fail when there are multiple instances of a file within a single document (as can easily happen in a dump of all HTTP traffic that contains multiple HTML pages, ZIP files etc)
       
       return \@EXEs;                                   # the results are passed back in the form of a pointer to an array, in an effort to minimize wasted memory

   }

4. After processing has finished, execution returns to the main Xtract program, which passes the return data to myIO::ReturnOutput for display of data.  Just as a processing function pointer has to be keyed to the program type (see step 1), an output function pointer also has to be specified in myIO's %output_function_pointer hash:

my %output_function_pointer = (
   
   ...,
   "EXE" => \&print_array_into_files,          # return .exe contents into a series of files corresponding to each element of the returned array.  The name of the file being examined is passed to myIO as the last element of ARGV.  So you can incorporate the names of the new files into the names of the old.
   ....

);

In general one of myIO's self-contained functions (print_stdout,print_array_into_files,etc) will be sufficient.  There may be cases however in which you will want to write a custom output function appropriate to whatever it is you are xtracting, as is already the case for processing pcap files; myIO::CustomOutputFunction allows you to customize output in these cases (see sessionman.pm for examples of these custom files and how to call them). 

5. Handling additional arguments is done in same way but the function pointer hashes are contained within the appropriate module.  See ipman.pm's %IP_options for an example of this and how these options are passed back to dataman.pm for processing.

6. The help strings are contained within the appropriate module as well (which is nice since it effectively serves in place of documentation within the module while at the same time providing documentation to the end user as appropriate).  myIO.pm is actually in charge of printing the strings, so you will need to add references to the help strings to %function_help and %OptionString as appropriate.  

==============
PLEASE BE NICE
==============

I am very much an amateur at this so please forgive the many gross inefficiencies.  I chose not to use the Net::pcap module because part of the point of writing this program was to teach myself how network protocols work.

That being said, I would appreciate any constructive suggestions as to things that could be added/improved.  Please send any such suggestions to dorklord3@gmail.com.  

=======
CREDITS
=======

Should give a prop to Charles Kozierok's "The TCP/IP Guide."  His clear writing and engaging presentation of an important but very dry subject were critical to getting the parsing algorithms correct.  The book is proof that even the age of ubiquitous Internet it is still worth paying good money for information conveyed effectively.

Also major kudos are due to Capcom's Mega Man series.  I never would have had the idea to call my modules "binman", "pcapman" etc if I hadn't wasted countless years of my youth obsessively trying to defeat Dr. Wiley. (and occasionally succeeding, thank you very much) 

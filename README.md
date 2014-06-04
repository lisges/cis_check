CIS Check Information Gatherer
=========

This script provides an "API" for the CIS, since there is none as of right now. This document shall specify the functions.


##Documentation##

The backend script requires the following PERL modules:
```WWW::Mechanize, Getopt::Long, Term::ReadPassword```

For Ubuntu users:
```sudo aptitude install libgetopt-long-descriptive-perl libwww-mechanize-perl libterm-readpassword-perl```

###CLI###

Example:
```./cis_check.pl  --validate --username [user] --password [pass]```

```
Options:
--username      to specify username from outside the script
--password      to specify username from outside the script
--verbose       verbose output
--validate      valdiate login data only, don't do any checks (Will return 0 in case of success, other return codes imply failure)
--devmode	Interactive password prompt
```



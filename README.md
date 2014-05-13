CIS Check Backend
=========

This Repo provides the Backend for the CIS Check website. The scripts here will kind of provide a API for the CIS, since there is none as of right now. This document shall specify the functions anda database structure needed.


##Documentation##

The backend script requires the following PERL modules:
```WWW::Mechanize, Getopt::Long ```

For Ubuntu users:
```sudo aptitude install libgetopt-long-descriptive-perl libwww-mechanize-perl```

###CLI###

Example:
```./cis_check.pl  --validate --username [user] --password [pass]```

```
Options:
--username      to specify username from outside the script
--password      to specify username from outside the script
--verbose       verbose output
--validate      valdiate login data only, don't do any checks (Will return 0 in case of success, other return codes imply failure)
```



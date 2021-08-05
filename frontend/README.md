in theme.php

line 35 :
- 2.3.2 : `<link href="<?php echo $path; ?>Lib/bootstrap/css/bootstrap.css" rel="stylesheet">`
- 3.0.0 : `<link href="<?php echo $path; ?>Lib/bootstrap/3.0.0/css/bootstrap.css" rel="stylesheet">`
- tested with version 3.3.4, 3.3.5, 3.3.7, 4.0.0, 4.2.0 : not working

5.1.0 : `<link href="<?php echo $path; ?>Lib/bootstrap/bootstrap.css" rel="stylesheet">`

line 104 or 105 :
- 2.3.2 :   `<script type="text/javascript" src="<?php echo $path; ?>Lib/bootstrap/js/bootstrap.js"></script>`
- 3.0.0 :   `<script type="text/javascript" src="<?php echo $path; ?>Lib/bootstrap/3.0.0/js/bootstrap.js"></script>`

5.1.0 : `<script type="text/javascript" src="<?php echo $path; ?>Lib/bootstrap/bootstrap.js"></script>`


line 40 or 41 : 
- `<script type="text/javascript" src="<?php echo $path; ?>Lib/jquery-1.11.3.min.js"></script>`
- `<script type="text/javascript" src="<?php echo $path; ?>Lib/jquery-3.6.0.js"></script>`

jquery 1.11.3 has security issues
https://snyk.io/test/npm/jquery/1.11.3

it seems bootstrap 2.3.2 is OK

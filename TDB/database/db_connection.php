<?php

function openCon()
{
    if (_PS_ROOT_DIR_ == '/var/www/vhosts/dev3-sportmidable.publipresse.ovh/httpdocs') {
        $dbhost = 'localhost';
        $dbuser = 'bd_dev3-sportmidable';
        $dbpass = '3_51nfaL';
        $db = 'bd_dev3-sportmidable';
    } else {
        $dbhost = 'localhost';
        $dbuser = 'boutique';
        $dbpass = '3kBrWJNlDr1oT1i!vds987j!';
        $db = 'boutique';
    }
    $conn = new mysqli($dbhost, $dbuser, $dbpass, $db) or die("Connect failed: %s\n".$conn->error);
    return $conn;
}

function closeCon($conn)
{
    $conn->close();
}



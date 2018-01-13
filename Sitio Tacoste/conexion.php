<?php
/**
 * Conexión a Oracle 11g XE.
 */
    $user = "";
    $passwd = "";
    $sid = "localhost/XE";
    $connection = oci_connect($user, $passwd, $sid);
?>
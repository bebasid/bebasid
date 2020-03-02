<?php

// --- INTRODUCTION ---
// PHP HOSTS SCANNER
// ONLY WORK WITH PHP-CLI
// REQUIREMENTS: PHP 5 AND DNSUTILS (DEB) OR BIND-UTILS (RHEL)

// --- HOW TO USE ---
// RUN WITH COMMAND "php unblock.php yourfile.txt"
// CHANGE "yourfile.txt" WITH YOUR FILE

// --- INFO ---
// SPLIT TXT FILE TO 100000 LINES EACH FILE
// BECAUSE MORE THAN IT MAKE TIMEOUT

// --- COPYRIGHT ---
// PALGUNO WICAKSONO
// 2019
// ALL RIGHTS RESERVED

function domaintoip($host, $timeout = 1) {
   $query = `nslookup -timeout=$timeout -retry=1 $host`;
   if(preg_match('/\nAddress: (.*)\n/', $query, $matches))
      return trim($matches[1]);
}

function count_line($file) {
    set_time_limit(3600);
    ini_set('memory_limit', '-1');
    $arr = file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    $c = ( false === $arr) ? 0 : count($arr);
    return $c;
}

if(empty($argv[1]){
  echo "use command php scanner.php listdomainyangingindiunblock.txt";
  die();
 }

$file = $argv[1];
$t = -microtime(1);
$alllines = count_line($file);
if($alllines > 100000){
  echo "SPLIT YOUR FILE TO 100000 LINES OR IT WILL MAKE TIMEOUT \r\n";
  die();
}else{
  $lines = count_line($file);
  $filenamee = 'hosts-'.$file;
  $line = 0;
  while($lines>0){
    $spl = new SplFileObject($file);
    $spl->seek($line);
    $domain = $spl->current();
    $hias = strtoupper($domain);
    $ip = domaintoip($domain);
    if(!(empty($ip))){
      $hostsfile = new SplFileObject($filenamee, 'a');
      //$hostsfile = fopen("hosts","a");
      $newhosts = '
# ['.trim(strtoupper($domain)).']
'.$ip.' '.$domain;
      echo "
[+] ======= UNBLOCKING DOMAIN ======= [+]

DOMAIN  : $hias
IP      : $ip

LINE	: $line / $alllines
[+] ============ SUCCESS ============ [+]";
      $hostsfile->fwrite($newhosts);
      $line++;
      $lines--;
    }else{
      $line++;
      $lines--;
      $alllines--;
    }
  }
}
echo "Done Unblocking \r\n";
exit();
?>

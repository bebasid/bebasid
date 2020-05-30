<?php

// ODOL
// BEBASID AUTO FIX HOST
// CREATED BY HAIBARA

function domaintoip($host, $timeout = 1){
    $query = `nslookup -timeout=$timeout -retry=1 $host`;
    if (preg_match('/\nAddress: (.*)\n/', $query, $matches)) return trim($matches[1]);
}

function count_line($file){
    set_time_limit(300);
    ini_set('memory_limit', '-1');
    $arr = file($file);
    $c = (false === $arr) ? 0 : count($arr);
    set_time_limit(30); // restore to default
    ini_set('memory_limit', '128M'); // restore to default
    return $c;
}

unlink("hosts-temp");
unlink("domain.txt");
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_HEADER, 0);
$out = curl_exec($ch);
curl_close($ch);
$fp = fopen('domain.txt', 'w');
fwrite($fp, $out);
fclose($fp);
$file = "domain.txt";
$result = "hosts-temp";
$t = - microtime(1);
$file_lines = count_line($file);
$file_line = 1;
while ($file_lines > 1){
    $spl = new SplFileObject($file);
    $spl->seek($file_line);
    if (in_array($spl->current() [0], ['#'])){
        $newhosts = $spl->current();
        $hostsfile = new SplFileObject($result, 'a');
        $hostsfile->fwrite($newhosts);
        echo $file_line . " [Normal] <br>";
    }elseif (trim($spl->current() [0]) == ''){
        $newhosts = "\n";
        $hostsfile = new SplFileObject($result, 'a');
        $hostsfile->fwrite($newhosts);
        echo $file_line . " [Empty] <br>";
    }else{
        $domain = preg_split('/[\s]+/', $spl->current());
        $multidomain = count($domain);
        if ($multidomain > 3){
            $grabber = 0;
            if (filter_var($domain[$grabber], FILTER_VALIDATE_IP)){
                $grabber++;
            }
            while ($grabber != $multidomain){
                $ip = domaintoip($domain[$grabber]);
                if (empty($ip)){
                    $grabber++;
                }else{
                    $domaine = $domain[$grabber];
                    /*foreach(new SplFileObject($result, 'a') as $lineNumber => $lineContent) {
                    $pos = strpos($lineContent, $ip);
                    echo $pos;
                    if(strpos($lineContent, $ip !== FALSE)){
                    echo $lineNumber; // zero-based
                    echo "mumet ndase";
                    }
                    }*/
                    $newhosts = $ip . ' ' . $domaine;
                    $hostsfile = fopen($result, "a");
                    fwrite($hostsfile, $newhosts);
                    fclose($hostsfile);
                    if ($grabber < $multidomain - 1){
                        $newhosts = "\n";
                        $hostsfile = new SplFileObject($result, 'a');
                        $hostsfile->fwrite($newhosts);
                    }
                    echo $file_line . " [Success] <br>";
                    echo "Total Subdomain: " . $multidomain;
                    $grabber++;
                }
            }
        }else{
            $grabber = 0;
            if (filter_var($domain[$grabber], FILTER_VALIDATE_IP)){
                $grabber++;
            }
            $ip = domaintoip($domain[$grabber]);
            if (empty($ip)){
                $grabber++;
            }else{
                $domaine = $domain[$grabber];
                /*foreach(new SplFileObject($result) as $lineNumber => $lineContent) {
                    $pos = strpos($lineContent, $ip);
                    echo $pos;
                    if(strpos($lineContent, $ip !== FALSE)){
                    echo $lineNumber; // zero-based
                    echo "mumet ndase";
                    }
                }*/
                $newhosts = $ip . ' ' . $domaine;
                $hostsfile = fopen($result, "a");
                fwrite($hostsfile, $newhosts);
                fclose($hostsfile);
                $newhosts = "\n";
                $hostsfile = new SplFileObject($result, 'a');
                $hostsfile->fwrite($newhosts);
                echo $file_line . " [Success] <br>";
                $grabber++;
            }
        }
    }
    $file_line++;
    $file_lines--;
}
rename("hosts-temp", "hosts");
?>

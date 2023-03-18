<?php

function createTree($dir, $depth = 0) {
    $tree = "";

    $dirs = array_filter(glob($dir . '/*'), 'is_dir');
    sort($dirs);

    foreach ($dirs as $d) {
        $dirName = basename($d);

        // Exclude directories that match the pattern task-*
        if (preg_match('/^task/', $dirName)) {
            continue;
        }

        $link = str_replace(' ', '-', strtolower($dirName));
        $indent = str_repeat('  ', $depth+1);

        $tree .= "$indent- [$dirName](#$link)\n";

        if (!empty(glob("$d/*"))) {
            $tree .= createTree($d, $depth + 1);
        }
    }

    return $tree;
}

function createTable($taskCount, $link) {
    $table = "| No of Tasks |                                            | \n";
    $table .= "|---------|--------------------------------------------|\n";
    $table .= sprintf("|%9d|%44s|\n", $taskCount, $link);
    return $table;
}





$tree = createTree("home");

$content = "- [home](#home)\n$tree";

echo $content;


$stringArray = explode("\n", $content);

$body="";

foreach($stringArray as $line) {
    $output="";
    $outputIsTaskFolderExist="";
    echo "\n";
    $hyphenCount=0;
    if (empty($line))
        continue;
    $line=str_replace(' ', '-', $line);
    // echo "\nLine under consideration $line ";
    $parts = explode('[', $line);
    if (array_key_exists(0,$parts)) {
        $hyphenCount=substr_count($parts[0], '-');
        // echo "Hyphencount : $hyphenCount";
        if (array_key_exists(1,$parts)) {
            $hashes=($hyphenCount)/2;

            $title = substr($parts[1], 0, strpos($parts[1], ']'));
            // echo " Title : $title";
            // echo str_repeat('#', $hashes) . ' ' . $title;
            $body = $body."\n".str_repeat('#', $hashes) . ' ' . $title;

            exec("find . -name $title", $output);
            // $dirName = "$title";
            // $matchingDirectories = findDirectory($title);
            // print_r($matchingDirectories);
            // print_r($output);

            # Assuming only one folder exists with the name
            // print($output[0]);
            // Print the output
            foreach ($output as $line) {
                // echo $line . PHP_EOL;
                exec("(ls -ltrh $line | egrep task | wc -l)",$outputIsTaskFolderExist);
                // print($outputIsTaskFolderExist[0]);
                $table=createTable($outputIsTaskFolderExist[0],$line);
                // echo $table;
            }

            $body = $body."\n".$table;
        }
        else {
            
            echo "No part1 found when line is $line";
        }
    }
    else {
        echo "No part0 found";
    }
    



}

echo "Body is : $body";

$content = $content."\n".$body;
file_put_contents("README.md", $content);

#markdown-table-formatter
# npm install markdown-table-formatter -g
# https://github.com/nvuillam/markdown-table-formatter


// echo "Done!\n";

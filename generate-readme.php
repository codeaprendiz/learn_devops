<?php

$global_readme="";

// $ ls -ltrh home | egrep -v "total" | awk '{print "\"" $9 "\","}'
$languages = array(
    "container-orchestration",
    "devops-blogs",
    "infrastructure-as-code",
    "observability",
    "web-servers",
    "version-control",
    "databases",
    "monitoring-kitchen",
    "images",
    "os-and-concepts",
    "cloud-providers",
    "programming-languages",
    "productivity-tools",
    "containers",
    "interview",
);

function getDirectories($directoryPath, $pattern) {
    $directoryIterator = new RecursiveDirectoryIterator($directoryPath, RecursiveDirectoryIterator::SKIP_DOTS);
    $recursiveIterator = new RecursiveIteratorIterator($directoryIterator, RecursiveIteratorIterator::CHILD_FIRST);

    $directories = [];

    foreach($recursiveIterator as $path) {
        if ($path->isDir() && preg_match($pattern, $path->getFilename())) {
            $directories[] = $path->getPathname();
        }
    }

    // Sort the array
    sort($directories);
    return $directories;
}

// Function that create a global global_readme.md file
function createGlobalglobal_readme($languages) {
    $global_readme = "# Learn DevOps\n\n";

    $taskDirectories = array_merge(getDirectories('.', '/task-/'), getDirectories('.', '/task_/'));


    print_r($taskDirectories);



    file_put_contents('Readme-test.md', $global_readme);
}

createGlobalglobal_readme($languages);

?>
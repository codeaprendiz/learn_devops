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
    $global_readme = "# Learn Fullstack\n\n";

    $taskDirectories = array_merge(getDirectories('.', '/task-/'), getDirectories('.', '/task_/'));


    // echo '<pre>'; print_r($taskDirectories); echo '</pre>';

    // Print total number of tasks completed in the ReadMe.md file

    $global_readme .= ">Total number of tasks: " . count($taskDirectories) . "\n\n";

    $global_readme .= "## Languages\n\n";

    $global_readme .= "Click on individual language for more detailed information\n\n";

    foreach($languages as $language) {
        $global_readme .= "- [" . $language . "](" . $language . ")" . "\n";
    }


    foreach($languages as $language) {
        $global_readme .= "\n## " . $language . "\n\n";
        foreach($taskDirectories as $taskDirectory) {
            // $taskDirectory is of form - [281] => ./reactjs/taskset/task-004-eslint-setup
            // if $taskDirectory does not contain the language string, continue
            if (strpos($taskDirectory, "./".$language) === false) {
                continue;
            }

            // save only the task-004-eslint-setup part of the path in a new variable without changing the $taskDirectory by getting the part after last /
            
            $taskName = substr($taskDirectory, strrpos($taskDirectory, '/') + 1);
            $global_readme .= "- [" . $taskName . "](" . $taskDirectory . "/"  . ")\n";
        }
    }

    file_put_contents('Readme.md', $global_readme);
}

createGlobalglobal_readme($languages);

?>
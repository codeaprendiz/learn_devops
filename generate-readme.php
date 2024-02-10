<?php

/**
 * Generates a tree structure of directories and subdirectories.The createTree function takes two arguments: $directoryPath and $directoryRegex. 
 * @param string $directoryPath represents the path of the directory for which the tree structure is generated. 
 * @param string $directoryRegex is an optional argument that defines the regular expression pattern used to include directories in the tree structure (default value is /^task-/)
 * @return string The tree structure as a string.
 */
function createTree_v1($directoryPath = './', $directoryRegex = '/^task_/')
{
    $tree = [];

    $directoriesArray = array_filter(
                                    glob($directoryPath . '/*'),
                                    'is_dir'
                                    );


    sort($directoriesArray);

    foreach ($directoriesArray as $directory) {
        $dirName = trim(
            basename($directory)
            );

        if (preg_match($directoryRegex, $dirName)) {
            $realPath = realpath($directory);
            $relativePath = substr($realPath, strpos($realPath, 'home'));
            $pathParts = explode(DIRECTORY_SEPARATOR, $relativePath);
            $parentDir = $pathParts[count($pathParts) - 2];

            if (!isset($tree[$parentDir])) {
                $tree[$parentDir] = [];
            }

            $tree[$parentDir][] = "$dirName $relativePath";
        }

        if (!empty(glob("$directory/*"))) {
            $tree = array_merge($tree, createTree_v1($directory));
        }
    }

    return $tree;
}




function createIndividualSectionsMarkdown($tree)
{
    foreach ($tree as $key => $value) {
        $markdown = '';
        preg_match('/home\/.*?(?=\/task_)/', $value[0], $matches);
        $readMeFileDir = $matches[0];
        $readMeFileDir = substr($readMeFileDir, 0, strrpos($readMeFileDir, '/'));
        $markdown .= "## $key\n\n> Auto generated ReadMe\n\n";
        $markdown .= "| Task | Description |\n";
        $markdown .= "| --- | --- |\n";
        foreach ($value as $task) {
            $taskNumber = substr($task, strpos($task, 'task_'), 8);
            $taskNumber = str_replace('-', '', $taskNumber);
            
            $columnLink=explode(' ', $task);
            $columnText=$columnLink[0];
            $columnLink = explode('/', $columnLink[1]);
            $lastElement=end($columnLink);
            $secondLastElement = $columnLink[count($columnLink) - 2];
            $columnLink = "$secondLastElement/$lastElement";
            $markdown .= "| $taskNumber | [$columnText]($columnLink) |\n";
        }
        $markdown .= "\n";


        file_put_contents($readMeFileDir . '/ReadMe.md', $markdown);
    }
}

function createGlobalMarkdownTable($tree) {

    $markdown = "# Home \n\n> Auto generated ReadMe\n\n";

    // ls -ltrh home | egrep -v "total" | awk '{print "\"" $9 "\","}' | sort
    $topics = array(
        "cloud_certifications",
        "cloud_providers",
        "containers",
        "databases",
        "infrastructure_as_code",
        "interview",
        "observability",
        "os_and_concepts",
        "productivity_tools",
        "web_servers",
    );
    
    foreach ($topics as $topic) {
        $view_text=$topic;
        $view_text = str_replace('_', ' ', $view_text);
        $view_text = ucwords($view_text);
        $topic = ucwords($topic);
        $markdown .= "- [$view_text](#$topic)\n";
    }

    $markdown .= "\n";
    
    foreach ($topics as $topic) {
        $matchingKeys = array_filter(
            array_keys($tree),
            function ($key) use ($topic) {
                return strpos($key, $topic) !== false;
            }
        );

        if (empty($matchingKeys)) {
            continue;
        }

        $topic = ucwords($topic);
        $markdown .= "## $topic\n\n";

        $markdown .= "|";
        foreach ($matchingKeys as $matchingKey) {
            
            $matchingKey = explode('_', $matchingKey);
            $matchingKey = array_slice($matchingKey, 1);
            $matchingKey = implode('_', $matchingKey);
            // remove _$topic from $matchingKey, make $topc lowercase before replacing
            $topic = strtolower($topic);
            $matchingKey = str_replace("_$topic", '', $matchingKey);
            $matchingKey = ucwords($matchingKey);
            $markdown .= " $matchingKey |";
            
        }
        $markdown .= "\n";
        $markdown .= "|";
        foreach ($matchingKeys as $matchingKey) {
            $markdown .= " --- |";
        }

        $markdown .= "\n";
        $markdown .= "|";
        foreach ($matchingKeys as $matchingKey) {
            preg_match('/home\/.*?(?=\/task_)/', $tree[$matchingKey][0], $matches);
            $readMeFileDir = $matches[0];
            $readMeFileDir = substr($readMeFileDir, 0, strrpos($readMeFileDir, '/'));
            $linkToDir = $readMeFileDir;
            $markdown .= " [Practice Tasks]($linkToDir) |";
        }

        $markdown .= "\n\n";

        // All caps certain words in markdown like AWS, GCP, OS etc
        $markdown = str_replace('Aws', 'AWS', $markdown);
        $markdown = str_replace('Oci', 'OCI', $markdown);
        $markdown = str_replace('Gcp', 'GCP', $markdown);
        $markdown = str_replace('Os', 'OS', $markdown);


    }

    return $markdown;

}

$tree = createTree_v1('.', '/^task_/'); // if first call is for ".", second call is for "./home" and so on as the function is recursive

// print_r($tree);

createIndividualSectionsMarkdown($tree);

$markdown=createGlobalMarkdownTable($tree);
// Put markdown in README-test.md file
file_put_contents('ReadMe.md', $markdown);

?>

<?php

/**
 * Generates a tree structure of directories and subdirectories.The createTree function takes two arguments: $directoryPath and $directoryRegex. 
 * @param string $directoryPath represents the path of the directory for which the tree structure is generated. 
 * @param string $directoryRegex is an optional argument that defines the regular expression pattern used to include directories in the tree structure (default value is /^task-/)
 * @return string The tree structure as a string.
 */
function createTree_v1($directoryPath = './', $directoryRegex = '/^task_/')
{
    $tree = [];  // Initialize an empty array to store the tree structure

    $directoriesArray = array_filter( // Get all subdirectories within the given directory, If you give ./home as the directory path, then the glob function will return an array of all subdirectories within the home directory i.e [0] => ./home/cloud-certifications, [1] => ./home/cloud-providers etc. 
                                    glob($directoryPath . '/*'), // The glob() function scans the directory specified by $directoryPath and returns an array of matching file and directory paths.
                                    'is_dir' //  The returned array contains the paths of all subdirectories within the given directory because the is_dir parameter is used as the second argument of array_filter(). 
                                    ); // This means that only the directory paths from the result of glob() will be included in the final filtered array.
    // Result: $directoriesArray contains all directories within the given $directoryPath


    sort($directoriesArray);   // Sort the directories in ascending order

    foreach ($directoriesArray as $directory) {
        $dirName = trim(  // $directory is the full path of the directory as returned by glob(). This could be something like ./home/cloud-certifications/aws/taskset_aws_cloud_certifications/task-001-aws-certified-solutions-architect-professional.
            basename($directory) // basename($directory) is used to get the name of the actual directory (i.e., the last part of the path), without the preceding directory structure. So, from the above example, basename($directory) would return task-001-aws-certified-solutions-architect-professional.
            ); // so if $directory is './home/cloud_certifications/aws/taskset_aws_cloud_certifications/task-001-aws-certified-solutions-architect-professional', then $dirName is 'task-001-aws-certified-solutions-architect-professional'

        if (preg_match($directoryRegex, $dirName)) { // If the directory name starts with 'task_'
            $realPath = realpath($directory); // Get the full, absolute path of the directory
            // e.g. '/full/path/to/taskset_aws_cloud_certifications_aws_cloud_certifications'

            // trim everything until 'home' from beginning of relativePath
            $relativePath = substr($realPath, strpos($realPath, 'home'));
            // e.g. 'home/cloud_certifications/aws/taskset_aws_cloud_certifications/task-001-aws-certified-solutions-architect-professional'

            $pathParts = explode(DIRECTORY_SEPARATOR, $relativePath); // Split the path into parts
            // e.g. ['home', 'cloud_certifications', 'aws', 'taskset_aws_cloud_certifications', 'task-001-aws-certified-solutions-architect-professional']

            $parentDir = $pathParts[count($pathParts) - 2]; // The parent directory is the second last part
            // e.g. 'taskset_aws_cloud_certifications'

            if (!isset($tree[$parentDir])) {
                // If the parent directory is not set in the tree array, then initialize it as an empty array
                $tree[$parentDir] = [];
            }

            $tree[$parentDir][] = "$dirName $relativePath";
            // Add a markdown link of the directory to the array of its parent directory in the tree array.
            // e.g. 'taskset' => ['- [task-001-aws-certified-solutions-architect-professional](home/cloud_certifications/aws/taskset/task-001-aws-certified-solutions-architect-professional)']
        }

        if (!empty(glob("$directory/*"))) {
            $tree = array_merge($tree, createTree_v1($directory));
            // If the directory has subdirectories, recursively add them to the tree.
        }
    }

    return $tree; // Return the tree
}


// Function to create markdown in following format
// ## Cloud Providers
//
// | AWS | OCI | GCP |
// | --- | --- | --- |
// | [Certification Digest](home/cloud-providers/aws/certifications-digest)<br> [Practice Tasks](home/cloud-providers/aws/practice-tasks) | [Practice Tasks](home/cloud-providers/oci/practice-tasks) | [Practice Tasks](home/cloud-providers/gcp/taskset) |
//  When the  tree[][] contains
//     [taskset_aws_cloud_providers] => Array
//         (
//             [0] => - [task_001_kms](home/cloud_providers/aws/taskset_aws_cloud_providers/task_001_kms)
//             [1] => - [task_002_monitoring_msk](home/cloud_providers/aws/taskset_aws_cloud_providers/task_002_monitoring_msk)
//             [2] => - [task_003_redirection_using_s3_cloudfront](home/cloud_providers/aws/taskset_aws_cloud_providers/task_003_redirection_using_s3_cloudfront)
//         )

function createMarkdown($tree)
{
    foreach ($tree as $key => $value) {
        $markdown = '';
        preg_match('/home\/.*?(?=\/task_)/', $value[0], $matches); // home\/: This looks for the characters "home/" in the string. The backslash \ before the / is an escape character, because / is a special character in regex. .*?: The dot . matches any character except a newline. The * means "match zero or more of the preceding element". The ? after * makes the * "lazy", meaning it matches as few characters as possible. Without ?, * is "greedy" and matches as many characters as possible.   (?=\/task_): This is a positive lookahead. It checks that the characters "/task_" follow the match, but it doesn't include these characters in the match. So, overall, this regex starts matching at "home/", then matches as few characters as possible until it encounters "/task_", which it checks for but doesn't include in the match. A positive lookahead in regular expressions is a type of lookahead assertion that ensures certain characters exist after the current match point, without including those characters in the match itself. Here's the general syntax: (?=...), where the ellipsis is replaced with the pattern you're looking for. For example, in the regular expression John(?= Smith), (?= Smith) is a positive lookahead. This regular expression will match the string "John" only if it's followed by " Smith". However, " Smith" is not part of the overall regex match.
        $readMeFileDir = $matches[0];  // 'home/containers/kubernetes/concepts'
        $markdown .= "## $key\n\n";
        $markdown .= "| Task | Description |\n";
        $markdown .= "| --- | --- |\n";
        foreach ($value as $task) {
            // Get the task number i.e. task-001 from the task name i.e. task-001-aws-certified-solutions-architect-professional
            $taskNumber = substr($task, strpos($task, 'task_'), 8);
            // remove the '-' from the task number
            $taskNumber = str_replace('-', '', $taskNumber);

            
            $columnLink=explode(' ', $task); // $task = task_007_show_grants_user home/databases/mysql/taskset_mysql_databases/task_007_show_grants_userArray; columnLink = Array ( [0] => task_007_show_grants_user [1] => home/databases/mysql/taskset_mysql_databases/task_007_show_grants_user )
            $columnText=$columnLink[0]; // $columnText = task_007_show_grants_user
            $columnLink = explode('/', $columnLink[1]); // $columnLink = Array ( [0] => home [1] => databases [2] => mysql [3] => taskset_mysql_databases [4] => task_007_show_grants_user
            $columnLink=end($columnLink); // $columnLink = task_007_show_grants_user
            $markdown .= "| $taskNumber | [$columnText]($columnLink) |\n";
        }
        $markdown .= "\n";

        // Write the markdown content to the README.md file in the directory
        file_put_contents($readMeFileDir . '/ReadMe.md', $markdown);
    }
}



// Usage
$tree = createTree_v1('.', '/^task_/'); // if first call is for ".", second call is for "./home" and so on as the function is recursive

// print_r($tree);

$markdown = createMarkdown($tree);

// Put markdown in README-test.md file
file_put_contents('README-test.md', $markdown);


?>

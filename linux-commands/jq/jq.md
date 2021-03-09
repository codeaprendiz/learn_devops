## jq

[jq](http://manpages.ubuntu.com/manpages/bionic/man1/jq.1.html)

jq - Command-line JSON processor

### SYNOPSIS

> jq [options...] filter [files...]


### EXAMPLES

Let the json be

```bash
$ json='{"commit_id": "b8f2b8b", "environment": "test", "tags_at_commit": "sometags", "project": "someproject", "current_date": "09/10/2014", "version": "someversion"}'

$ echo $json | jq
{
  "commit_id": "b8f2b8b",
  "environment": "test",
  "tags_at_commit": "sometags",
  "project": "someproject",
  "current_date": "09/10/2014",
  "version": "someversion"
}

$ echo $json | jq '.'         
{
  "commit_id": "b8f2b8b",
  "environment": "test",
  "tags_at_commit": "sometags",
  "project": "someproject",
  "current_date": "09/10/2014",
  "version": "someversion"
}

$ echo $json | jq '.commit_id'
"b8f2b8b"
```
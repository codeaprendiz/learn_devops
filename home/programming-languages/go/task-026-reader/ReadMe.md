# Reader

[https://go.dev/tour/methods/22](https://go.dev/tour/methods/22)

```bash
go run reader.go                            
n = 8, err = <nil>, b = [72 101 108 108 111 32 87 111]
b[:n] = "Hello Wo"
n = 4, err = <nil>, b = [114 108 100 46 111 32 87 111]
b[:n] = "rld."
n = 0, err = EOF, b = [114 108 100 46 111 32 87 111]
b[:n] = ""
```
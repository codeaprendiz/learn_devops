## Docker

What is docker ?

<details>

- Set of [platform as a service](https://en.wikipedia.org/wiki/Platform_as_a_service) products

- Uses [OS-level virtualization](https://en.wikipedia.org/wiki/OS-level_virtualization) to deliver software in packages called containers

- Containers are isolated from one another and bundle their own software, libraries and configuration files

- they can communicate with each other through well-defined channels

</details>


[What are Containers?](https://cloud.google.com/containers#:~:text=Containers%20give%20developers%20the%20ability,runtimes%20and%20other%20software%20libraries.)

<details>

- containers are only isolated groups of processes running on a single host, which fulfill a set of “common” features [reference-link](https://medium.com/@saschagrunert/demystifying-containers-part-i-kernel-space-2c53d6979504)

- standard unit of software 
- packages up code and all its dependencies 
- so the application runs quickly and reliably from one computing environment to another
OR

- offer a logical packaging mechanism
- applications can be abstracted from the environment in which they actually run

</details>


[Why Containers? Why not VMs]((https://cloud.google.com/containers#:~:text=Containers%20give%20developers%20the%20ability,runtimes%20and%20other%20software%20libraries.))

<details>

- containers are far more lightweight vs VMs

- they share the OS kernel, start much faster vs VMs

- use a fraction of the memory compared to booting an entire OS.

</details>

[When to use VMs Vs Containers](https://www.redhat.com/en/topics/containers/containers-vs-vms)

<details>

- House traditional, legacy, and monolothic workloads

- Provision infrastructural resources (such as networks, servers, and data)

- Run a different OS inside another OS (such as running Unix on Linux)

</details>



By default what is the memory limit for a docker container?

<details>

</details>


How can you set a limit on the container memory in docker?

<details>

</details>

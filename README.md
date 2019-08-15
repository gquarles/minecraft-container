# Minecraft Container
This is a Docker image that will automatically download and run the latest version of Minecraft Server from [Mojangs website](https://www.minecraft.net/en-us/download/server/)


## Installation

Pull the latest image from [Docker Hub](https://cloud.docker.com/u/gquarles/repository/docker/gquarles/minecraft)

```bash
docker pull gquarles/minecraft
```

## Running

```bash
docker run -it -v [VOLUME]:/server -p [PORT]:25565 gquarles/minecraft
```



## License
[MIT](https://choosealicense.com/licenses/mit/)

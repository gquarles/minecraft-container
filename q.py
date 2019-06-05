import docker

client = docker.from_env()

container = client.containers.list()
print(container)

#container.exec_run('screen -S server -p 0 -X stuff "say hi^M"')
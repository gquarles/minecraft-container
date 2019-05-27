import docker

client = docker.from_env()

container = client.containers.get('46ac1ab6b97b')

container.exec_run('screen -S server -p 0 -X stuff "say hi^M"')
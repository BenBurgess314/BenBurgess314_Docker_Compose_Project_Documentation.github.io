# Docker Project Documentation
*by Ben Burgess*

## Step 1: My app

I made a Unity game in high school and hosted in on my Github pages.  I decided to turn this into a Docker container because I can.

- The repo can be found at 
  - https://github.com/PiChessMaster/ninjakart2.git
- and is hosted on 
  - https://pichessmaster.github.io/ninjakart2/

I cloned the repo to my local machine and made a simple ngninx dockerfile, as follows:

`FROM nginx:alpine`

`COPY ./ninjakart /usr/share/nginx/html`

`RUN chmod +x /usr/share/nginx/html/Build`

That last line is because that folder needs execute permissions for nginx to be able to serve its files.

And a simple docker-compose.yml file, as follows:

- `services:`
  - `ninjakart:`
    - `build: .`
    - `container_name: ninjakart`
    - `ports:`
      - `- "8080:80"`
    - `restart: unless-stopped`

## Step 2: Transfer it to the Proxmox VM

I have to start openssh running on the Proxmox VM, so that I can scp stuff to it.

So, I `dnf install openssh` and `systemctl [enable+start+status] sshd` to get that running.

I `ip a` to remind myself that my IP address is `10.30.20.103` on the Proxmox VM, and **scp** all the files to it.

## Step 3: Actually start it

I had to install `podman` (a docker compose alternative) first, with the following code:

`dnf update`

`dnf install epel-release`

`dnf install podman-compose`

And then spun up the container with

`podman compose up -d`

`podman ps`

Pretty simple really, although I had to update dnf first which took a while.

Also, I needed to open port 8080 on the firewall with:

`firewall-cmd --permanent --add-port=tcp/8080`

`firewall-cmd --reload`

Then, on our host machine, I can connect to the game via:

http://10.30.20.103:8080

And play ninjakart!

![Screenshot of game running, showing a ninja on a racetrack](ExampleRunning.png)

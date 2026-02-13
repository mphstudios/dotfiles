# Nushell configuration overlay for Kamal
# @see https://kamal-deploy.org/docs/installation/

export def main [] {
  (docker run --interactive --tty --rm
    --volume $"($env.PWD):/workdir"
    --volume "/run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock"
    --volume /var/run/docker.sock:/var/run/docker.sock
    --env SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock"
    ghcr.io/basecamp/kamal:latest)
}

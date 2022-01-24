job "artbot" {
    datacenters = ["dc1"]

    group "artbot" {
        task "bot" {
            driver = "docker"

            config {
                image = "ghcr.io/tag-epic/artbot/artbot:9cd4e4013a5dd35f9287b2d722dd33a9e53039ee"
            }

            resources {
                cpu    = 100
                memory = 100
            }
            template {
                data = <<EOF
                    {{ with secret "kv/artbot" }}
                    TOKEN={{.Data.data.token}}
                    {{ end }}
                EOF
                destination = "local/env"
                env         = true
            }
        }
    }
}

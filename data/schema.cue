import "time"

#stages: "active_development" | "bugs" | "security" | "critical_security" | "active_lts" | "maintenance_lts" | "community_lts" | "commercial_lts" | "end_of_life"

type:         "language" | "runtime" | "os" | "utility"
name:         string
description?: string
homepage?:    string

#references_keys: "lifecycle" | #stages
#references: [#references_keys]: string
references: #references

#command_keys: "codename" | "version"
#commands: [#command_keys]: string
commands?: #commands

#lifecycle_aliases: [#stages]: string
lifecycle_aliases?: #lifecycle_aliases

#versions: {
	semver:    string
	codename?: string
	references?: [...string]
	lifecycle: [#stages]: {
		date: time.Format("2006") | time.Format("2006-01") | time.Format("2006-01-02")
		architectures?: [...string]
	}
}
versions: [...#versions]

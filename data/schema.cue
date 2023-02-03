import "time"

#stages: "active_development" | "bugs" | "security" | "critical_security" | "active_lts" | "maintenance_lts" | "community_lts" | "commercial_lts" | "end_of_life"

type:         "language" | "library" | "runtime" | "os" | "utility"
subtype?:     string
name:         string
description?: string
homepage?:    string

#references_keys: "lifecycle" | #stages
#references: [#references_keys]: string
references: #references

#command_keys: "codename" | "version"
#commands: [#command_keys]: [...string]
commands?: #commands

#lifecycle_aliases: [#stages]: string
lifecycle_aliases?: #lifecycle_aliases

#version_number: string

// @see https://github.com/cue-lang/cue/issues/407
#semver: string

// @example
// {
//   // ...
//   "versions": [{
//     "semver": "^1.0",
//     "codename": "Geranium",
//     "references": [
//       "https://example.org"
//     ],
//     "lifecycle": {
//       "active_development": {
//         "date": "2010-01-01"
//       },
//       "end_of_life": {
//         "date": "2015-12-31"
//       }
//     }
//   }]
// }
#versions: {
	semver:    #semver
	codename?: string
	references?: [...string]
	lifecycle: [#stages]: {
		// @note For `active_development`, `date` is the date the version was
		//   given `semver` series was first released. For all other lifecycle
		//   stages `date` is the date the given `semver` series transitioned to
		//   the given stage.
		date: time.Format("2006") | time.Format("2006-01") | time.Format("2006-01-02")
		// @example Debian
		// [
		//   "amd64",
		//   "i386"
		// ]
		architectures?: [...string]
		// An exact list of known sub-versions (point releases or patches). Each
		// sub-version must match the specified `semver`.
		//
		// @example Ruby 2.6
		// [
		//   "2.6.0",
		//   "2.6.1",
		//   "2.6.2",
		//   "2.6.3",
		//   "2.6.4",
		//   "2.6.5",
		//   "2.6.6",
		//   "2.6.7",
		//   "2.6.8",
		// ]
		releases?: [...#version_number]
	}
}
versions: [...#versions]

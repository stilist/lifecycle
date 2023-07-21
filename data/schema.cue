import "time"

#stages: "active_development" | "bugs" | "security" | "critical_security" | "active_lts" | "maintenance_lts" | "community_lts" | "commercial_lts" | "end_of_life"

type:         "language" | "library" | "runtime" | "os" | "utility"
subtype?:     string
name:         string
description?: string
homepage?:    string

#references_keys: "lifecycle" | "release_history" | #stages
#references: [#references_keys]: string
references: #references

#command: [...string]
commands: {
	// Return codename, if set.
	codename?: #command
	// Check if the current data file is relevant--mostly useful for OS data
	// files. (For example, there's no point checking an Alpine install against
	// a Ubuntu data file.)
	//
	// If `relevance_filter` is declared for a given data file, the data file's
	// version data will only be used if `relevance_filter`'s command exits with
	// the status code `0`.
	relevance_filter?: #command
	// Return semver-compatible version number.
	version: #command
}

#lifecycle_aliases: [#stages]: string
lifecycle_aliases?: #lifecycle_aliases

#date: time.Format("2006") | time.Format("2006-01") | time.Format("2006-01-02")

#version_number: string
#release:        #version_number

// @see https://github.com/cue-lang/cue/issues/407
#semver: string

// @example
// {
//   // ...
//   "versions": [{
//     "semver": "1.0.x",
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
	lifecycle?: [#stages]: {
		// @note For `active_development`, `date` is the date the version was
		//   given `semver` series was first released. For all other lifecycle
		//   stages `date` is the date the given `semver` series transitioned to
		//   the given stage.
		date: #date
		// @example Debian
		// [
		//   "amd64",
		//   "i386"
		// ]
		architectures?: [...string]
	}
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
	//   "2.6.8"
	// ]
	releases?: [...#release]
}
versions: [...#versions]

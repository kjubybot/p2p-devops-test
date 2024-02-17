package infra

import "tool/cli"

import "encoding/yaml"

_objects: [
	for x in [namespace, serviceAccount, role, roleBinding]
	for v in x {v},
]

command: dump: cli.Print & {
	text: yaml.MarshalStream(_objects)
}

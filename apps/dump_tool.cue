package apps

import (
	"tool/cli"
	"encoding/yaml"
)

_objects: [for _, v in apps {v}]

command: dump: cli.Print & {
	text: yaml.MarshalStream(_objects)
}
